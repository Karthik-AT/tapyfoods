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
            <% if (restaurant.getOfferBadge() != null && !restaurant.getOfferBadge().isEmpty()) { %>
            <span class="menu-rest-meta-chip menu-offer-chip">🏷 <%= restaurant.getOfferBadge() %></span>
            <% } } %>
        </div>
    </div>
</div>


<div class="menu-category-tabs-wrap" style="background:var(--color-neutral);border-bottom:1px solid var(--color-border);position:sticky;top:72px;z-index:100;">
    <div class="menu-category-tabs">
        <button class="cat-tab active" data-category="all">All</button>
        <% for (int i = 0; i < categories.length; i++) { %>
        <button class="cat-tab" data-category="<%= categories[i] %>">
            <%= catIcons[i] %> <%= categories[i] %>
        </button>
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
                            <form method="POST"
                                  action="${pageContext.request.contextPath}/cart"
                                  class="qty-form add-to-cart-form">
                                <input type="hidden" name="action"   value="add">
                                <input type="hidden" name="menuId"   value="<%= item.getId() %>">
                                <input type="hidden" name="quantity" value="1" class="qty-hidden-input">

                                <div style="display:flex;align-items:center;gap:8px;">
                                    <button type="button" class="qty-btn dec" aria-label="Decrease">−</button>
                                    <span class="qty-display">1</span>
                                    <button type="button" class="qty-btn inc" aria-label="Increase">+</button>
                                    <button type="submit" class="btn btn-primary btn-sm add-to-cart-btn">
                                        Add to Cart
                                    </button>
                                </div>
                            </form>
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

<%@ include file="/WEB-INF/includes/footer.jsp" %>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
