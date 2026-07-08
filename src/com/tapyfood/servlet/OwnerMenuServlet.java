package com.tapyfood.servlet;

import com.tapyfood.dao.MenuDAO;
import com.tapyfood.dao.RestaurantDAO;
import com.tapyfood.dao.impl.MenuDAOImpl;
import com.tapyfood.dao.impl.RestaurantDAOImpl;
import com.tapyfood.model.MenuItem;
import com.tapyfood.model.Restaurant;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/owner/menu")
public class OwnerMenuServlet extends HttpServlet {

    private RestaurantDAO restaurantDAO;
    private MenuDAO menuDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
        menuDAO = new MenuDAOImpl();
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

        if (r == null) {
            resp.sendRedirect(req.getContextPath() + "/owner/dashboard");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            resp.sendRedirect(req.getContextPath() + "/owner/dashboard");
            return;
        }

        try {
            if ("add".equals(action)) {
                String name = req.getParameter("name");
                String category = req.getParameter("category");
                double price = Double.parseDouble(req.getParameter("price"));
                String description = req.getParameter("description");
                String imageUrl = req.getParameter("imageUrl");
                boolean isVeg = "true".equals(req.getParameter("isVeg"));

                MenuItem item = new MenuItem(0, r.getId(), name, category, price, description, imageUrl, isVeg);
                menuDAO.addMenuItem(item);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                MenuItem item = menuDAO.getMenuItemById(id);

                if (item != null && item.getRestaurantId() == r.getId()) {
                    String name = req.getParameter("name");
                    String category = req.getParameter("category");
                    double price = Double.parseDouble(req.getParameter("price"));
                    String description = req.getParameter("description");
                    String imageUrl = req.getParameter("imageUrl");
                    boolean isVeg = "true".equals(req.getParameter("isVeg"));

                    item.setName(name);
                    item.setCategory(category);
                    item.setPrice(price);
                    item.setDescription(description);
                    item.setImageUrl(imageUrl);
                    item.setVeg(isVeg);

                    menuDAO.updateMenuItem(item);
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                MenuItem item = menuDAO.getMenuItemById(id);

                if (item != null && item.getRestaurantId() == r.getId()) {
                    menuDAO.deleteMenuItem(id);
                }
            }
        } catch (Exception e) {
            System.err.println("[OwnerMenuServlet] Error: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/owner/dashboard");
    }
}
