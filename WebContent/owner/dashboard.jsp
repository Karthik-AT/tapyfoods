<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tapyfood.model.Restaurant" %>
<%@ page import="com.tapyfood.model.MenuItem" %>
<%@ page import="com.tapyfood.model.Order" %>
<%@ page import="com.tapyfood.model.OrderItem" %>
<%@ page import="java.util.List" %>
<%
    Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    Double revenue = (Double) request.getAttribute("revenue");
    if (revenue == null) revenue = 0.0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= restaurant != null ? restaurant.getName() + " — Merchant Panel" : "Merchant Panel" %></title>
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
        .merchant-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            font-family: 'Inter', sans-serif;
        }
        .merchant-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: linear-gradient(135deg, hsl(32, 95%, 45%), hsl(14, 95%, 45%));
            color: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        .merchant-info h1 {
            font-family: 'Fraunces', serif;
            font-size: 2rem;
            margin: 0 0 5px 0;
        }
        .merchant-info p {
            margin: 0;
            opacity: 0.9;
            font-size: 0.95rem;
        }
        .unassigned-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 50px 30px;
            text-align: center;
            max-width: 600px;
            margin: 80px auto;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
        }
        .unassigned-card h2 {
            font-family: 'Fraunces', serif;
            font-size: 1.8rem;
            margin-bottom: 15px;
            color: var(--text-color);
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
            background: rgba(230, 110, 20, 0.08);
            color: hsl(20, 90%, 50%);
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

        /* CSS Tabs */
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
            color: hsl(20, 90%, 50%);
        }
        .tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 2px;
            background-color: hsl(20, 90%, 50%);
        }
        .tab-pane {
            display: none;
        }
        .tab-pane.active {
            display: block;
        }

        /* Tables & Lists */
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
        
        .status-select {
            padding: 6px 10px;
            border-radius: 6px;
            border: 1px solid var(--border-color);
            background: #fff;
            outline: none;
            font-size: 0.85rem;
        }

        /* Modal styling */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.4);
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
            max-width: 500px;
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
            color: hsl(20, 90%, 50%);
            font-weight: 500;
            text-decoration: none;
            margin-right: 12px;
            cursor: pointer;
        }
        .action-link-delete {
            color: #dc2626;
        }
        .veg-dot {
            display: inline-block;
            width: 12px;
            height: 12px;
            border: 1px solid #16a34a;
            padding: 1px;
            margin-right: 6px;
        }
        .veg-dot::after {
            content: '';
            display: block;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: #16a34a;
        }
        .non-veg-dot {
            display: inline-block;
            width: 12px;
            height: 12px;
            border: 1px solid #dc2626;
            padding: 1px;
            margin-right: 6px;
        }
        .non-veg-dot::after {
            content: '';
            display: block;
            width: 0;
            height: 0;
            border-left: 4px solid transparent;
            border-right: 4px solid transparent;
            border-bottom: 8px solid #dc2626;
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

<div class="merchant-container">

    <% if (restaurant == null) { %>
        <div class="unassigned-card">
            <h2>No Restaurant Assigned</h2>
            <p>Welcome, partner! Currently, there is no restaurant associated with your account.</p>
            <p style="color:#777; font-size:0.9rem; margin-top:10px;">Please request the Platform Administrator to register your restaurant and assign it to your email address: <strong><%= session.getAttribute("userEmail") %></strong></p>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline" style="margin-top:20px;">Logout</a>
        </div>
    <% } else { %>

        <div class="merchant-header">
            <div class="merchant-info">
                <h1 style="display:flex; align-items:center; gap:15px; flex-wrap:wrap; margin:0 0 5px 0;">
                    <%= restaurant.getName() %>
                    <% if (restaurant.isActive()) { %>
                        <span style="background:#dcfce7; color:#15803d; padding:4px 12px; border-radius:30px; font-size:0.8rem; font-family:'Inter',sans-serif; font-weight:700; border:1px solid #bbf7d0;">🟢 OPEN</span>
                    <% } else { %>
                        <span style="background:#fee2e2; color:#b91c1c; padding:4px 12px; border-radius:30px; font-size:0.8rem; font-family:'Inter',sans-serif; font-weight:700; border:1px solid #fecaca;">🔴 CLOSED</span>
                    <% } %>
                </h1>
                <p>📍 <%= restaurant.getLocation() %> | Cuisine: <strong><%= restaurant.getCuisineType() %></strong></p>
            </div>
            <div style="display:flex; align-items:center; gap:20px;">
                <form method="POST" action="${pageContext.request.contextPath}/owner/restaurant" style="margin:0;">
                    <input type="hidden" name="action" value="toggleStatus">
                    <% if (restaurant.isActive()) { %>
                        <button type="submit" class="btn" style="background:#ef4444; color:#fff; border-color:#ef4444; padding:10px 20px; font-size:0.9rem; font-weight:600; border-radius:8px;">Close Restaurant</button>
                    <% } else { %>
                        <button type="submit" class="btn" style="background:#22c55e; color:#fff; border-color:#22c55e; padding:10px 20px; font-size:0.9rem; font-weight:600; border-radius:8px;">Open Restaurant</button>
                    <% } %>
                </form>
                <div style="background: rgba(255,255,255,0.2); padding: 10px 18px; border-radius: 8px; text-align:center;">
                    <span style="font-size:0.82rem; font-weight:600; text-transform:uppercase;">Rating</span>
                    <div style="font-size:1.4rem; font-weight:700; line-height:1.2;">★ <%= restaurant.getRating() %></div>
                </div>
            </div>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">💰</div>
                <div class="stat-meta">
                    <h3>Total Sales</h3>
                    <p>₹<%= String.format("%.2f", revenue) %></p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📋</div>
                <div class="stat-meta">
                    <h3>Orders Received</h3>
                    <p><%= orders != null ? orders.size() : 0 %></p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🍕</div>
                <div class="stat-meta">
                    <h3>Dishes Listed</h3>
                    <p><%= menuItems != null ? menuItems.size() : 0 %></p>
                </div>
            </div>
        </div>

        <!-- Tabs Nav -->
        <div class="tabs-nav">
            <button class="tab-btn active" onclick="switchTab('orders')">Orders Tracking</button>
            <button class="tab-btn" onclick="switchTab('menu')">Menu Manager</button>
            <button class="tab-btn" onclick="switchTab('profile')">Edit Profile</button>
        </div>

        <!-- Tab 1: Orders -->
        <div id="tab-pane-orders" class="tab-pane active">
            <div class="pane-header">
                <h2 class="pane-title">Active & Completed Orders</h2>
            </div>
            <div class="data-table-wrap">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Details</th>
                            <th>Address</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Update Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (orders == null || orders.isEmpty()) { %>
                            <tr>
                                <td colspan="6" style="text-align:center; padding:30px; color:#777;">No orders received yet.</td>
                            </tr>
                        <% } else { 
                            for (Order o : orders) { %>
                                <tr>
                                    <td><strong>#<%= o.getId() %></strong></td>
                                    <td>
                                        <div style="font-size:0.85rem; max-width:300px;">
                                            <% if (o.getItems() != null) {
                                                for (OrderItem item : o.getItems()) { %>
                                                    <div><%= item.getMenuItemName() %> x<%= item.getQuantity() %></div>
                                                <% }
                                            } %>
                                        </div>
                                    </td>
                                    <td style="font-size:0.85rem;"><%= o.getDeliveryAddress() %></td>
                                    <td><strong>₹<%= String.format("%.2f", o.getTotalAmount()) %></strong></td>
                                    <td>
                                        <% String statusClass = o.getStatus().toLowerCase().replace(" ", "-"); %>
                                        <span class="badge badge-<%= statusClass %>"><%= o.getStatus() %></span>
                                    </td>
                                    <td>
                                        <form class="inline-table-form" method="POST" action="${pageContext.request.contextPath}/owner/order">
                                            <input type="hidden" name="orderId" value="<%= o.getId() %>">
                                            <select name="status" class="status-select" onchange="this.form.submit()">
                                                <option value="Placed" <%= "Placed".equals(o.getStatus()) ? "selected" : "" %>>Placed</option>
                                                <option value="Preparing" <%= "Preparing".equals(o.getStatus()) ? "selected" : "" %>>Preparing</option>
                                                <option value="Out for Delivery" <%= "Out for Delivery".equals(o.getStatus()) ? "selected" : "" %>>Out for Delivery</option>
                                                <option value="Delivered" <%= "Delivered".equals(o.getStatus()) ? "selected" : "" %>>Delivered</option>
                                                <option value="Cancelled" <%= "Cancelled".equals(o.getStatus()) ? "selected" : "" %>>Cancelled</option>
                                            </select>
                                        </form>
                                    </td>
                                </tr>
                            <% } 
                        } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Tab 2: Menu Manager -->
        <div id="tab-pane-menu" class="tab-pane">
            <div class="pane-header">
                <h2 class="pane-title">Menu Items</h2>
                <button class="btn btn-primary" onclick="openAddMenuModal()">+ Add Menu Item</button>
            </div>
            <div class="data-table-wrap">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Dish</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Veg/Non-Veg</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (menuItems == null || menuItems.isEmpty()) { %>
                            <tr>
                                <td colspan="6" style="text-align:center; padding:30px; color:#777;">No dishes found. Add your first menu item.</td>
                            </tr>
                        <% } else { 
                            for (MenuItem item : menuItems) { %>
                                <tr>
                                    <td>
                                        <div style="display:flex; align-items:center; gap:12px;">
                                            <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
                                                <img src="<%= item.getImageUrl().startsWith("http") ? item.getImageUrl() : request.getContextPath() + "/" + item.getImageUrl() %>" style="width:40px; height:40px; border-radius:8px; object-fit:cover;">
                                            <% } else { %>
                                                <div style="width:40px; height:40px; border-radius:8px; background:#ddd; display:flex; align-items:center; justify-content:center;">🍲</div>
                                            <% } %>
                                            <strong><%= item.getName() %></strong>
                                        </div>
                                    </td>
                                    <td><%= item.getCategory() %></td>
                                    <td><strong>₹<%= String.format("%.2f", item.getPrice()) %></strong></td>
                                    <td>
                                        <% if (item.isVeg()) { %>
                                            <span class="veg-dot" title="Vegetarian"></span> <span style="font-size:0.85rem; color:#16a34a; font-weight:500;">Veg</span>
                                        <% } else { %>
                                            <span class="non-veg-dot" title="Non-Vegetarian"></span> <span style="font-size:0.85rem; color:#dc2626; font-weight:500;">Non-Veg</span>
                                        <% } %>
                                    </td>
                                    <td style="font-size:0.85rem; color:#666; max-width:250px;"><%= item.getDescription() != null ? item.getDescription() : "" %></td>
                                    <td>
                                        <a class="action-link" onclick="openEditMenuModal(<%= item.getId() %>, '<%= item.getName().replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") %>', '<%= item.getCategory().replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") %>', <%= item.getPrice() %>, '<%= item.getDescription() != null ? item.getDescription().replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") : "" %>', '<%= item.getImageUrl() != null ? item.getImageUrl().replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") : "" %>', <%= item.isVeg() %>)">Edit</a>
                                        
                                        <form class="inline-table-form" method="POST" action="${pageContext.request.contextPath}/owner/menu" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this dish?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="<%= item.getId() %>">
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

        <!-- Tab 3: Edit Profile -->
        <div id="tab-pane-profile" class="tab-pane">
            <div class="pane-header">
                <h2 class="pane-title">Configure Restaurant Details</h2>
            </div>
            <div class="auth-card" style="margin: 0; max-width: 650px; border: 1px solid var(--border-color);">
                <form method="POST" action="${pageContext.request.contextPath}/owner/restaurant" class="auth-form">
                    
                    <div class="form-group">
                        <label for="rest-name">Restaurant Name</label>
                        <input type="text" id="rest-name" name="name" value="<%= restaurant.getName() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="cuisine">Cuisine Type</label>
                        <input type="text" id="cuisine" name="cuisineType" value="<%= restaurant.getCuisineType() %>" placeholder="e.g. Italian, Fast Food" required>
                    </div>

                    <div class="form-group">
                        <label for="deliveryTime">Avg. Delivery Time</label>
                        <input type="text" id="deliveryTime" name="deliveryTime" value="<%= restaurant.getDeliveryTime() %>" placeholder="e.g. 30 mins" required>
                    </div>

                    <div class="form-group">
                        <label for="location">Restaurant Address / Location</label>
                        <input type="text" id="location" name="location" value="<%= restaurant.getLocation() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="imageUrl">Restaurant Image URL</label>
                        <input type="text" id="imageUrl" name="imageUrl" value="<%= restaurant.getImageUrl() != null ? restaurant.getImageUrl() : "" %>">
                    </div>

                    <div class="form-group">
                        <label for="offerBadge">Offer Badge Tagline</label>
                        <input type="text" id="offerBadge" name="offerBadge" value="<%= restaurant.getOfferBadge() != null ? restaurant.getOfferBadge() : "" %>" placeholder="e.g. 20% OFF up to ₹100">
                    </div>

                    <div class="form-group">
                        <label for="description">About Restaurant / Description</label>
                        <textarea id="description" name="description" rows="3" required><%= restaurant.getDescription() != null ? restaurant.getDescription() : "" %></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary" style="margin-top: 15px; width: 100%; padding: 12px; font-weight: 600; border-radius: 8px;">Save Changes</button>
                </form>
            </div>
        </div>

    <% } %>

