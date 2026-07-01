<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tapyfood.model.Order, java.util.List, com.tapyfood.model.OrderItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Order placed successfully on Tapy Food!">
    <title>Order Confirmed! — Tapy Food</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages.css">
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<%
    Order order = (Order) request.getAttribute("order");
%>

<main>
    <div class="success-page">


        <div class="success-animation">✅</div>

        <h1 class="success-title">Order Placed!</h1>
        <p class="success-subtitle">
            Your food is being prepared with love. Sit back, relax, and get ready for a delicious meal delivered to your door.
        </p>


        <div class="success-order-box">
            <p class="success-order-label">Order ID</p>
            <p class="success-order-id">
                #<%= request.getAttribute("userOrderCount") != null ? request.getAttribute("userOrderCount") : (order != null ? order.getId() : "—") %>
            </p>

            <% if (order != null) { %>
            <div class="success-delivery-info">
                <p>💰 Total: <strong>₹<%= String.format("%.0f", order.getTotalAmount()) %></strong></p>
                <p>📍 Delivery to: <strong><%= order.getDeliveryAddress() %></strong></p>
                <p style="margin-top:var(--sp-sm);color:var(--color-tertiary);font-weight:600;">
                    ⏱ Estimated arrival: <strong>25–35 minutes</strong>
                </p>
            </div>
            <% } %>
        </div>


        <div class="track-order-card">
            <h3 class="track-title">Live Order Status</h3>
            <div class="track-status-text">
                <span class="pulse-dot"></span>
                <p>Order is being prepared in hotel shortly delivery partner will be assigned.</p>
            </div>
            
            <div class="tracker-steps">
                <div class="tracker-steps-line"></div>
                <div class="tracker-step completed">
                    <div class="step-dot">✓</div>
                    <div class="step-label">Order Placed</div>
                </div>
                <div class="tracker-step active">
                    <div class="step-dot">👨‍🍳</div>
                    <div class="step-label">Preparing</div>
                </div>
                <div class="tracker-step pending">
                    <div class="step-dot">🛵</div>
                    <div class="step-label">On the Way</div>
                </div>
            </div>
        </div>


        <div class="success-actions">
            <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary">
                🍽 Order Again
            </a>
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-ghost">
                📦 View My Orders
            </a>
        </div>

    </div>
</main>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>
