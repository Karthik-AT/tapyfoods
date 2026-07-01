package com.tapyfood.servlet;

import com.tapyfood.dao.OrderDAO;
import com.tapyfood.dao.impl.OrderDAOImpl;
import com.tapyfood.model.Order;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/success")
public class SuccessServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String orderIdParam = req.getParameter("orderId");
        if (orderIdParam != null) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                Order order = orderDAO.getOrderById(orderId);
                req.setAttribute("order", order);

                // Calculate per-user order number (how many orders this user has)
                int userId = (int) session.getAttribute("userId");
                int userOrderCount = orderDAO.getOrdersByUserId(userId).size();
                req.setAttribute("userOrderCount", userOrderCount);

            } catch (NumberFormatException ignored) {}
        }

        req.getRequestDispatcher("/success.jsp").forward(req, resp);
    }
}