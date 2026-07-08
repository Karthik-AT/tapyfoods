<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tapyfood.model.Restaurant" %>
<%@ page import="com.tapyfood.model.User" %>
<%@ page import="com.tapyfood.model.Order" %>
<%@ page import="java.util.List" %>
<%
    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
    List<User> unassignedOwners = (List<User>) request.getAttribute("unassignedOwners");
    List<Order> allOrders = (List<Order>) request.getAttribute("allOrders");
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    if (totalRevenue == null) totalRevenue = 0.0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel — Tapy Food</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages.css">
    <style>
        :root {
            --card-bg: #ffffff;
            --border-color: rgba(43, 24, 16, 0.12);
            --text-color: #2B1810;
        }
        .admin-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            font-family: 'Inter', sans-serif;
        }
        .admin-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: linear-gradient(135deg, hsl(230, 80%, 40%), hsl(220, 80%, 30%));
            color: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        .admin-info h1 {
            font-family: 'Fraunces', serif;
            font-size: 2rem;
            margin: 0 0 5px 0;
        }
        .admin-info p {
            margin: 0;
            opacity: 0.9;
            font-size: 0.95rem;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        .stat-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 24px;
            display: flex;
            align-items: center;
            gap: 20px;
            transition: all 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.03);
        }
        .stat-icon {
            font-size: 2.2rem;
            background: rgba(40, 90, 230, 0.08);
            color: hsl(220, 90%, 50%);
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .stat-meta h3 {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #777;
            margin: 0 0 5px 0;
        }
        .stat-meta p {
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0;
            color: var(--text-color);
        }

        /* Tabs Nav */
        .tabs-nav {
            display: flex;
            border-bottom: 2px solid var(--border-color);
            margin-bottom: 30px;
            gap: 20px;
        }
        .tab-btn {
            background: none;
            border: none;
            font-size: 1rem;
            font-weight: 600;
            color: #666;
            padding: 12px 6px;
            cursor: pointer;
            position: relative;
            transition: color 0.2s;
        }
        .tab-btn:hover {
            color: var(--text-color);
        }
        .tab-btn.active {
            color: hsl(220, 90%, 50%);
        }
        .tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 2px;
            background-color: hsl(220, 90%, 50%);
        }
        .tab-pane {
            display: none;
        }
        .tab-pane.active {
            display: block;
        }

        /* Tables */
        .pane-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .pane-title {
            font-family: 'Fraunces', serif;
            font-size: 1.5rem;
            color: var(--text-color);
            margin: 0;
        }
        .data-table-wrap {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            overflow-x: auto;
        }
        .data-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 0.92rem;
        }
        .data-table th {
            background-color: #fafafa;
            padding: 14px 18px;
            font-weight: 600;
            color: #555;
            border-bottom: 1px solid var(--border-color);
        }
        .data-table td {
            padding: 16px 18px;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-color);
            vertical-align: middle;
        }
        .data-table tr:last-child td {
            border-bottom: none;
        }
        .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 600;
            text-transform: uppercase;
        }
        .badge-placed { background: #e0f2fe; color: #0369a1; }
        .badge-preparing { background: #fef3c7; color: #b45309; }
        .badge-delivery { background: #f3e8ff; color: #6b21a8; }
        .badge-delivered { background: #dcfce7; color: #15803d; }
        .badge-cancelled { background: #fee2e2; color: #b91c1c; }

        /* Modal styling */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.55);
            align-items: flex-start;
            justify-content: center;
            z-index: 1000;
            backdrop-filter: blur(4px);
            overflow-y: auto;
            padding: 40px 15px;
        }
        .modal-content {
            background: var(--card-bg);
            border-radius: 16px;
            width: 90%;
            max-width: 550px;
            padding: 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            position: relative;
        }
        .modal-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .modal-title {
            font-family: 'Fraunces', serif;
            font-size: 1.4rem;
            margin: 0;
            color: var(--text-color);
        }
        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #777;
        }
        .action-link {
            color: hsl(220, 90%, 50%);
            font-weight: 500;
            text-decoration: none;
            margin-right: 12px;
            cursor: pointer;
        }
        .action-link-delete {
            color: #dc2626;
        }
        .inline-table-form {
            display: inline !important;
            background: none !important;
            border: none !important;
            padding: 0 !important;
            margin: 0 !important;
            box-shadow: none !important;
            width: auto !important;
        }
        .auth-form label {
            color: var(--color-primary) !important;
            font-weight: 700 !important;
            letter-spacing: 0.03em;
        }
        .auth-form input[type="text"],
        .auth-form input[type="number"],
        .auth-form select,
        .auth-form textarea {
            background-color: #ffffff !important;
            border: 1.5px solid rgba(43, 24, 16, 0.2) !important;
            color: var(--color-primary) !important;
        }
        .auth-form input[type="text"]:focus,
        .auth-form input[type="number"]:focus,
        .auth-form select:focus,
        .auth-form textarea:focus {
            border-color: var(--color-tertiary) !important;
            box-shadow: 0 0 0 3px rgba(217, 119, 66, 0.15) !important;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<div class="admin-container">

    <div class="admin-header">
        <div class="admin-info">
            <h1>Platform Administration</h1>
            <p>Super Admin Dashboard for managing restaurants, merchant associations, and orders.</p>
        </div>
        <div style="background: rgba(255,255,255,0.2); padding: 10px 18px; border-radius: 8px;">
            <span style="font-size:0.85rem; font-weight:600; text-transform:uppercase;">Admin Account</span>
            <div style="font-size:1.1rem; font-weight:700;"><%= session.getAttribute("userName") %></div>
        </div>
    </div>

    <!-- Stats Grid -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">💰</div>
            <div class="stat-meta">
                <h3>Total Platform Revenue</h3>
                <p>₹<%= String.format("%.2f", totalRevenue) %></p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🏨</div>
            <div class="stat-meta">
                <h3>Active Restaurants</h3>
                <p><%= restaurants != null ? restaurants.size() : 0 %></p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🛍</div>
            <div class="stat-meta">
                <h3>Total Orders Placed</h3>
                <p><%= allOrders != null ? allOrders.size() : 0 %></p>
            </div>
        </div>
    </div>

    <!-- Tabs Nav -->
    <div class="tabs-nav">
        <button class="tab-btn active" onclick="switchTab('restaurants')">Restaurants Manager</button>
        <button class="tab-btn" onclick="switchTab('orders')">Global Order Log</button>
        <button class="tab-btn" onclick="switchTab('coupons')">Coupons Manager</button>
    </div>

    <!-- Tab 1: Restaurants Manager -->
    <div id="tab-pane-restaurants" class="tab-pane active">
        <div class="pane-header">
            <h2 class="pane-title">All Registered Restaurants</h2>
            <button class="btn btn-primary" onclick="openAddRestaurantModal()">+ Register New Restaurant</button>
        </div>
        <div class="data-table-wrap">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Restaurant</th>
                        <th>Cuisine</th>
                        <th>Location</th>
                        <th>Rating</th>
                        <th>Offer Badge</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (restaurants == null || restaurants.isEmpty()) { %>
                        <tr>
                            <td colspan="6" style="text-align:center; padding:30px; color:#777;">No restaurants registered yet.</td>
                        </tr>
                    <% } else { 
                        for (Restaurant r : restaurants) { %>
                            <tr>
                                <td>
                                    <div style="display:flex; align-items:center; gap:12px;">
                                        <% if (r.getImageUrl() != null && !r.getImageUrl().isEmpty()) { %>
                                            <img src="<%= r.getImageUrl().startsWith("http") ? r.getImageUrl() : request.getContextPath() + "/" + r.getImageUrl() %>" style="width:40px; height:40px; border-radius:8px; object-fit:cover;">
                                        <% } else { %>
                                            <div style="width:40px; height:40px; border-radius:8px; background:#ddd; display:flex; align-items:center; justify-content:center;">🏨</div>
                                        <% } %>
                                        <div>
                                            <strong><%= r.getName() %></strong>
                                            <div style="font-size:0.75rem; color:#777;">Owner ID: <%= r.getOwnerId() != null ? "#" + r.getOwnerId() : "Unassigned" %></div>
                                        </div>
                                    </div>
                                </td>
                                <td><%= r.getCuisineType() %></td>
                                <td><%= r.getLocation() %></td>
                                <td>★ <%= r.getRating() %></td>
                                <td style="font-size:0.85rem; color:hsl(20, 90%, 50%); font-weight:600;"><%= r.getOfferBadge() != null ? r.getOfferBadge() : "" %></td>
                                <td>
                                    <a class="action-link" onclick="openEditRestaurantModal(<%= r.getId() %>, '<%= r.getName().replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") %>', '<%= r.getCuisineType().replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") %>', <%= r.getRating() %>, '<%= r.getDeliveryTime().replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") %>', '<%= r.getLocation().replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") %>', '<%= r.getImageUrl() != null ? r.getImageUrl().replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") : "" %>', '<%= r.getOfferBadge() != null ? r.getOfferBadge().replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") : "" %>', '<%= r.getDescription() != null ? r.getDescription().replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") : "" %>', <%= r.getOwnerId() != null ? r.getOwnerId() : "null" %>)">Edit</a>
                                    
                                    <form class="inline-table-form" method="POST" action="${pageContext.request.contextPath}/admin/restaurant" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this restaurant and all its menus?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%= r.getId() %>">
                                        <button type="submit" class="action-link action-link-delete" style="background:none; border:none; padding:0; font:inherit; cursor:pointer;">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        <% } 
                    } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Tab 2: Global Order Log -->
    <div id="tab-pane-orders" class="tab-pane">
        <div class="pane-header">
            <h2 class="pane-title">Global Order Summary</h2>
        </div>
        <div class="data-table-wrap">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>User ID</th>
                        <th>Delivery Address</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Placed Date</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (allOrders == null || allOrders.isEmpty()) { %>
                        <tr>
                            <td colspan="6" style="text-align:center; padding:30px; color:#777;">No orders placed on the platform yet.</td>
                        </tr>
                    <% } else { 
                        for (Order o : allOrders) { %>
                            <tr>
                                <td><strong>#<%= o.getId() %></strong></td>
                                <td>User #<%= o.getUserId() %></td>
                                <td style="font-size:0.85rem;"><%= o.getDeliveryAddress() %></td>
                                <td><strong>₹<%= String.format("%.2f", o.getTotalAmount()) %></strong></td>
                                <td>
                                    <% String statusClass = o.getStatus().toLowerCase().replace(" ", "-"); %>
                                    <span class="badge badge-<%= statusClass %>"><%= o.getStatus() %></span>
                                </td>
                                <td style="font-size:0.85rem;"><%= o.getCreatedAt() %></td>
                            </tr>
                        <% } 
                    } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Tab 3: Coupons Manager -->
    <div id="tab-pane-coupons" class="tab-pane">
        <div class="pane-header">
            <h2 class="pane-title">Platform Coupons</h2>
            <button class="btn btn-primary" onclick="openAddCouponModal()">+ Create New Coupon</button>
        </div>

        <%
            List<com.tapyfood.model.Coupon> coupons = (List<com.tapyfood.model.Coupon>) request.getAttribute("coupons");
        %>

        <div class="data-table-wrap">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Coupon Code</th>
                        <th>Type</th>
                        <th>Value</th>
                        <th>Restaurant (Scope)</th>
                        <th>Min Order Amount</th>
                        <th>Active Range</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (coupons == null || coupons.isEmpty()) { %>
                        <tr>
                            <td colspan="8" style="text-align:center; padding:30px; color:#777;">No coupons created yet.</td>
                        </tr>
                    <% } else {
                        for (com.tapyfood.model.Coupon c : coupons) {
                            String restScope = "Global (All)";
                            if (c.getRestaurantId() != null && restaurants != null) {
                                for (Restaurant r : restaurants) {
                                    if (r.getId() == c.getRestaurantId().intValue()) {
                                        restScope = r.getName();
                                        break;
                                    }
                                }
                            }
                    %>
                            <tr>
                                <td><strong><%= c.getCode() %></strong></td>
                                <td><%= c.getDiscountType() %></td>
                                <td>
                                    <%= "flat".equalsIgnoreCase(c.getDiscountType()) ? "₹" + String.format("%.2f", c.getDiscountValue()) : String.format("%.0f", c.getDiscountValue()) + "%" %>
                                </td>
                                <td><span style="background:#e0f2fe; color:#0369a1; padding:3px 8px; border-radius:4px; font-size:0.8rem; font-weight:600;"><%= restScope %></span></td>
                                <td>₹<%= String.format("%.2f", c.getMinOrderAmount()) %></td>
                                <td style="font-size:0.8rem; color:#666;">
                                    <%= c.getStartTime().toString().substring(0, 16) %> to<br>
                                    <%= c.getEndTime().toString().substring(0, 16) %>
                                </td>
                                <td>
                                    <% if (c.isActive()) { %>
                                        <span class="badge badge-delivered">Active</span>
                                    <% } else { %>
                                        <span class="badge badge-cancelled">Inactive</span>
                                    <% } %>
                                </td>
                                <td>
                                    <a class="action-link" onclick="openEditCouponModal(<%= c.getId() %>, '<%= c.getCode() %>', '<%= c.getDiscountType() %>', <%= c.getDiscountValue() %>, <%= c.getMinOrderAmount() %>, '<%= c.getStartTime().toString().substring(0, 16).replace(" ", "T") %>', '<%= c.getEndTime().toString().substring(0, 16).replace(" ", "T") %>', '<%= c.getRestaurantId() != null ? c.getRestaurantId() : "" %>', <%= c.isActive() %>)">Edit</a>
                                    
                                    <form class="inline-table-form" method="POST" action="${pageContext.request.contextPath}/admin/coupon" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this coupon?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%= c.getId() %>">
                                        <button type="submit" class="action-link action-link-delete" style="background:none; border:none; padding:0; font:inherit; cursor:pointer;">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        <% }
                    } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- Restaurant Modal (Add/Edit) -->
