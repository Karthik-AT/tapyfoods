<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.tapyfood.model.Order, com.tapyfood.model.OrderItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="View your order history on Tapy Food.">
    <title>My Orders — Tapy Food</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages.css">
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<main>
    <div class="page-hero">
        <span class="section-eyebrow">Order History</span>
        <h1 class="sectiontitle">My Orders</h1>
        <p class="section-lead" style="margin:0 auto;">
            Track all your past orders and their current status.
        </p>
    </div>

    <div class="page-wrapper orders-page">

        <% if (orders == null || orders.isEmpty()) { %>
        <div class="no-orders">
            <div class="emoji">📦</div>
            <h3 style="font-family:var(--font-display);font-size:1.4rem;color:var(--color-primary);margin-bottom:var(--sp-sm);">
                No orders yet
            </h3>
            <p style="margin-bottom:var(--sp-lg);">You haven't placed any orders. Let's change that!</p>
            <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary">
                Browse Restaurants
            </a>
        </div>

        <% } else {
            int orderNum = 0;
            for (Order order : orders) {
                orderNum++;
                // Determine status CSS class
                String status = order.getStatus();
                String statusClass = "status-placed";
                if ("Preparing".equalsIgnoreCase(status))       statusClass = "status-preparing";
                else if ("On the Way".equalsIgnoreCase(status)) statusClass = "status-ontheway";
                else if ("Delivered".equalsIgnoreCase(status))  statusClass = "status-delivered";
                else if ("Cancelled".equalsIgnoreCase(status))  statusClass = "status-cancelled";
        %>

        <div class="order-card">
            <div class="order-card-header">
                <div>
                    <p class="order-id">Order #<%= orderNum %></p>
                    <p class="order-date">
                        <%= order.getCreatedAt() != null ?
                            new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a").format(order.getCreatedAt()) : "" %>
                    </p>
                </div>
                <span class="status-badge <%= statusClass %>"><%= status %></span>
            </div>


            <% List<OrderItem> items = order.getItems(); %>
            <% if (items != null && !items.isEmpty()) { %>
            <ul class="order-items-list">
                <% for (OrderItem item : items) { %>
                <li class="order-item-row">
                    <span class="item-name"><%= item.getMenuItemName() %> × <%= item.getQuantity() %></span>
                    <span>₹<%= String.format("%.0f", item.getSubtotal()) %></span>
                </li>
                <% } %>
            </ul>
            <% } %>


            <p style="font-size:0.82rem;color:var(--color-secondary);margin-bottom:var(--sp-sm);">
                📍 <%= order.getDeliveryAddress() %>
            </p>


            <div class="order-card-footer">
                <span class="order-total-label">Order Total</span>
                <span class="order-total-amount">₹<%= String.format("%.0f", order.getTotalAmount()) %></span>
            </div>
        </div>

        <% } } %>
    </div>
</main>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>
