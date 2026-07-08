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
    
    // Read fee and discount values set by OrderServlet
    Double deliveryFeeObj = (Double) request.getAttribute("deliveryFee");
    double deliveryFee = (deliveryFeeObj != null) ? deliveryFeeObj : 40.0;
    Double platformFeeObj = (Double) request.getAttribute("platformFee");
    double platformFee = (platformFeeObj != null) ? platformFeeObj : 10.0;
    
    Double couponDiscount = (Double) request.getAttribute("couponDiscount");
    if (couponDiscount == null) couponDiscount = 0.0;
    com.tapyfood.model.Coupon appliedCoupon = (com.tapyfood.model.Coupon) request.getAttribute("appliedCoupon");
    String couponError = (String) request.getAttribute("couponError");
    List<com.tapyfood.model.Coupon> availableCoupons = (List<com.tapyfood.model.Coupon>) request.getAttribute("availableCoupons");
    
    com.tapyfood.dao.CouponDAO couponDAO = new com.tapyfood.dao.impl.CouponDAOImpl();
    int firstryUsage = 0;
    if (userId != null) {
        firstryUsage = couponDAO.getCouponUsageCount(userId, "FIRSTRY");
    }
    
    double grandTotal  = cartTotal + deliveryFee + platformFee - couponDiscount;
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

        <% if (firstryUsage < 2) { %>
            <% if (appliedCoupon != null && "FIRSTRY".equals(appliedCoupon.getCode())) { %>
            <div style="background:linear-gradient(135deg, #10b981, #059669); color:#fff; padding:16px 20px; border-radius:12px; margin-bottom:var(--sp-md); box-shadow:0 4px 12px rgba(16,185,129,0.15); display:flex; align-items:center; gap:15px;">
                <div style="font-size:1.8rem;">🎉</div>
                <div>
                    <strong style="font-size:1.05rem; display:block; margin-bottom:2px;">FIRSTRY Code Active!</strong>
                    <span style="font-size:0.88rem; opacity:0.95;">You have successfully unlocked **₹100 OFF + FREE Delivery + FREE Platform Fee**!</span>
                </div>
            </div>
            <% } else { %>
            <div style="background:linear-gradient(135deg, #3b82f6, #2563eb); color:#fff; padding:16px 20px; border-radius:12px; margin-bottom:var(--sp-md); box-shadow:0 4px 12px rgba(59,130,246,0.15); display:flex; align-items:center; gap:15px;">
                <div style="font-size:1.8rem;">🎁</div>
                <div>
                    <strong style="font-size:1.05rem; display:block; margin-bottom:2px;">Get ₹100 Off + Free Delivery!</strong>
                    <span style="font-size:0.88rem; opacity:0.95;">Apply coupon code <strong style="text-decoration:underline;">FIRSTRY</strong> below to unlock ₹100 Discount, Free Delivery, and No Platform Charges! (Valid for your first 2 orders above ₹149. Remaining uses: <%= 2 - firstryUsage %>)</span>
                </div>
            </div>
            <% } %>
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
                    <span class="amount">₹<%= String.format("%.2f", cartTotal) %></span>
                </div>
                <div class="summary-row">
                    <span>🛵 Delivery Fee</span>
                    <span class="amount"><%= (deliveryFee == 0.0) ? "<span style='color:#16a34a; font-weight:600;'>FREE</span>" : "₹" + String.format("%.2f", deliveryFee) %></span>
                </div>
                <div class="summary-row">
                    <span>⚙️ Platform Fee</span>
                    <span class="amount"><%= (platformFee == 0.0) ? "<span style='color:#16a34a; font-weight:600;'>FREE</span>" : "₹" + String.format("%.2f", platformFee) %></span>
                </div>
                <% if (appliedCoupon != null) { %>
                <div class="summary-row" style="color:#16a34a; font-weight:600;">
                    <span>🎁 Coupon Discount (<%= appliedCoupon.getCode() %>)</span>
                    <span class="amount">-₹<%= String.format("%.2f", couponDiscount) %></span>
                </div>
                <% } %>
                <div class="summary-row total">
                    <span>Grand Total</span>
                    <span class="amount">₹<%= String.format("%.2f", grandTotal) %></span>
                </div>
                <% if (appliedCoupon == null) { %>
                    <form id="apply-coupon-form" method="POST" action="${pageContext.request.contextPath}/coupon/apply" style="margin-top:var(--sp-md); display:flex; gap:8px; background:none; border:none; padding:0; box-shadow:none;">
                        <input type="text" id="coupon-code-input" name="couponCode" placeholder="Enter Coupon Code" required style="padding:10px 14px; border:1.5px solid var(--color-border); border-radius:8px; flex:1; outline:none; font-size:0.9rem; background:#fff; color:var(--color-primary);">
                        <button type="submit" class="btn btn-primary" style="padding:10px 18px; font-size:0.88rem; font-weight:600; border-radius:8px;">Apply</button>
                    </form>
                    <% if (couponError != null) { %>
                        <p style="color:#dc2626; font-size:0.84rem; margin-top:6px; font-weight:500;">⚠️ <%= couponError %></p>
                    <% } %>
                    
                    <% if (availableCoupons != null && !availableCoupons.isEmpty()) { %>
                    <div style="margin-top: 15px; border-top: 1px solid var(--color-border); padding-top: 15px;">
                        <span style="font-size: 0.85rem; font-weight: 600; color: var(--color-primary); display: block; margin-bottom: 8px;">🎁 Available Coupons:</span>
                        <div style="display: flex; gap: 8px; overflow-x: auto; padding-bottom: 8px; scrollbar-width: thin;">
                            <% for (com.tapyfood.model.Coupon c : availableCoupons) { %>
                                <div onclick="selectCouponCode('<%= c.getCode() %>')" style="flex: 0 0 auto; background: #f0fdf4; border: 1.5px solid #bbf7d0; border-radius: 8px; padding: 8px 12px; cursor: pointer; transition: all 0.2s ease; min-width: 110px;">
                                    <div style="font-size: 0.78rem; font-weight: 700; color: #166534; letter-spacing: 0.5px;"><%= c.getCode() %></div>
                                    <div style="font-size: 0.82rem; font-weight: 600; color: #15803d; margin-top: 2px;">
                                        <%= "flat".equalsIgnoreCase(c.getDiscountType()) ? "₹" + String.format("%.0f", c.getDiscountValue()) + " OFF" : String.format("%.0f", c.getDiscountValue()) + "% OFF" %>
                                    </div>
                                    <div style="font-size: 0.65rem; color: #166534; margin-top: 2px; opacity: 0.8;">Min: ₹<%= String.format("%.0f", c.getMinOrderAmount()) %></div>
                                </div>
                            <% } %>
                        </div>
                    </div>
                    <script>
                        function selectCouponCode(code) {
                            const input = document.getElementById('coupon-code-input');
                            if (input) {
                                input.value = code;
                                document.getElementById('apply-coupon-form').submit();
                            }
                        }
                    </script>
                    <% } %>
                    
                <% } else { %>
                <div style="margin-top:var(--sp-md); display:flex; justify-content:space-between; align-items:center; background:#f0fdf4; border:1.5px dashed #bbf7d0; padding:12px 14px; border-radius:8px;">
                    <div>
                        <strong style="color:#15803d; font-size:0.88rem;">🎉 Code: <%= appliedCoupon.getCode() %></strong>
                        <div style="font-size:0.78rem; color:#166534; margin-top:2px;"><%= "flat".equalsIgnoreCase(appliedCoupon.getDiscountType()) ? "₹" + String.format("%.0f", appliedCoupon.getDiscountValue()) + " Off" : String.format("%.0f", appliedCoupon.getDiscountValue()) + "% Off" %></div>
                    </div>
                    <form method="POST" action="${pageContext.request.contextPath}/coupon/remove" style="margin:0; background:none; border:none; padding:0; box-shadow:none; width:auto;">
                        <button type="submit" style="background:none; border:none; color:#dc2626; font-weight:700; font-size:0.85rem; cursor:pointer;">Remove</button>
                    </form>
                </div>
                <% } %>

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
</body>
</html>
