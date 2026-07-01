<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    // Cart count for badge
    Integer userId    = (Integer) session.getAttribute("userId");
    int cartCount = 0;
    if (userId != null) {
        com.tapyfood.dao.CartDAO cartDAO = new com.tapyfood.dao.impl.CartDAOImpl();
        cartCount = cartDAO.getCartCount(userId);
    }
    String currentPath = request.getServletPath();
%>
<header id="page-header">
    <nav class="navbar" aria-label="Main navigation">

        <a href="<%= request.getContextPath() %>/index.jsp" class="brand-logo" aria-label="Tapy Food Home">
            <span class="brand-icon">🍽</span>
            <strong>Tapy Food</strong>
        </a>

        <ul class="navlist" role="list">
            <li class="listitem">
                <a class="navitem <%= "/index.jsp".equals(currentPath) ? "active" : "" %>"
                   href="<%= request.getContextPath() %>/index.jsp">Home</a>
            </li>
            <li class="listitem">
                <a class="navitem <%= "/restaurants".equals(currentPath) ? "active" : "" %>"
                   href="<%= request.getContextPath() %>/restaurants">Restaurants</a>
            </li>
            <% if (userId != null) { %>
            <li class="listitem">
                <a class="navitem <%= "/orders".equals(currentPath) ? "active" : "" %>"
                   href="<%= request.getContextPath() %>/orders">My Orders</a>
            </li>
            <% } %>
        </ul>

        <div class="nav-right">
            <!-- Cart icon with badge -->
            <a href="<%= request.getContextPath() %>/cart" class="cart-icon-btn" aria-label="View Cart">
                <span class="cart-icon">🛒</span>
                <% if (cartCount > 0) { %>
                    <span class="cart-badge"><%= cartCount %></span>
                <% } %>
            </a>

            <!-- Login/User area -->
            <% if (userId != null) { %>
                <div class="nav-user-info">
                    <span class="nav-user-greeting">
                        👤 <%= session.getAttribute("userName") %>
                    </span>
                    <a href="<%= request.getContextPath() %>/logout" class="nav-cta nav-cta-outline">Logout</a>
                </div>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/login" class="nav-cta" id="nav-login-btn">Login</a>
            <% } %>
        </div>

    </nav>
</header>
