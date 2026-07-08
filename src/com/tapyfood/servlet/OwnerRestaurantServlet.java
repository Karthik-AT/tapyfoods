package com.tapyfood.servlet;

import com.tapyfood.dao.RestaurantDAO;
import com.tapyfood.dao.impl.RestaurantDAOImpl;
import com.tapyfood.model.Restaurant;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/owner/restaurant")
public class OwnerRestaurantServlet extends HttpServlet {

    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int ownerId = (Integer) session.getAttribute("userId");
        Restaurant r = restaurantDAO.getRestaurantByOwnerId(ownerId);

        if (r != null) {
            String action = req.getParameter("action");
            if ("toggleStatus".equals(action)) {
                r.setActive(!r.isActive());
                restaurantDAO.updateRestaurant(r);
            } else {
                String name = req.getParameter("name");
                String cuisineType = req.getParameter("cuisineType");
                String deliveryTime = req.getParameter("deliveryTime");
                String location = req.getParameter("location");
                String imageUrl = req.getParameter("imageUrl");
                String offerBadge = req.getParameter("offerBadge");
                String description = req.getParameter("description");

                r.setName(name);
                r.setCuisineType(cuisineType);
                r.setDeliveryTime(deliveryTime);
                r.setLocation(location);
                r.setImageUrl(imageUrl);
                r.setOfferBadge(offerBadge);
                r.setDescription(description);

                restaurantDAO.updateRestaurant(r);
            }
        }

        resp.sendRedirect(req.getContextPath() + "/owner/dashboard");
    }
}