<div id="restaurant-modal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 id="modal-title" class="modal-title">Register Restaurant</h3>
            <button class="modal-close" onclick="closeRestaurantModal()">&times;</button>
        </div>
        <form method="POST" action="${pageContext.request.contextPath}/admin/restaurant" class="auth-form">
            <input type="hidden" id="rest-action" name="action" value="add">
            <input type="hidden" id="rest-id" name="id" value="">

            <div class="form-group">
                <label for="rest-name">Restaurant Name</label>
                <input type="text" id="rest-name" name="name" required>
            </div>

            <div class="form-group">
                <label for="rest-cuisine">Cuisine Type</label>
                <input type="text" id="rest-cuisine" name="cuisineType" placeholder="e.g. North Indian, Chinese" required>
            </div>

            <div class="form-group" style="display:grid; grid-template-columns: 1fr 1fr; gap:15px;">
                <div>
                    <label for="rest-rating">Initial Rating</label>
                    <input type="number" id="rest-rating" name="rating" step="0.1" min="1" max="5" value="4.0" required>
                </div>
                <div>
                    <label for="rest-time">Avg Delivery Time</label>
                    <input type="text" id="rest-time" name="deliveryTime" placeholder="e.g. 35 mins" value="30 mins" required>
                </div>
            </div>

            <div class="form-group">
                <label for="rest-location">Location / Area</label>
                <input type="text" id="rest-location" name="location" required>
            </div>

            <div class="form-group">
                <label for="rest-image">Image Path/URL</label>
                <input type="text" id="rest-image" name="imageUrl" placeholder="images/restaurants/rest1.jpg">
            </div>

            <div class="form-group">
                <label for="rest-badge">Offer Tagline</label>
                <input type="text" id="rest-badge" name="offerBadge" placeholder="e.g. 10% OFF up to ₹50">
            </div>

            <div class="form-group">
                <label for="rest-owner">Assign Owner (Restaurant Partner)</label>
                <select id="rest-owner" name="ownerId" style="width:100%; padding:0.75rem; border:1px solid var(--border-color); border-radius:var(--radius-sm); outline:none;">
                    <option value="">-- Leave Unassigned --</option>
                    <% if (unassignedOwners != null) {
                        for (User u : unassignedOwners) { %>
                            <option id="owner-opt-<%= u.getId() %>" value="<%= u.getId() %>"><%= u.getName() %> (<%= u.getEmail() %>)</option>
                        <% }
                    } %>
                </select>
            </div>

            <div class="form-group">
                <label for="rest-desc">Restaurant Description</label>
                <textarea id="rest-desc" name="description" rows="3" required></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Save Restaurant</button>
        </form>
    </div>
