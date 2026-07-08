package com.tapyfood.servlet;

import com.tapyfood.dao.OrderDAO;
import com.tapyfood.dao.impl.OrderDAOImpl;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/owner/order")
public class OwnerOrderServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String status = req.getParameter("status");

            if (status != null && !status.trim().isEmpty()) {
                orderDAO.updateOrderStatus(orderId, status.trim());
            }
        } catch (Exception e) {
            System.err.println("[OwnerOrderServlet] Error updating status: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/owner/dashboard");
    }
}
