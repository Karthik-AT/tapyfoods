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

        String search = req.getParameter("search");
        String category = req.getParameter("category");

        List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();

        if ((search != null && !search.trim().isEmpty()) || (category != null && !category.trim().isEmpty() && !"all".equalsIgnoreCase(category))) {
            List<Restaurant> filtered = new java.util.ArrayList<>();
            String searchLower = (search != null) ? search.trim().toLowerCase() : "";
            String categoryLower = (category != null) ? category.trim().toLowerCase() : "";

            for (Restaurant r : restaurants) {
                String name = r.getName() != null ? r.getName().toLowerCase() : "";
                String cuisine = r.getCuisineType() != null ? r.getCuisineType().toLowerCase() : "";

                boolean matchesSearch = searchLower.isEmpty() || name.contains(searchLower) || cuisine.contains(searchLower);
                boolean matchesCategory = categoryLower.isEmpty() || "all".equals(categoryLower) || cuisine.contains(categoryLower);

                if (matchesSearch && matchesCategory) {
                    filtered.add(r);
                }
            }
            restaurants = filtered;
        }

        req.setAttribute("restaurants", restaurants);
        req.setAttribute("searchParam", search);
        req.setAttribute("categoryParam", category);
        req.getRequestDispatcher("/restaurants.jsp").forward(req, resp);
    }
}