</div>

<script>
    function switchTab(tabId) {
        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelectorAll('.tab-pane').forEach(pane => pane.classList.remove('active'));

        const activeBtn = Array.from(document.querySelectorAll('.tab-btn')).find(btn => btn.textContent.toLowerCase().includes(tabId));
        if (activeBtn) activeBtn.classList.add('active');

        const activePane = document.getElementById('tab-pane-' + tabId);
        if (activePane) activePane.classList.add('active');
    }

    const modal = document.getElementById('restaurant-modal');
    const ownerSelect = document.getElementById('rest-owner');

    function openAddRestaurantModal() {
        document.getElementById('modal-title').textContent = 'Register Restaurant';
        document.getElementById('rest-action').value = 'add';
        document.getElementById('rest-id').value = '';
        document.getElementById('rest-name').value = '';
        document.getElementById('rest-cuisine').value = '';
        document.getElementById('rest-rating').value = '4.0';
        document.getElementById('rest-time').value = '30 mins';
        document.getElementById('rest-location').value = '';
        document.getElementById('rest-image').value = '';
        document.getElementById('rest-badge').value = '';
        document.getElementById('rest-desc').value = '';
        ownerSelect.value = '';
        
        // Remove temporary options if any
        const tempOpt = document.getElementById('temp-owner-opt');
        if (tempOpt) tempOpt.remove();

        modal.style.display = 'flex';
    }

    function openEditRestaurantModal(id, name, cuisine, rating, time, location, imageUrl, badge, desc, ownerId) {
        document.getElementById('modal-title').textContent = 'Edit Restaurant';
        document.getElementById('rest-action').value = 'edit';
        document.getElementById('rest-id').value = id;
        document.getElementById('rest-name').value = name;
        document.getElementById('rest-cuisine').value = cuisine;
        document.getElementById('rest-rating').value = rating;
        document.getElementById('rest-time').value = time;
        document.getElementById('rest-location').value = location;
        document.getElementById('rest-image').value = imageUrl;
        document.getElementById('rest-badge').value = badge;
        document.getElementById('rest-desc').value = desc;

        // Clean up temporary options first
        const tempOpt = document.getElementById('temp-owner-opt');
        if (tempOpt) tempOpt.remove();

        if (ownerId && ownerId !== null) {
            // Check if option exists in dropdown
            let opt = document.getElementById('owner-opt-' + ownerId);
            if (!opt) {
                // Owner is already assigned, create a temporary option for editing purposes
                opt = document.createElement('option');
                opt.id = 'temp-owner-opt';
                opt.value = ownerId;
                opt.textContent = 'Owner #' + ownerId + ' (Currently Assigned)';
                ownerSelect.appendChild(opt);
            }
            ownerSelect.value = ownerId;
        } else {
            ownerSelect.value = '';
        }

        modal.style.display = 'flex';
    }

    function closeRestaurantModal() {
        modal.style.display = 'none';
    }

    function openAddCouponModal() {
        document.getElementById('coupon-modal-title').textContent = 'Create Coupon';
        document.getElementById('coupon-action').value = 'add';
        document.getElementById('coupon-id').value = '';
        document.getElementById('coupon-code').value = '';
        document.getElementById('coupon-type').value = 'flat';
        document.getElementById('coupon-value').value = '';
        document.getElementById('coupon-min-order').value = '0.00';
        document.getElementById('coupon-restaurant').value = '';
        
        const now = new Date();
        const nextWeek = new Date();
        nextWeek.setDate(now.getDate() + 7);
        
        document.getElementById('coupon-start').value = now.toISOString().slice(0, 16);
        document.getElementById('coupon-end').value = nextWeek.toISOString().slice(0, 16);
        
        document.getElementById('coupon-active-group').style.display = 'none';
        document.getElementById('coupon-modal').style.display = 'flex';
    }

    function openEditCouponModal(id, code, type, value, minOrder, start, end, restaurantId, active) {
        document.getElementById('coupon-modal-title').textContent = 'Edit Coupon';
        document.getElementById('coupon-action').value = 'edit';
        document.getElementById('coupon-id').value = id;
        document.getElementById('coupon-code').value = code;
        document.getElementById('coupon-type').value = type;
        document.getElementById('coupon-value').value = value;
        document.getElementById('coupon-min-order').value = minOrder;
        document.getElementById('coupon-restaurant').value = restaurantId;
        document.getElementById('coupon-start').value = start;
        document.getElementById('coupon-end').value = end;
        
        document.getElementById('coupon-active').value = active ? 'true' : 'false';
        document.getElementById('coupon-active-group').style.display = 'block';
        document.getElementById('coupon-modal').style.display = 'flex';
    }

    function closeCouponModal() {
        document.getElementById('coupon-modal').style.display = 'none';
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            closeRestaurantModal();
        }
        if (event.target == document.getElementById('coupon-modal')) {
            closeCouponModal();
        }
    }
