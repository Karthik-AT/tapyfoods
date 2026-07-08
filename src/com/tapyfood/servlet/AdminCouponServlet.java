package com.tapyfood.servlet;

import com.tapyfood.dao.CouponDAO;
import com.tapyfood.dao.impl.CouponDAOImpl;
import com.tapyfood.model.Coupon;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/admin/coupon")
public class AdminCouponServlet extends HttpServlet {

    private CouponDAO couponDAO;

    @Override
    public void init() throws ServletException {
        couponDAO = new CouponDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                String code = req.getParameter("code").trim().toUpperCase();
                String discountType = req.getParameter("discountType");
                double discountValue = Double.parseDouble(req.getParameter("discountValue"));
                double minOrderAmount = Double.parseDouble(req.getParameter("minOrderAmount"));

                String restIdStr = req.getParameter("restaurantId");
                Integer restaurantId = (restIdStr == null || restIdStr.trim().isEmpty()) ? null : Integer.parseInt(restIdStr);

                String startStr = req.getParameter("startTime").replace("T", " ") + ":00";
                String endStr = req.getParameter("endTime").replace("T", " ") + ":00";
                Timestamp startTime = Timestamp.valueOf(startStr);
                Timestamp endTime = Timestamp.valueOf(endStr);

                Coupon c = new Coupon(0, code, discountType, discountValue, restaurantId, startTime, endTime, minOrderAmount, true);
                couponDAO.addCoupon(c);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String code = req.getParameter("code").trim().toUpperCase();
                String discountType = req.getParameter("discountType");
                double discountValue = Double.parseDouble(req.getParameter("discountValue"));
                double minOrderAmount = Double.parseDouble(req.getParameter("minOrderAmount"));
                boolean active = "true".equals(req.getParameter("active"));

                String restIdStr = req.getParameter("restaurantId");
                Integer restaurantId = (restIdStr == null || restIdStr.trim().isEmpty()) ? null : Integer.parseInt(restIdStr);

                String startStr = req.getParameter("startTime").replace("T", " ") + ":00";
                String endStr = req.getParameter("endTime").replace("T", " ") + ":00";
                Timestamp startTime = Timestamp.valueOf(startStr);
                Timestamp endTime = Timestamp.valueOf(endStr);

                Coupon c = couponDAO.getCouponById(id);
                if (c != null) {
                    c.setCode(code);
                    c.setDiscountType(discountType);
                    c.setDiscountValue(discountValue);
                    c.setRestaurantId(restaurantId);
                    c.setStartTime(startTime);
                    c.setEndTime(endTime);
                    c.setMinOrderAmount(minOrderAmount);
                    c.setActive(active);
                    couponDAO.updateCoupon(c);
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                couponDAO.deleteCoupon(id);
            }
        } catch (Exception e) {
            System.err.println("[AdminCouponServlet] operation failed: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }
}
