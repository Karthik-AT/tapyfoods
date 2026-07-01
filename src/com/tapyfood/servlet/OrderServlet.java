package com.tapyfood.servlet;

import com.tapyfood.dao.CartDAO;
import com.tapyfood.dao.OrderDAO;
import com.tapyfood.dao.impl.CartDAOImpl;
import com.tapyfood.dao.impl.OrderDAOImpl;
import com.tapyfood.model.CartItem;
import com.tapyfood.model.Order;
import com.tapyfood.model.OrderItem;

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

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
        cartDAO  = new CartDAOImpl();
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
            req.setAttribute("cartItems", cartItems);
            req.setAttribute("cartTotal", total);
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

        double totalAmount = cartItems.stream().mapToDouble(CartItem::getSubtotal).sum();
        double deliveryFee = 40.0;
        totalAmount += deliveryFee;

        Order order = new Order();
        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setStatus("Placed");
        order.setDeliveryAddress(deliveryAddress.trim());

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
            resp.sendRedirect(req.getContextPath() + "/success?orderId=" + orderId);
        } else {
            req.setAttribute("error", "Order placement failed. Please try again.");
            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
        }
    }
}