</script>

<!-- Add/Edit Coupon Modal -->
<div id="coupon-modal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 id="coupon-modal-title" class="modal-title">Create Coupon</h3>
            <button class="modal-close" onclick="closeCouponModal()">&times;</button>
        </div>
        <form id="coupon-form" class="auth-form" method="POST" action="${pageContext.request.contextPath}/admin/coupon">
            <input type="hidden" id="coupon-action" name="action" value="add">
            <input type="hidden" id="coupon-id" name="id" value="">

            <div class="form-group">
                <label for="coupon-code">Coupon Code</label>
                <input type="text" id="coupon-code" name="code" placeholder="e.g. WELCOME50" required>
            </div>

            <div class="form-group">
                <label for="coupon-type">Discount Type</label>
                <select id="coupon-type" name="discountType" required style="width:100%; padding:0.75rem; border:1px solid var(--border-color); border-radius:var(--radius-sm); outline:none; background:#fff;">
                    <option value="flat">Flat Discount (₹)</option>
                    <option value="percentage">Percentage Discount (%)</option>
                </select>
            </div>

            <div class="form-group">
                <label for="coupon-value">Discount Value</label>
                <input type="number" id="coupon-value" name="discountValue" step="0.01" min="0" placeholder="e.g. 50" required>
            </div>

            <div class="form-group">
                <label for="coupon-min-order">Minimum Order Subtotal (₹)</label>
                <input type="number" id="coupon-min-order" name="minOrderAmount" step="0.01" min="0" value="0.00" required>
            </div>

            <div class="form-group">
                <label for="coupon-restaurant">Assign to Restaurant (Scope)</label>
                <select id="coupon-restaurant" name="restaurantId" style="width:100%; padding:0.75rem; border:1px solid var(--border-color); border-radius:var(--radius-sm); outline:none; background:#fff;">
                    <option value="">-- Global Platform Coupon --</option>
                    <% if (restaurants != null) {
                        for (Restaurant r : restaurants) { %>
                            <option id="coupon-rest-opt-<%= r.getId() %>" value="<%= r.getId() %>"><%= r.getName() %></option>
                        <% }
                    } %>
                </select>
            </div>

            <div class="form-group">
                <label for="coupon-start">Start Time</label>
                <input type="datetime-local" id="coupon-start" name="startTime" required>
            </div>

            <div class="form-group">
                <label for="coupon-end">End Time</label>
                <input type="datetime-local" id="coupon-end" name="endTime" required>
            </div>

            <div class="form-group" id="coupon-active-group" style="display:none;">
                <label for="coupon-active">Status</label>
                <select id="coupon-active" name="active" style="width:100%; padding:0.75rem; border:1px solid var(--border-color); border-radius:var(--radius-sm); outline:none; background:#fff;">
                    <option value="true">Active</option>
                    <option value="false">Inactive</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Save Coupon</button>
        </form>
    </div>
</div>

</body>
</html>
