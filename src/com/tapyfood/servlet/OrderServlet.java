package com.tapyfood.servlet;

import com.tapyfood.dao.CartDAO;
import com.tapyfood.dao.OrderDAO;
import com.tapyfood.dao.CouponDAO;
import com.tapyfood.dao.impl.CartDAOImpl;
import com.tapyfood.dao.impl.OrderDAOImpl;
import com.tapyfood.dao.impl.CouponDAOImpl;
import com.tapyfood.model.CartItem;
import com.tapyfood.model.Order;
import com.tapyfood.model.OrderItem;
import com.tapyfood.model.Coupon;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/orders", "/checkout"})
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private CartDAO  cartDAO;
    private CouponDAO couponDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
        cartDAO  = new CartDAOImpl();
        couponDAO = new CouponDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String path = req.getServletPath();

        if ("/orders".equals(path)) {
            List<Order> orders = orderDAO.getOrdersByUserId(userId);
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/orders.jsp").forward(req, resp);

        } else if ("/checkout".equals(path)) {
            List<CartItem> cartItems = cartDAO.getCartByUserId(userId);
            if (cartItems.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }
            double total = cartItems.stream().mapToDouble(CartItem::getSubtotal).sum();
            
            // Check if coupon FIRSTRY is applied
            Coupon appliedCoupon = (Coupon) session.getAttribute("appliedCoupon");
            boolean isFirstryApplied = (appliedCoupon != null && "FIRSTRY".equals(appliedCoupon.getCode()));
            
            double deliveryFee = isFirstryApplied ? 0.0 : 40.0;
            double platformFee = isFirstryApplied ? 0.0 : 10.0;

            // Handle coupon flash messages and session data
            String couponError = (String) session.getAttribute("couponError");
            if (couponError != null) {
                req.setAttribute("couponError", couponError);
                session.removeAttribute("couponError");
            }
            
            Double couponDiscount = (Double) session.getAttribute("couponDiscount");
            if (couponDiscount == null) {
                couponDiscount = 0.0;
            }
            
            List<Coupon> availableCoupons = couponDAO.getAvailableCouponsForCart(userId);
            
            // Filter out coupons that have reached their usage limit
            int firstryUsage = couponDAO.getCouponUsageCount(userId, "FIRSTRY");
            int welcome50Usage = couponDAO.getCouponUsageCount(userId, "WELCOME50");
            List<Coupon> filteredCoupons = new ArrayList<>();
            for (Coupon c : availableCoupons) {
                if ("FIRSTRY".equals(c.getCode()) && firstryUsage >= 2) {
                    continue;
                }
                if ("WELCOME50".equals(c.getCode()) && welcome50Usage >= 1) {
                    continue;
                }
                filteredCoupons.add(c);
            }
            availableCoupons = filteredCoupons;
            
            req.setAttribute("cartItems", cartItems);
            req.setAttribute("cartTotal", total);
            req.setAttribute("couponDiscount", couponDiscount);
            req.setAttribute("appliedCoupon", appliedCoupon);
            req.setAttribute("availableCoupons", availableCoupons);
            req.setAttribute("deliveryFee", deliveryFee);
            req.setAttribute("platformFee", platformFee);
            
            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String action = req.getParameter("action");

        if ("complete".equals(action)) {
            String orderIdStr = req.getParameter("orderId");
            if (orderIdStr != null) {
                try {
                    int orderId = Integer.parseInt(orderIdStr);
                    orderDAO.updateOrderStatus(orderId, "Delivered");
                } catch (NumberFormatException ignored) {}
            }
            resp.sendRedirect(req.getContextPath() + "/orders");
            return;
        }

        String deliveryAddress = req.getParameter("deliveryAddress");

        if (deliveryAddress == null || deliveryAddress.trim().isEmpty()) {
            req.setAttribute("error", "Delivery address is required.");
            doGet(req, resp);
            return;
        }

        List<CartItem> cartItems = cartDAO.getCartByUserId(userId);
        if (cartItems.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        double subtotal = cartItems.stream().mapToDouble(CartItem::getSubtotal).sum();
        
        // Check if coupon FIRSTRY is applied
        Coupon appliedCoupon = (Coupon) session.getAttribute("appliedCoupon");
        boolean isFirstryApplied = (appliedCoupon != null && "FIRSTRY".equals(appliedCoupon.getCode()));
        
        double deliveryFee = isFirstryApplied ? 0.0 : 40.0;
        double platformFee = isFirstryApplied ? 0.0 : 10.0;
        
        double couponDiscount = 0.0;
        Double sessionDiscount = (Double) session.getAttribute("couponDiscount");
        if (sessionDiscount != null) {
            couponDiscount = sessionDiscount;
        }
        
        double totalAmount = subtotal + deliveryFee + platformFee - couponDiscount;

        Order order = new Order();
        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setStatus("Placed");
        order.setDeliveryAddress(deliveryAddress.trim());
        if (appliedCoupon != null) {
            order.setCouponCode(appliedCoupon.getCode());
        }

        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem ci : cartItems) {
            OrderItem oi = new OrderItem();
            oi.setMenuId(ci.getMenuId());
            oi.setQuantity(ci.getQuantity());
            oi.setPrice(ci.getPrice());
            orderItems.add(oi);
        }

        int orderId = orderDAO.placeOrder(order, orderItems);

        if (orderId > 0) {
            cartDAO.clearCart(userId);
            session.removeAttribute("appliedCoupon");
            session.removeAttribute("couponDiscount");
            resp.sendRedirect(req.getContextPath() + "/success?orderId=" + orderId);
        } else {
            req.setAttribute("error", "Order placement failed. Please try again.");
            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
        }
    }
}