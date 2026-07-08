package com.tapyfood.servlet;

import com.tapyfood.dao.UserDAO;
import com.tapyfood.dao.impl.UserDAOImpl;
import com.tapyfood.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

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
            resp.sendRedirect(req.getContextPath() + "/restaurants");
            return;
        }
        req.getRequestDispatcher("/signup.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name     = req.getParameter("name");
        String email    = req.getParameter("email");
        String password = req.getParameter("password");
        String phone    = req.getParameter("phone");
        String address  = req.getParameter("address");

        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.length() < 6) {

            req.setAttribute("error", "Please fill all fields. Password must be at least 6 characters.");
            req.setAttribute("enteredName",  name);
            req.setAttribute("enteredEmail", email);
            req.getRequestDispatcher("/signup.jsp").forward(req, resp);
            return;
        }

        User existing = userDAO.getUserByEmail(email.trim());
        if (existing != null) {
            req.setAttribute("error", "An account with this email already exists. Please log in.");
            req.setAttribute("enteredName",  name);
            req.setAttribute("enteredEmail", email);
            req.getRequestDispatcher("/signup.jsp").forward(req, resp);
            return;
        }

        String role = req.getParameter("role");

        User newUser = new User();
        newUser.setName(name.trim());
        newUser.setEmail(email.trim());
        newUser.setPassword(password);          // hash in production!
        newUser.setPhone(phone != null ? phone.trim() : "");
        newUser.setAddress(address != null ? address.trim() : "");
        newUser.setRole(role != null ? role.trim() : "customer");

        boolean registered = userDAO.registerUser(newUser);

        if (registered) {
            // Auto-login after registration
            User created = userDAO.getUserByEmail(email.trim());
            HttpSession session = req.getSession(true);
            session.setAttribute("userId",    created.getId());
            session.setAttribute("userName",  created.getName());
            session.setAttribute("userEmail", created.getEmail());
            session.setAttribute("userRole",  created.getRole());
            session.setMaxInactiveInterval(60 * 60);

            if ("restaurant_owner".equals(created.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/owner/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/restaurants");
            }
        } else {
            req.setAttribute("error", "Registration failed. Please try again.");
            req.getRequestDispatcher("/signup.jsp").forward(req, resp);
        }
    }
}