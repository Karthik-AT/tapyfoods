package com.tapyfood.servlet;

import com.tapyfood.dao.RestaurantDAO;
import com.tapyfood.dao.impl.RestaurantDAOImpl;
import com.tapyfood.model.Restaurant;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/restaurant")
public class AdminRestaurantServlet extends HttpServlet {

    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        try {
            if ("add".equals(action)) {
                String name = req.getParameter("name");
                String cuisineType = req.getParameter("cuisineType");
                double rating = Double.parseDouble(req.getParameter("rating"));
                String deliveryTime = req.getParameter("deliveryTime");
                String location = req.getParameter("location");
                String imageUrl = req.getParameter("imageUrl");
                String offerBadge = req.getParameter("offerBadge");
                String description = req.getParameter("description");
                String ownerIdStr = req.getParameter("ownerId");
                Integer ownerId = (ownerIdStr != null && !ownerIdStr.isEmpty()) ? Integer.parseInt(ownerIdStr) : null;

                Restaurant r = new Restaurant(0, name, cuisineType, rating, deliveryTime, location, imageUrl, offerBadge, description, ownerId);
                restaurantDAO.addRestaurant(r);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                String cuisineType = req.getParameter("cuisineType");
                double rating = Double.parseDouble(req.getParameter("rating"));
                String deliveryTime = req.getParameter("deliveryTime");
                String location = req.getParameter("location");
                String imageUrl = req.getParameter("imageUrl");
                String offerBadge = req.getParameter("offerBadge");
                String description = req.getParameter("description");
                String ownerIdStr = req.getParameter("ownerId");
                Integer ownerId = (ownerIdStr != null && !ownerIdStr.isEmpty()) ? Integer.parseInt(ownerIdStr) : null;

                Restaurant r = new Restaurant(id, name, cuisineType, rating, deliveryTime, location, imageUrl, offerBadge, description, ownerId);
                restaurantDAO.updateRestaurant(r);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                restaurantDAO.deleteRestaurant(id);
            }
        } catch (Exception e) {
            System.err.println("[AdminRestaurantServlet] Error: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }
}
