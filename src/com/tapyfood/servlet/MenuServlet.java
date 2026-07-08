package com.tapyfood.servlet;

import com.tapyfood.dao.MenuDAO;
import com.tapyfood.dao.RestaurantDAO;
import com.tapyfood.dao.CartDAO;
import com.tapyfood.dao.impl.MenuDAOImpl;
import com.tapyfood.dao.impl.RestaurantDAOImpl;
import com.tapyfood.dao.impl.CartDAOImpl;
import com.tapyfood.model.MenuItem;
import com.tapyfood.model.Restaurant;
import com.tapyfood.model.CartItem;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    private RestaurantDAO restaurantDAO;
    private MenuDAO       menuDAO;
    private CartDAO       cartDAO;
    private com.tapyfood.dao.CouponDAO   couponDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
        menuDAO       = new MenuDAOImpl();
        cartDAO       = new CartDAOImpl();
        couponDAO     = new com.tapyfood.dao.impl.CouponDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String param = req.getParameter("restaurantId");

        if (param == null || param.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/restaurants");
            return;
        }

        int restaurantId;
        try {
            restaurantId = Integer.parseInt(param);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/restaurants");
            return;
        }

        String category = req.getParameter("category");
        if (category == null || category.trim().isEmpty()) {
            category = "all";
        }

        Restaurant     restaurant = restaurantDAO.getRestaurantById(restaurantId);
        List<MenuItem> menuItems  = menuDAO.getMenuByRestaurantId(restaurantId);

        if (restaurant == null) {
            resp.sendRedirect(req.getContextPath() + "/restaurants");
            return;
        }

        if (!"all".equalsIgnoreCase(category)) {
            List<MenuItem> filtered = new java.util.ArrayList<>();
            for (MenuItem m : menuItems) {
                if (category.equalsIgnoreCase(m.getCategory())) {
                    filtered.add(m);
                }
            }
            menuItems = filtered;
        }

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            int userId = (int) session.getAttribute("userId");
            List<CartItem> cartItems = cartDAO.getCartByUserId(userId);
            req.setAttribute("cartItems", cartItems);
        }

        List<com.tapyfood.model.Coupon> coupons = couponDAO.getCouponsByRestaurantId(restaurantId);
        List<com.tapyfood.model.Coupon> activeCoupons = new java.util.ArrayList<>();
        java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());
        for (com.tapyfood.model.Coupon c : coupons) {
            if (c.isActive() && c.getStartTime().before(now) && c.getEndTime().after(now)) {
                activeCoupons.add(c);
            }
        }
        req.setAttribute("coupons", activeCoupons);

        req.setAttribute("restaurant", restaurant);
        req.setAttribute("menuItems",  menuItems);
        req.setAttribute("categoryParam", category);

        req.getRequestDispatcher("/menu.jsp").forward(req, resp);
    }
}