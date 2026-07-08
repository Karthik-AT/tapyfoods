package com.tapyfood.servlet;

import com.tapyfood.dao.CartDAO;
import com.tapyfood.dao.impl.CartDAOImpl;
import com.tapyfood.model.CartItem;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Must be logged in to view cart
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            if ("true".equals(req.getParameter("ajax"))) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resp.getWriter().write("{\"error\":\"unauthorized\"}");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/login?redirect=cart");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        List<CartItem> cartItems = cartDAO.getCartByUserId(userId);

        if ("true".equals(req.getParameter("ajax"))) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(toJson(cartItems));
            return;
        }

        double total = cartItems.stream().mapToDouble(CartItem::getSubtotal).sum();

        req.setAttribute("cartItems", cartItems);
        req.setAttribute("cartTotal", total);

        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            if ("true".equals(req.getParameter("ajax"))) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resp.getWriter().write("{\"error\":\"unauthorized\"}");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/login?redirect=cart");
            return;
        }

        int    userId = (int) session.getAttribute("userId");
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            handleAdd(req, resp, userId);
        } else if ("update".equals(action)) {
            handleUpdate(req, resp);
        } else if ("remove".equals(action)) {
            handleRemove(req, resp);
        }

        if ("true".equals(req.getParameter("ajax"))) {
            List<CartItem> cartItems = cartDAO.getCartByUserId(userId);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(toJson(cartItems));
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws IOException {
        try {
            int menuId   = Integer.parseInt(req.getParameter("menuId"));
            int quantity = Integer.parseInt(req.getParameter("quantity") != null
                           ? req.getParameter("quantity") : "1");
            cartDAO.addToCart(userId, menuId, quantity);
        } catch (NumberFormatException e) {
            System.err.println("[CartServlet] Invalid menuId or quantity");
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            int cartId   = Integer.parseInt(req.getParameter("cartId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            cartDAO.updateQuantity(cartId, quantity);
        } catch (NumberFormatException e) {
            System.err.println("[CartServlet] Invalid cartId or quantity");
        }
    }

    private void handleRemove(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            int cartId = Integer.parseInt(req.getParameter("cartId"));
            cartDAO.removeItem(cartId);
        } catch (NumberFormatException e) {
            System.err.println("[CartServlet] Invalid cartId");
        }
    }

    private String toJson(List<CartItem> items) {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < items.size(); i++) {
            CartItem item = items.get(i);
            sb.append("{");
            sb.append("\"id\":").append(item.getId()).append(",");
            sb.append("\"menuId\":").append(item.getMenuId()).append(",");
            sb.append("\"quantity\":").append(item.getQuantity()).append(",");
            sb.append("\"price\":").append(item.getPrice()).append(",");
            sb.append("\"name\":\"").append(item.getName().replace("\"", "\\\"")).append("\"");
            sb.append("}");
            if (i < items.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        return sb.toString();
    }
}