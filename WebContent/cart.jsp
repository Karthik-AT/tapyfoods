<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.tapyfood.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Your cart on Tapy Food. Review and place your order.">
    <title>My Cart — Tapy Food</title>
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
    boolean isEmpty    = (cartItems == null || cartItems.isEmpty());
%>

<main>
    <div class="page-hero">
        <span class="section-eyebrow">Your Selection</span>
        <h1 class="sectiontitle">My Cart</h1>
    </div>

    <div class="page-wrapper cart-page">
        <% if (isEmpty) { %>
        
        <div class="empty-cart">
            <div class="empty-cart-emoji">🛒</div>
            <h3>Your cart is empty</h3>
            <p>Looks like you haven't added anything yet. Browse our restaurants and discover something delicious!</p>
            <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary">
                Browse Restaurants
            </a>
        </div>

        <% } else { %>
        
        <div class="cart-layout">

            
            <div class="cart-items-panel">
                <% for (CartItem item : cartItems) { %>
                <div class="cart-item-card">
                    <img
                        src="<%= item.getImageUrl() != null ? item.getImageUrl() : "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300" %>"
                        alt="<%= item.getName() %>"
                        class="cart-item-img"
                        loading="lazy"
                    >
                    <div class="cart-item-details">
                        <p class="cart-item-name"><%= item.getName() %></p>
                        <p class="cart-item-price">₹<%= String.format("%.0f", item.getPrice()) %> per item</p>
                        <div class="cart-item-controls">
                            
                            <form method="POST" action="${pageContext.request.contextPath}/cart" class="cart-qty-form" id="qty-form-<%= item.getId() %>">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="cartId" value="<%= item.getId() %>">
                                <input type="hidden" name="quantity" class="qty-val-input" value="<%= item.getQuantity() %>">

                                <button type="button" class="cart-qty-btn"
                                        onclick="changeQty(<%= item.getId() %>, -1)">−</button>
                                <span class="cart-qty-value" id="qty-<%= item.getId() %>"><%= item.getQuantity() %></span>
                                <button type="button" class="cart-qty-btn"
                                        onclick="changeQty(<%= item.getId() %>, 1)">+</button>
                            </form>

                            
                            <form method="POST" action="${pageContext.request.contextPath}/cart">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="cartId" value="<%= item.getId() %>">
                                <button type="submit" class="remove-btn">🗑 Remove</button>
                            </form>
                        </div>
                    </div>
                    <div class="cart-item-subtotal">
                        ₹<%= String.format("%.0f", item.getSubtotal()) %>
                    </div>
                </div>
                <% } %>
            </div>

            
            <div class="order-summary-panel">
                <h3 class="summary-title">Order Summary</h3>

                <% for (CartItem item : cartItems) { %>
                <div class="summary-row">
                    <span><%= item.getName() %> × <%= item.getQuantity() %></span>
                    <span class="amount">₹<%= String.format("%.0f", item.getSubtotal()) %></span>
                </div>
                <% } %>

                <div class="summary-row" style="margin-top:var(--sp-sm);padding-top:var(--sp-sm);border-top:1px solid var(--color-border);">
                    <span>Item Subtotal</span>
                    <span class="amount">₹<%= String.format("%.0f", cartTotal) %></span>
                </div>
                <div class="summary-row">
                    <span>🛵 Delivery Fee</span>
                    <span class="amount">₹<%= String.format("%.0f", deliveryFee) %></span>
                </div>
                <div class="summary-row total">
                    <span>Total</span>
                    <span class="amount">₹<%= String.format("%.0f", grandTotal) %></span>
                </div>

                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary checkout-btn">
                    Proceed to Checkout →
                </a>

                <p style="text-align:center;margin-top:var(--sp-sm);font-size:0.8rem;color:var(--color-secondary);">
                    🔒 Secure checkout
                </p>
            </div>

        </div>
        <% } %>
    </div>
</main>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

<script>
// Inline quantity update — submits the hidden form
function changeQty(cartId, delta) {
    const display = document.getElementById('qty-' + cartId);
    const form    = document.getElementById('qty-form-' + cartId);
    const input   = form.querySelector('.qty-val-input');

    let current = parseInt(display.textContent) + delta;
    if (current < 1) current = 1;
    if (current > 10) current = 10;

    display.textContent = current;
    input.value = current;
    form.submit();
}
</script>
</body>
</html>
