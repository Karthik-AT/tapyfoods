package com.tapyfood.servlet;

import com.tapyfood.dao.RestaurantDAO;
import com.tapyfood.dao.impl.RestaurantDAOImpl;
import com.tapyfood.model.Restaurant;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/restaurants")
public class RestaurantServlet extends HttpServlet {

    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();
        req.setAttribute("restaurants", restaurants);
        req.getRequestDispatcher("/restaurants.jsp").forward(req, resp);
    }
}