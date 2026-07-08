package com.tapyfood.servlet;

import com.tapyfood.dao.MenuDAO;
import com.tapyfood.dao.OrderDAO;
import com.tapyfood.dao.RestaurantDAO;
import com.tapyfood.dao.CouponDAO;
import com.tapyfood.dao.impl.MenuDAOImpl;
import com.tapyfood.dao.impl.OrderDAOImpl;
import com.tapyfood.dao.impl.RestaurantDAOImpl;
import com.tapyfood.dao.impl.CouponDAOImpl;
import com.tapyfood.model.MenuItem;
import com.tapyfood.model.Order;
import com.tapyfood.model.Restaurant;
import com.tapyfood.model.Coupon;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/owner/dashboard")
public class OwnerDashboardServlet extends HttpServlet {

    private RestaurantDAO restaurantDAO;
    private MenuDAO menuDAO;
    private OrderDAO orderDAO;
    private CouponDAO couponDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
        menuDAO = new MenuDAOImpl();
        orderDAO = new OrderDAOImpl();
        couponDAO = new CouponDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int ownerId = (Integer) session.getAttribute("userId");
        Restaurant restaurant = restaurantDAO.getRestaurantByOwnerId(ownerId);

        if (restaurant != null) {
            List<MenuItem> menuItems = menuDAO.getMenuByRestaurantId(restaurant.getId());
            List<Order> orders = orderDAO.getOrdersByRestaurantId(restaurant.getId());
            double revenue = orderDAO.getRevenueByRestaurantId(restaurant.getId());
            List<Coupon> coupons = couponDAO.getCouponsByRestaurantId(restaurant.getId());

            req.setAttribute("restaurant", restaurant);
            req.setAttribute("menuItems", menuItems);
            req.setAttribute("orders", orders);
            req.setAttribute("revenue", revenue);
            req.setAttribute("coupons", coupons);
        } else {
            req.setAttribute("restaurant", null);
        }

        req.getRequestDispatcher("/owner/dashboard.jsp").forward(req, resp);
    }
}
