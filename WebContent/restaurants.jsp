<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.tapyfood.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Tapy Food — Browse all restaurants and order your favourite food online.">
    <title>Restaurants — Tapy Food</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages.css">
</head>
<body>


<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<main>
    
    <div class="page-hero">
        <span class="section-eyebrow">Discover & Order</span>
        <h1 class="sectiontitle">All Restaurants</h1>
        <p class="section-lead" style="margin:0 auto; margin-bottom: var(--sp-md);">
            Explore the finest dining spots in your city. Fresh, fast, delivered in under 30 minutes.
        </p>

        <form method="GET" action="${pageContext.request.contextPath}/restaurants" class="search-bar-wrap">
            <span class="search-icon">🔍</span>
            <input
                type="text"
                name="search"
                id="restaurant-search"
                class="search-input"
                placeholder="Search restaurants or cuisine…"
                aria-label="Search restaurants"
                value="<%= request.getAttribute("searchParam") != null ? request.getAttribute("searchParam") : "" %>"
                autocomplete="off"
            >
            <%
                String catParam = (String) request.getAttribute("categoryParam");
                if (catParam != null && !catParam.isEmpty()) {
            %>
            <input type="hidden" name="category" value="<%= catParam %>">
            <% } %>
            <button type="submit" style="display:none;">Search</button>
        </form>
    </div>

    <div class="page-wrapper restaurants-page" style="padding-top: var(--sp-lg);">

        
        <div class="filter-tabs" role="group" aria-label="Filter by cuisine">
            <%
                String currentCategory = (String) request.getAttribute("categoryParam");
                if (currentCategory == null || currentCategory.isEmpty()) {
                    currentCategory = "all";
                }
                String currentSearch = (String) request.getAttribute("searchParam");
                String searchQueryParams = "";
                if (currentSearch != null && !currentSearch.isEmpty()) {
                    searchQueryParams = "&search=" + java.net.URLEncoder.encode(currentSearch, "UTF-8");
                }

                String[] filterVals = {"all", "european", "japanese", "italian", "indian", "american"};
                String[] filterLabels = {"🍽 All", "🇪🇺 European", "🇯🇵 Japanese", "🇮🇹 Italian", "🇮🇳 Indian", "🇺🇸 American"};

                for (int i = 0; i < filterVals.length; i++) {
                    String activeClass = currentCategory.equalsIgnoreCase(filterVals[i]) ? "active" : "";
                    String url = request.getContextPath() + "/restaurants?category=" + filterVals[i] + searchQueryParams;
            %>
            <a class="filter-tab <%= activeClass %>" href="<%= url %>"><%= filterLabels[i] %></a>
            <% } %>
        </div>

        
        <%
            List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
        %>

        <div class="restaurant-grid" id="restaurant-grid">

            <% if (restaurants != null && !restaurants.isEmpty()) {
                for (Restaurant r : restaurants) {
                    String cuisine = r.getCuisineType() != null ? r.getCuisineType() : "";
                    String cuisineFilter = cuisine.toLowerCase().replaceAll("[^a-z ]", "");
            %>
            
            <div class="rest-card-wrap"
                 data-name="<%= r.getName().toLowerCase() %>"
                 data-cuisine="<%= cuisineFilter %>">

                <article class="rest-card" aria-label="<%= r.getName() %>">
                    <%
                        String imgUrl = r.getImageUrl();
                        if (imgUrl != null && !imgUrl.startsWith("http") && !imgUrl.startsWith("/")) {
                            imgUrl = request.getContextPath() + "/" + imgUrl;
                        }
                    %>
                    <div class="rest-card__img-wrap">
                        <img
                            src="<%= imgUrl != null ? imgUrl : "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=700&q=85" %>"
                            alt="<%= r.getName() %>"
                            class="rest-card__img"
                            loading="lazy"
                            <% if (!r.isActive()) { %> style="filter: grayscale(85%) opacity(70%);" <% } %>
                        >
                        <span class="rest-card__rating">⭐ <%= r.getRating() %></span>
                        <% if (!r.isActive()) { %>
                            <span style="position:absolute; top:12px; left:12px; background:#ef4444; color:#fff; padding:4px 10px; border-radius:6px; font-size:0.75rem; font-weight:700; text-transform:uppercase; box-shadow:0 2px 8px rgba(0,0,0,0.15);">Closed</span>
                        <% } %>
                    </div>

                    <div class="rest-card__body">
                        <span class="rest-card__cuisine"><%= cuisine %></span>
                        <h2 class="rest-card__name"><%= r.getName() %></h2>

                        <div class="rest-card__meta">
                            <span class="rest-card__meta-item">⏱ <%= r.getDeliveryTime() %></span>
                            <span class="rest-card__meta-item">📍 <%= r.getLocation() %></span>
                        </div>

                        <p class="rest-card__desc"><%= r.getDescription() %></p>

                        <div class="rest-card__footer">
                            <% if (r.isActive()) { %>
                            <a
                                href="${pageContext.request.contextPath}/menu?restaurantId=<%= r.getId() %>"
                                class="btn btn-primary rest-card__btn"
                                id="view-menu-<%= r.getId() %>"
                            >View Menu →</a>
                            <% } else { %>
                            <button
                                class="btn rest-card__btn"
                                disabled
                                style="background:#e5e7eb; color:#9ca3af; border-color:#e5e7eb; cursor:not-allowed; width:100%;"
                            >Closed</button>
                            <% } %>
                        </div>
                    </div>
                </article>
            </div>
            <%  }
               } else { %>
            <div class="no-results">
                <p>😔 No restaurants found. Check back soon!</p>
            </div>
            <% } %>

            
            <div id="no-results-msg" class="no-results" style="display:none;">
                <p>🔍 No restaurants match your search. Try a different keyword.</p>
            </div>

        </div>
    </div>
</main>


<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
