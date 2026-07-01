<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.tapyfood.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Checkout and place your order on Tapy Food.">
    <title>Checkout — Tapy Food</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages.css">
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    Double cartTotal = (Double) request.getAttribute("cartTotal");
    if (cartTotal == null) cartTotal = 0.0;
    double deliveryFee = 40.0;
    double grandTotal  = cartTotal + deliveryFee;
    String error = (String) request.getAttribute("error");
    String userAddress = (String) session.getAttribute("userAddress");
%>

<main>
    <div class="page-hero">
        <span class="section-eyebrow">Almost There!</span>
        <h1 class="sectiontitle">Checkout</h1>
    </div>

    <div class="page-wrapper checkout-page">

        <% if (error != null) { %>
        <div class="error-alert" style="margin-bottom:var(--sp-md);">⚠️ <%= error %></div>
        <% } %>

        <div class="checkout-layout">

            
            <div class="checkout-form-panel">
                <h2>Delivery Details</h2>

                <form method="POST"
                      action="${pageContext.request.contextPath}/checkout"
                      class="checkout-form"
                      id="checkout-form">

                    <div class="form-group">
                        <label for="deliveryName">Full Name</label>
                        <input type="text" id="deliveryName" name="deliveryName"
                               value="<%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "" %>"
                               placeholder="Your name" required>
                    </div>

                    <div class="form-group">
                        <label for="deliveryPhone">Phone Number</label>
                        <input type="tel" id="deliveryPhone" name="deliveryPhone"
                               placeholder="+91 98765 43210" required>
                    </div>

                    <div class="form-group">
                        <label for="deliveryAddress">Delivery Address</label>
                        <textarea id="deliveryAddress" name="deliveryAddress" rows="3"
                                  placeholder="House no., Street, Area, City — e.g. 42, Food Street, Bandra West, Mumbai 400050"
                                  required><%= userAddress != null ? userAddress : "" %></textarea>
                    </div>

                    <div class="form-group">
                        <label for="paymentMethod">Payment Method</label>
                        <select id="paymentMethod" name="paymentMethod"
                                style="background:var(--color-neutral);border:1.5px solid var(--color-border);color:var(--color-primary);padding:12px 16px;border-radius:var(--r-md);font-family:var(--font-body);font-size:var(--fs-body);width:100%;">
                            <option value="cod">💵 Cash on Delivery</option>
                            <option value="upi">📱 UPI</option>
                            <option value="card">💳 Card</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary checkout-btn" id="place-order-btn">
                        🛵 Place Order — ₹<%= String.format("%.0f", grandTotal) %>
                    </button>
                </form>
            </div>

            
            <div class="order-summary-panel">
                <h3 class="summary-title">Order Review</h3>

                <% if (cartItems != null) {
                    for (CartItem item : cartItems) { %>
                <div class="summary-row">
                    <span style="max-width:180px;"><%= item.getName() %> × <%= item.getQuantity() %></span>
                    <span class="amount">₹<%= String.format("%.0f", item.getSubtotal()) %></span>
                </div>
                <% } } %>

                <div class="summary-row" style="margin-top:var(--sp-sm);padding-top:var(--sp-sm);border-top:1px solid var(--color-border);">
                    <span>Subtotal</span>
                    <span class="amount">₹<%= String.format("%.0f", cartTotal) %></span>
                </div>
                <div class="summary-row">
                    <span>🛵 Delivery Fee</span>
                    <span class="amount">₹<%= String.format("%.0f", deliveryFee) %></span>
                </div>
                <div class="summary-row total">
                    <span>Grand Total</span>
                    <span class="amount">₹<%= String.format("%.0f", grandTotal) %></span>
                </div>

                <div style="margin-top:var(--sp-lg);padding:var(--sp-md);background:rgba(58,140,58,0.06);border:1px solid rgba(58,140,58,0.20);border-radius:var(--r-md);">
                    <p style="font-size:0.84rem;color:#2d7d2d;font-weight:500;">
                        ✅ Estimated delivery: <strong>25–35 minutes</strong>
                    </p>
                </div>
            </div>

        </div>
    </div>
</main>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