</div>

<!-- Menu Modal (Add/Edit) -->
<div id="menu-modal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 id="modal-title" class="modal-title">Add Menu Item</h3>
            <button class="modal-close" onclick="closeMenuModal()">&times;</button>
        </div>
        <form method="POST" action="${pageContext.request.contextPath}/owner/menu" class="auth-form">
            <input type="hidden" id="menu-action" name="action" value="add">
            <input type="hidden" id="menu-id" name="id" value="">

            <div class="form-group">
                <label for="dish-name">Dish Name</label>
                <input type="text" id="dish-name" name="name" required>
            </div>

            <div class="form-group">
                <label for="dish-category">Category</label>
                <select id="dish-category" name="category" required style="width:100%; padding:0.75rem; border:1px solid var(--border-color); border-radius:var(--radius-sm); outline:none;">
                    <option value="Starters">Starters</option>
                    <option value="Mains">Mains</option>
                    <option value="Desserts">Desserts</option>
                    <option value="Drinks">Drinks</option>
                </select>
            </div>

            <div class="form-group">
                <label for="dish-price">Price (₹)</label>
                <input type="number" id="dish-price" name="price" step="0.01" min="0" required>
            </div>

            <div class="form-group">
                <label for="dish-veg">Food Preference</label>
                <select id="dish-veg" name="isVeg" style="width:100%; padding:0.75rem; border:1px solid var(--border-color); border-radius:var(--radius-sm); outline:none;">
                    <option value="true">Veg</option>
                    <option value="false">Non-Veg</option>
                </select>
            </div>

            <div class="form-group">
                <label for="dish-image">Image URL</label>
                <input type="text" id="dish-image" name="imageUrl" placeholder="images/dishes/pasta.jpg">
            </div>

            <div class="form-group">
                <label for="dish-desc">Description / Ingredients</label>
                <textarea id="dish-desc" name="description" rows="3"></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Save Dish</button>
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

    const modal = document.getElementById('menu-modal');

    function openAddMenuModal() {
        document.getElementById('modal-title').textContent = 'Add Menu Item';
        document.getElementById('menu-action').value = 'add';
        document.getElementById('menu-id').value = '';
        document.getElementById('dish-name').value = '';
        document.getElementById('dish-category').value = 'Starters';
        document.getElementById('dish-price').value = '';
        document.getElementById('dish-veg').value = 'true';
        document.getElementById('dish-image').value = '';
        document.getElementById('dish-desc').value = '';
        modal.style.display = 'flex';
    }

    function openEditMenuModal(id, name, category, price, desc, imageUrl, isVeg) {
        document.getElementById('modal-title').textContent = 'Edit Menu Item';
        document.getElementById('menu-action').value = 'edit';
        document.getElementById('menu-id').value = id;
        document.getElementById('dish-name').value = name;
        document.getElementById('dish-category').value = category;
        document.getElementById('dish-price').value = price;
        document.getElementById('dish-veg').value = isVeg ? 'true' : 'false';
        document.getElementById('dish-image').value = imageUrl;
        document.getElementById('dish-desc').value = desc;
        modal.style.display = 'flex';
    }

    function closeMenuModal() {
        modal.style.display = 'none';
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            closeMenuModal();
        }
    }
</script>

</body>
</html>
