package com.tapyfood.servlet;

import com.tapyfood.dao.CartDAO;
import com.tapyfood.dao.CouponDAO;
import com.tapyfood.dao.impl.CartDAOImpl;
import com.tapyfood.dao.impl.CouponDAOImpl;
import com.tapyfood.model.CartItem;
import com.tapyfood.model.Coupon;
import com.tapyfood.util.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;

@WebServlet({"/coupon/apply", "/coupon/remove"})
public class CouponServlet extends HttpServlet {

    private CouponDAO couponDAO;
    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {
        couponDAO = new CouponDAOImpl();
        cartDAO = new CartDAOImpl();
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
        String path = req.getServletPath();

        if ("/coupon/remove".equals(path)) {
            session.removeAttribute("appliedCoupon");
            session.removeAttribute("couponDiscount");
            resp.sendRedirect(req.getContextPath() + "/checkout");
            return;
        }

        if ("/coupon/apply".equals(path)) {
            String code = req.getParameter("couponCode");
            if (code == null || code.trim().isEmpty()) {
                session.setAttribute("couponError", "Please enter a coupon code.");
                resp.sendRedirect(req.getContextPath() + "/checkout");
                return;
            }

            Coupon coupon = couponDAO.getCouponByCode(code.trim().toUpperCase());

            if (coupon == null || !coupon.isActive()) {
                session.setAttribute("couponError", "Invalid or inactive coupon code.");
                resp.sendRedirect(req.getContextPath() + "/checkout");
                return;
            }

            // Check if user has already used the FIRSTRY welcome coupon 2 times
            if ("FIRSTRY".equals(coupon.getCode())) {
                int usageCount = couponDAO.getCouponUsageCount(userId, "FIRSTRY");
                if (usageCount >= 2) {
                    session.setAttribute("couponError", "You have already used the code FIRSTRY the maximum of 2 times.");
                    resp.sendRedirect(req.getContextPath() + "/checkout");
                    return;
                }
            }

            // Check if user has already used the WELCOME50 coupon 1 time
            if ("WELCOME50".equals(coupon.getCode())) {
                int usageCount = couponDAO.getCouponUsageCount(userId, "WELCOME50");
                if (usageCount >= 1) {
                    session.setAttribute("couponError", "You have already used the code WELCOME50 the maximum of 1 time.");
                    resp.sendRedirect(req.getContextPath() + "/checkout");
                    return;
                }
            }

            // 1. Time-based validity check
            Timestamp now = new Timestamp(System.currentTimeMillis());
            if (now.before(coupon.getStartTime())) {
                session.setAttribute("couponError", "This coupon is not active yet.");
                resp.sendRedirect(req.getContextPath() + "/checkout");
                return;
            }
            if (now.after(coupon.getEndTime())) {
                session.setAttribute("couponError", "This coupon has expired.");
                resp.sendRedirect(req.getContextPath() + "/checkout");
                return;
            }

            // Get cart subtotal
            List<CartItem> cartItems = cartDAO.getCartByUserId(userId);
            if (cartItems.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }
            double cartSubtotal = cartItems.stream().mapToDouble(CartItem::getSubtotal).sum();

            // 2. Minimum order amount check
            if (cartSubtotal < coupon.getMinOrderAmount()) {
                session.setAttribute("couponError", "Minimum order subtotal of ₹" + String.format("%.0f", coupon.getMinOrderAmount()) + " is required to use this coupon.");
                resp.sendRedirect(req.getContextPath() + "/checkout");
                return;
            }

            // 3. Restaurant-specific check (if coupon has restaurantId set)
            if (coupon.getRestaurantId() != null) {
                int couponRestId = coupon.getRestaurantId();
                boolean belongs = false;

                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    con = DBConnection.getConnection();
                    // Count items in the user's cart that do NOT belong to the coupon's restaurant
                    String query = "SELECT COUNT(*) FROM cart c JOIN menu m ON c.menu_id = m.id WHERE c.user_id = ? AND m.restaurant_id != ?";
                    ps = con.prepareStatement(query);
                    ps.setInt(1, userId);
                    ps.setInt(2, couponRestId);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        int mismatchCount = rs.getInt(1);
                        if (mismatchCount == 0) {
                            belongs = true;
                        }
                    }
                } catch (Exception e) {
                    System.err.println("[CouponServlet] restaurant matching check failed: " + e.getMessage());
                } finally {
                    try { if (rs != null) rs.close(); } catch(Exception ignored){}
                    try { if (ps != null) ps.close(); } catch(Exception ignored){}
                    try { if (con != null) con.close(); } catch(Exception ignored){}
                }

                if (!belongs) {
                    session.setAttribute("couponError", "This coupon is only valid for items from a different restaurant.");
                    resp.sendRedirect(req.getContextPath() + "/checkout");
                    return;
                }
            }

            // 4. Calculate discount
            double discount = 0.0;
            if ("flat".equalsIgnoreCase(coupon.getDiscountType())) {
                discount = coupon.getDiscountValue();
            } else if ("percentage".equalsIgnoreCase(coupon.getDiscountType())) {
                discount = cartSubtotal * (coupon.getDiscountValue() / 100.0);
            }

            // Prevent discount from exceeding the subtotal
            if (discount > cartSubtotal) {
                discount = cartSubtotal;
            }

            session.setAttribute("appliedCoupon", coupon);
            session.setAttribute("couponDiscount", discount);
            session.removeAttribute("couponError");

            resp.sendRedirect(req.getContextPath() + "/checkout");
        }
    }
}
