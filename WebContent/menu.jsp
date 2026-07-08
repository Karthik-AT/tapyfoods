<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.tapyfood.model.MenuItem, com.tapyfood.model.Restaurant" %>
<%!
    // Helper method to get calories
    public int getCalories(String dishName) {
        String name = dishName.toLowerCase();
        if (name.contains("pizza")) return 380;
        if (name.contains("burger")) return 450;
        if (name.contains("bucket")) return 820;
        if (name.contains("roll") || name.contains("sushi")) return 310;
        if (name.contains("steak")) return 680;
        if (name.contains("risotto")) return 420;
        if (name.contains("salmon")) return 350;
        if (name.contains("soup")) return 180;
        if (name.contains("dosa")) return 380;
        if (name.contains("idli")) return 180;
        if (name.contains("biryani")) return 520;
        if (name.contains("sub")) return 340;
        if (name.contains("bread")) return 220;
        if (name.contains("rice") || name.contains("pulav")) return 380;
        if (name.contains("kebab") || name.contains("kabab") || name.contains("wings")) return 310;
        if (name.contains("skewers")) return 280;
        if (name.contains("shake") || name.contains("latte") || name.contains("lassi")) return 250;
        if (name.contains("sundae") || name.contains("brûlée") || name.contains("mochi") || name.contains("jamun") || name.contains("tiramisu")) return 320;
        return 290;
    }

    // Helper method to get ingredients
    public String[] getIngredients(String dishName) {
        String name = dishName.toLowerCase();
        if (name.contains("pepperoni")) return new String[]{"Pepperoni", "Mozzarella", "Tomato Sauce", "Oregano"};
        if (name.contains("margherita")) return new String[]{"Mozzarella", "San Marzano", "Fresh Basil", "Olive Oil"};
        if (name.contains("paneer pizza")) return new String[]{"Paneer", "Capsicum", "Onions", "Spicy Marinara", "Mozzarella"};
        if (name.contains("veg pizza") || name.contains("farmhouse")) return new String[]{"Mozzarella", "Mushrooms", "Onions", "Tomatoes", "Capsicum"};
        if (name.contains("butter chicken")) return new String[]{"Tender Chicken", "Butter Gravy", "Kasuri Methi", "Fresh Cream"};
        if (name.contains("dal makhani")) return new String[]{"Black Lentils", "Red Kidney Beans", "Butter", "Fresh Cream"};
        if (name.contains("paneer tikka")) return new String[]{"Paneer Cubes", "Yogurt Marinade", "Capsicum", "Onions", "Chaat Masala"};
        if (name.contains("chicken biryani") || name.contains("meghana")) return new String[]{"Basmati Rice", "Chicken Pieces", "Ghee", "Mint & Coriander", "Saffron"};
        if (name.contains("paneer biryani")) return new String[]{"Basmati Rice", "Paneer Cubes", "Spicy Gravy", "Fried Onions"};
        if (name.contains("dragon roll")) return new String[]{"Shrimp Tempura", "Avocado", "Cucumber", "Spicy Mayo", "Sushi Rice"};
        if (name.contains("salmon")) return new String[]{"Atlantic Salmon", "Wasabi", "Sourdough", "Cream Cheese", "Fresh Dill"};
        if (name.contains("ramen")) return new String[]{"Ramen Noodles", "Chicken Broth", "Soft Boiled Egg", "Nori", "Bamboo Shoots"};
        if (name.contains("edamame")) return new String[]{"Young Soybeans", "Sea Salt"};
        if (name.contains("mochi")) return new String[]{"Sweet Rice Dough", "Matcha Ice Cream", "Vanilla Fill"};
        if (name.contains("matcha")) return new String[]{"Ceremonial Matcha", "Oat Milk"};
        if (name.contains("penne")) return new String[]{"Penne Pasta", "Arrabbiata Sauce", "Chilli Flakes", "Parsley"};
        if (name.contains("bruschetta")) return new String[]{"Toasted Ciabatta", "Garlic Rub", "Ripe Tomatoes", "Basil & Olive Oil"};
        if (name.contains("tiramisu")) return new String[]{"Mascarpone Cream", "Ladyfingers", "Espresso", "Cocoa Powder"};
        if (name.contains("gulab jamun")) return new String[]{"Milk Solids", "Rose Sugar Syrup", "Cardamom", "Pistachios"};
        if (name.contains("mango lassi")) return new String[]{"Alphonso Mango", "Chilled Yogurt", "Cardamom"};
        if (name.contains("bacon cheeseburger")) return new String[]{"Flame Grilled Beef", "Melted Cheddar", "Crispy Bacon", "Brioche Bun"};
        if (name.contains("veggie burger")) return new String[]{"Black Bean Patty", "Lettuce", "Tomatoes", "Pickles", "Chipotle Mayo"};
        if (name.contains("whopper")) return new String[]{"Grilled Chicken", "Sesame Bun", "Tomatoes", "Mayo", "Onions"};
        if (name.contains("zinger")) return new String[]{"Crispy Chicken Fillet", "Lettuce", "Creamy Mayo", "Sesame Bun"};
        if (name.contains("fries")) return new String[]{"Golden Potatoes", "Sea Salt"};
        if (name.contains("wings")) return new String[]{"Chicken Wings", "BBQ Glaze", "Ranch Dip"};
        if (name.contains("shake")) return new String[]{"Oreo Cookies", "Vanilla Ice Cream", "Whipped Cream"};
        if (name.contains("sundae")) return new String[]{"Fudgy Brownie", "Vanilla Ice Cream", "Hot Fudge", "Crushed Chips"};
        if (name.contains("teriyaki")) return new String[]{"Chicken Strips", "Teriyaki Glaze", "Fresh Sub Bread", "Veggies"};
        if (name.contains("shammi")) return new String[]{"Lentil Kebab", "Fresh Sub Bread", "Veggies", "Mint Sauce"};
        if (name.contains("ghee rice")) return new String[]{"Basmati Rice", "Pure Ghee", "Fried Onions", "Cashews"};
        if (name.contains("kabab")) return new String[]{"Marinated Chicken", "Spices", "Lemon Wedges"};
        if (name.contains("dosa")) return new String[]{"Rice Batter", "Potato Masala", "Mustard Seeds", "Curry Leaves", "Sambar", "Chutney"};
        if (name.contains("idli")) return new String[]{"Steamed Rice Cake", "Lentil Sambar", "Coconut Chutney"};
        if (name.contains("skewers")) return new String[]{"Marinated Skewers", "Paneer / Chicken", "Capsicum & Onion", "Mint Chutney"};
        if (name.contains("steak")) return new String[]{"Ribeye Beef", "Garlic Herb Butter", "Mashed Potatoes", "Roasted Asparagus"};
        if (name.contains("risotto")) return new String[]{"Arborio Rice", "Wild Mushrooms", "Truffle Oil", "Parmesan Shavings"};
        if (name.contains("soup")) return new String[]{"Caramelized Onions", "Toasted Crouton", "Gruyère Cheese"};
        if (name.contains("brûlée")) return new String[]{"Vanilla Custard", "Caramelized Sugar"};
        return new String[]{"Fresh Ingredients", "Spices", "Chef's Touch"};
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
        String restName = restaurant != null ? restaurant.getName() : "Menu";
    %>
    <meta name="description" content="View the full menu of <%= restName %> on Tapy Food.">
    <title><%= restName %> — Menu | Tapy Food</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages.css">
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<%
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
    String[] categories = {"Starters", "Mains", "Desserts", "Drinks"};
    String[] catIcons   = {"🥗", "🍛", "🍮", "🥤"};
%>


<div class="menu-restaurant-header">
    <div class="inner">
        <p style="color:rgba(247,238,220,0.6);font-size:0.85rem;margin-bottom:6px;">
            <a href="${pageContext.request.contextPath}/restaurants" style="color:rgba(247,238,220,0.6);text-decoration:none;">← Back to Restaurants</a>
        </p>
        <h1 class="menu-rest-name"><%= restName %></h1>
        <div class="menu-rest-meta">
            <% if (restaurant != null) { %>
            <span class="menu-rest-meta-chip">🍽 <%= restaurant.getCuisineType() %></span>
            <span class="menu-rest-meta-chip">⭐ <%= restaurant.getRating() %></span>
            <span class="menu-rest-meta-chip">⏱ <%= restaurant.getDeliveryTime() %></span>
            <span class="menu-rest-meta-chip">📍 <%= restaurant.getLocation() %></span>
            <% } %>
        </div>

        <%
            List<com.tapyfood.model.Coupon> availableCoupons = (List<com.tapyfood.model.Coupon>) request.getAttribute("coupons");
            if (availableCoupons != null && !availableCoupons.isEmpty()) {
        %>
            <div class="menu-offers-carousel" style="display: flex; gap: 12px; overflow-x: auto; padding: 15px 0 5px 0; margin-top: 15px; scrollbar-width: none; -ms-overflow-style: none;">
                <% for (com.tapyfood.model.Coupon c : availableCoupons) {
                    String discountText = "";
                    if ("flat".equalsIgnoreCase(c.getDiscountType())) {
                        discountText = "₹" + String.format("%.0f", c.getDiscountValue()) + " OFF";
                    } else {
                        discountText = String.format("%.0f", c.getDiscountValue()) + "% OFF";
                    }
                    
                    String minOrderText = "Above ₹" + String.format("%.0f", c.getMinOrderAmount());
                    if ("FIRSTRY".equals(c.getCode())) {
                        discountText = "₹100 OFF + FREE DELIVERY";
                        minOrderText = "For New Users | Min ₹149";
                    } else if ("WELCOME50".equals(c.getCode())) {
                        discountText = "₹50 OFF";
                        minOrderText = "First Order | Min ₹100";
                    }
                %>
                    <div class="offer-card" style="flex: 0 0 auto; background: rgba(255, 255, 255, 0.08); border: 1px dashed rgba(247, 238, 220, 0.3); border-radius: 10px; padding: 10px 16px; display: flex; flex-direction: column; gap: 4px; min-width: 170px; transition: all 0.2s; cursor: pointer;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='none'">
                        <div style="display: flex; align-items: center; gap: 6px; font-weight: 700; font-size: 0.85rem; color: #F7EEDC;">
                            <span style="font-size: 1rem; color: var(--color-tertiary);">🉐</span>
                            <%= discountText %>
                        </div>
                        <div style="font-size: 0.72rem; color: rgba(247, 238, 220, 0.7); font-weight: 500;">
                            <%= minOrderText %>
                        </div>
                        <div style="font-size: 0.72rem; font-weight: 700; color: var(--color-tertiary); letter-spacing: 0.05em; margin-top: 2px;">
                            USE CODE: <span style="background: rgba(217, 119, 66, 0.15); padding: 2px 6px; border-radius: 4px; border: 1px solid rgba(217, 119, 66, 0.3);"><%= c.getCode() %></span>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>
</div>


<div class="menu-category-tabs-wrap" style="background:var(--color-neutral);border-bottom:1px solid var(--color-border);position:sticky;top:72px;z-index:100;">
    <div class="menu-category-tabs">
        <%
            String activeCat = (String) request.getAttribute("categoryParam");
            if (activeCat == null || activeCat.isEmpty()) activeCat = "all";
            
            String allUrl = request.getContextPath() + "/menu?restaurantId=" + restaurant.getId() + "&category=all";
            String activeAllClass = activeCat.equalsIgnoreCase("all") ? "active" : "";
        %>
        <a class="cat-tab <%= activeAllClass %>" href="<%= allUrl %>">All</a>
        <% for (int i = 0; i < categories.length; i++) {
            String catName = categories[i];
            String catUrl = request.getContextPath() + "/menu?restaurantId=" + restaurant.getId() + "&category=" + catName;
            String activeClass = activeCat.equalsIgnoreCase(catName) ? "active" : "";
        %>
        <a class="cat-tab <%= activeClass %>" href="<%= catUrl %>">
            <%= catIcons[i] %> <%= catName %>
        </a>
        <% } %>
    </div>
</div>


<main>
    <div class="menu-grid-section">
        <% if (menuItems == null || menuItems.isEmpty()) { %>
            <div class="no-results">
                <p>No menu items found for this restaurant.</p>
            </div>
        <% } else {
            for (int i = 0; i < categories.length; i++) {
                final String cat = categories[i];
                // Check if any items exist in this category
                boolean hasCat = false;
                for (MenuItem m : menuItems) {
                    if (cat.equalsIgnoreCase(m.getCategory())) { hasCat = true; break; }
                }
                if (!hasCat) continue;
        %>

        <div class="menu-category-section" data-category="<%= cat %>">
            <h2 class="menu-category-label"><%= catIcons[i] %> <%= cat %></h2>
            <div class="menu-grid">
                <%  for (MenuItem item : menuItems) {
                        if (!cat.equalsIgnoreCase(item.getCategory())) continue;
                %>
                <article class="menu-item-card" id="item-<%= item.getId() %>" data-category="<%= item.getCategory() %>">
                    <div class="menu-item-img-wrap">
                        <img
                            src="<%= item.getImageUrl() != null ? item.getImageUrl() : "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600" %>"
                            alt="<%= item.getName() %>"
                            class="menu-item-img"
                            loading="lazy"
                        >
                        <div class="veg-indicator <%= item.isVeg() ? "veg" : "nonveg" %>"
                             title="<%= item.isVeg() ? "Vegetarian" : "Non-Vegetarian" %>"></div>
                    </div>

                    <div class="menu-item-body">
                        <span class="menu-item-cat"><%= item.getCategory() %></span>
                        <h3 class="menu-item-name"><%= item.getName() %></h3>
                        <p class="menu-item-desc"><%= item.getDescription() %></p>

                        <div class="menu-item-footer">
                            <span class="menu-item-price">₹<%= String.format("%.0f", item.getPrice()) %></span>

                            
                            <% Integer loggedUserId = (Integer) session.getAttribute("userId"); %>
                            <% if (loggedUserId != null) { %>
                                <%
                                    List<com.tapyfood.model.CartItem> cartItems = (List<com.tapyfood.model.CartItem>) request.getAttribute("cartItems");
                                    int currentQty = 0;
                                    int cartItemId = 0;
                                    if (cartItems != null) {
                                        for (com.tapyfood.model.CartItem ci : cartItems) {
                                            if (ci.getMenuId() == item.getId()) {
                                                currentQty = ci.getQuantity();
                                                cartItemId = ci.getId();
                                                break;
                                            }
                                        }
                                    }
                                %>
                                <div class="qty-selector-wrapper" data-menu-id="<%= item.getId() %>" data-cart-id="<%= cartItemId %>" data-price="<%= item.getPrice() %>">
                                    <button type="button" 
                                            class="btn btn-outline-primary btn-sm add-init-btn" 
                                            id="add-btn-<%= item.getId() %>" 
                                            style="display: <%= currentQty == 0 ? "inline-flex" : "none" %>; align-items: center; justify-content: center; gap: 4px; padding: 8px 20px; font-weight: 700; font-size: 0.9rem; border: 1.5px solid var(--color-tertiary); color: var(--color-tertiary); background: #ffffff; border-radius: 8px; cursor: pointer; transition: all 0.2s;" 
                                            onclick="addToCartAjax(<%= item.getId() %>)">
                                        ADD <span style="font-weight: 900; font-size: 1.1rem; line-height: 1;">+</span>
                                    </button>
                                    
                                    <div class="qty-selector" 
                                         id="qty-selector-<%= item.getId() %>" 
                                         style="display: <%= currentQty > 0 ? "inline-flex" : "none" %>; align-items: center; justify-content: space-between; width: 100px; height: 38px; border: 1.5px solid var(--color-tertiary); background: #ffffff; border-radius: 8px; padding: 0 8px; box-shadow: var(--shadow-sm);">
                                        <button type="button" 
                                                class="qty-btn dec-btn" 
                                                style="background: none; border: none; font-size: 1.3rem; font-weight: 800; color: var(--color-tertiary); cursor: pointer; width: 24px; height: 24px; display: flex; align-items: center; justify-content: center; outline: none; user-select: none;"
                                                onclick="updateQtyAjax(<%= item.getId() %>, -1)">−</button>
                                        <span class="qty-val" 
                                              id="qty-val-<%= item.getId() %>" 
                                              style="font-family: var(--font-body); font-weight: 700; font-size: 0.95rem; color: var(--color-tertiary); width: 24px; text-align: center;"><%= currentQty %></span>
                                        <button type="button" 
                                                class="qty-btn inc-btn" 
                                                style="background: none; border: none; font-size: 1.3rem; font-weight: 800; color: var(--color-tertiary); cursor: pointer; width: 24px; height: 24px; display: flex; align-items: center; justify-content: center; outline: none; user-select: none;"
                                                onclick="updateQtyAjax(<%= item.getId() %>, 1)">+</button>
                                    </div>
                                </div>
                            <% } else { %>
                            <a href="${pageContext.request.contextPath}/login"
                               class="btn btn-primary btn-sm">
                                Login to Order
                            </a>
                            <% } %>
                        </div>
                    </div>
                </article>
                <% } %>
            </div>
        </div>

        <% } } %>
    </div>
</main>

<!-- Floating Cart Bar -->
<div id="floating-cart-bar" style="position: fixed; bottom: 24px; left: 50%; transform: translateX(-50%); width: 90%; max-width: 600px; background: var(--color-primary); color: #ffffff; border-radius: 12px; padding: 14px 20px; display: none; align-items: center; justify-content: space-between; box-shadow: 0 10px 30px rgba(43,24,16,0.3); z-index: 1000; animation: slideUp 0.3s cubic-bezier(0.22, 1, 0.36, 1);">
    <div style="display: flex; align-items: center; gap: 12px;">
        <span style="font-size: 1.4rem;">🛒</span>
        <div>
            <span id="cart-item-count" style="font-weight: 700; font-size: 0.95rem;">0 Items</span>
            <span style="color: rgba(255,255,255,0.4); margin: 0 8px;">|</span>
            <span id="cart-total-amount" style="font-weight: 700; font-size: 0.95rem;">₹0</span>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/cart" style="background: var(--color-tertiary); color: #ffffff; text-decoration: none; padding: 8px 16px; border-radius: 8px; font-weight: 700; font-size: 0.9rem; display: flex; align-items: center; gap: 6px; transition: background 0.2s;">
        View Cart <span>➔</span>
    </a>
</div>

<style>
    @keyframes slideUp {
        from { transform: translate(-50%, 50px); opacity: 0; }
        to { transform: translate(-50%, 0); opacity: 1; }
    }
    .qty-selector-wrapper button:hover {
        background: #fdf6f0 !important;
    }
</style>

<script>
    function updateCartUI(cartItems) {
        // Reset all selector inputs on the page to 0 (ADD button visible, qty selector hidden)
        document.querySelectorAll('.qty-selector-wrapper').forEach(wrapper => {
            const menuId = wrapper.getAttribute('data-menu-id');
            wrapper.setAttribute('data-cart-id', '0');
            document.getElementById('add-btn-' + menuId).style.display = 'inline-flex';
            document.getElementById('qty-selector-' + menuId).style.display = 'none';
            document.getElementById('qty-val-' + menuId).textContent = '0';
        });

        let totalItems = 0;
        let totalPrice = 0.0;

        // Loop through active cart items returned by server
        cartItems.forEach(item => {
            const wrapper = document.querySelector('.qty-selector-wrapper[data-menu-id="' + item.menuId + '"]');
            if (wrapper) {
                const menuId = item.menuId;
                wrapper.setAttribute('data-cart-id', item.id);
                document.getElementById('add-btn-' + menuId).style.display = 'none';
                document.getElementById('qty-selector-' + menuId).style.display = 'inline-flex';
                document.getElementById('qty-val-' + menuId).textContent = item.quantity;
            }
            totalItems += item.quantity;
            totalPrice += item.quantity * item.price;
        });

        // Update floating cart bar
        const cartBar = document.getElementById('floating-cart-bar');
        if (cartBar) {
            if (totalItems > 0) {
                document.getElementById('cart-item-count').textContent = totalItems + (totalItems === 1 ? ' Item' : ' Items');
                document.getElementById('cart-total-amount').textContent = '₹' + totalPrice.toFixed(0);
                cartBar.style.display = 'flex';
            } else {
                cartBar.style.display = 'none';
            }
        }
    }

    function addToCartAjax(menuId) {
        const formData = new URLSearchParams();
        formData.append('action', 'add');
        formData.append('menuId', menuId);
        formData.append('quantity', '1');
        formData.append('ajax', 'true');

        fetch('${pageContext.request.contextPath}/cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData.toString()
        })
        .then(response => {
            if (response.status === 401) {
                window.location.href = '${pageContext.request.contextPath}/login?redirect=menu';
                return;
            }
            return response.json();
        })
        .then(cartItems => {
            if (cartItems) {
                updateCartUI(cartItems);
            }
        })
        .catch(err => console.error('Error adding to cart:', err));
    }

    function updateQtyAjax(menuId, change) {
        const wrapper = document.querySelector('.qty-selector-wrapper[data-menu-id="' + menuId + '"]');
        if (!wrapper) return;

        const cartId = wrapper.getAttribute('data-cart-id');
        const currentQty = parseInt(document.getElementById('qty-val-' + menuId).textContent);
        const newQty = currentQty + change;

        const formData = new URLSearchParams();
        formData.append('ajax', 'true');

        if (newQty <= 0) {
            formData.append('action', 'remove');
            formData.append('cartId', cartId);
        } else {
            formData.append('action', 'update');
            formData.append('cartId', cartId);
            formData.append('quantity', newQty);
        }

        fetch('${pageContext.request.contextPath}/cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData.toString()
        })
        .then(response => response.json())
        .then(cartItems => {
            if (cartItems) {
                updateCartUI(cartItems);
            }
        })
        .catch(err => console.error('Error updating quantity:', err));
    }

    // Run on page load to initialize the floating cart bar
    document.addEventListener('DOMContentLoaded', () => {
        fetch('${pageContext.request.contextPath}/cart?ajax=true')
        .then(response => {
            if (response.ok) return response.json();
        })
        .then(cartItems => {
            if (cartItems) {
                updateCartUI(cartItems);
            }
        })
        .catch(err => console.error('Error fetching initial cart state:', err));
    });
</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
