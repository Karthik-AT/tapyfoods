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
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    private RestaurantDAO restaurantDAO;
    private MenuDAO       menuDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
        menuDAO       = new MenuDAOImpl();
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

        Restaurant     restaurant = restaurantDAO.getRestaurantById(restaurantId);
        List<MenuItem> menuItems  = menuDAO.getMenuByRestaurantId(restaurantId);

        if (restaurant == null) {
            resp.sendRedirect(req.getContextPath() + "/restaurants");
            return;
        }

        req.setAttribute("restaurant", restaurant);
        req.setAttribute("menuItems",  menuItems);

        req.getRequestDispatcher("/menu.jsp").forward(req, resp);
    }
}