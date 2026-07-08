package com.tapyfood.servlet;

import com.tapyfood.dao.OrderDAO;
import com.tapyfood.dao.RestaurantDAO;
import com.tapyfood.dao.UserDAO;
import com.tapyfood.dao.CouponDAO;
import com.tapyfood.dao.impl.OrderDAOImpl;
import com.tapyfood.dao.impl.RestaurantDAOImpl;
import com.tapyfood.dao.impl.UserDAOImpl;
import com.tapyfood.dao.impl.CouponDAOImpl;
import com.tapyfood.model.Restaurant;
import com.tapyfood.model.User;
import com.tapyfood.model.Coupon;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private RestaurantDAO restaurantDAO;
    private UserDAO userDAO;
    private OrderDAO orderDAO;
    private CouponDAO couponDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
        userDAO = new UserDAOImpl();
        orderDAO = new OrderDAOImpl();
        couponDAO = new CouponDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();
        List<User> unassignedOwners = userDAO.getUnassignedOwners();
        List<com.tapyfood.model.Order> allOrders = orderDAO.getAllOrders();
        double totalRevenue = orderDAO.getTotalRevenue();
        List<Coupon> coupons = couponDAO.getAllCoupons();

        req.setAttribute("restaurants", restaurants);
        req.setAttribute("unassignedOwners", unassignedOwners);
        req.setAttribute("allOrders", allOrders);
        req.setAttribute("totalRevenue", totalRevenue);
        req.setAttribute("coupons", coupons);

        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}
