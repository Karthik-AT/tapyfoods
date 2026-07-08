package com.tapyfood.servlet;

import com.tapyfood.dao.UserDAO;
import com.tapyfood.dao.impl.UserDAOImpl;
import com.tapyfood.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            String role = (String) session.getAttribute("userRole");
            if ("admin".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else if ("restaurant_owner".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/owner/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/restaurants");
            }
            return;
        }
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        User user = userDAO.validateLogin(email.trim(), password);

        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("userId",   user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userRole",  user.getRole());
            session.setMaxInactiveInterval(60 * 60);  // 1 hour session

            String role = user.getRole();
            if ("admin".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else if ("restaurant_owner".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/owner/dashboard");
            } else {
                String redirect = req.getParameter("redirect");
                if (redirect != null && !redirect.isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/" + redirect);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/restaurants");
                }
            }
        } else {
            req.setAttribute("error", "Invalid email or password. Please try again.");
            req.setAttribute("enteredEmail", email);
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}