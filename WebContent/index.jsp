<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Tapy Food — Premium food delivery from the best restaurants in your city. Fresh, fast, and delicious meals delivered to your doorstep in under 30 minutes.">
    <meta name="keywords" content="food delivery, restaurant, order food online, Tapy Food, best restaurants">
    <title>Tapy Food — Taste the Difference, Delivered.</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages.css">
</head>
<body>


<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<main>
    <!-- ===================== HERO SECTION ===================== -->
    <section id="home" aria-labelledby="hero-heading">
        <div class="hero-content">
            <span class="hero-label" aria-label="New">✦ Crafted with care, delivered with speed</span>
            <h1 class="heading" id="hero-heading">
                Hungry? Let<br>
                <em>Tapy Food</em><br>
                Handle It.
            </h1>
            <p class="hero-description">From legendary bistros to hidden local gems — we bring the city's finest cuisine straight to your table. Hot, fresh, and in under 30 minutes.</p>
            <div class="hero-actions">
                <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary" id="hero-browse-btn">Browse Restaurants</a>
                <a href="#best-restaurants" class="btn btn-ghost" id="hero-restaurants-btn">View Best Sellers</a>
            </div>
            <div class="hero-stats">
                <div class="stat-item">
                    <span class="stat-number">500+</span>
                    <span class="stat-label">Partner Restaurants</span>
                </div>
                <div class="stat-divider" aria-hidden="true"></div>
                <div class="stat-item">
                    <span class="stat-number">30 min</span>
                    <span class="stat-label">Average Delivery</span>
                </div>
                <div class="stat-divider" aria-hidden="true"></div>
                <div class="stat-item">
                    <span class="stat-number">4.9★</span>
                    <span class="stat-label">Customer Rating</span>
                </div>
            </div>
        </div>
        <div class="hero-image-wrap" aria-hidden="true">
            <img
                src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=900&q=90&auto=format&fit=crop"
                alt="A beautifully plated gourmet meal"
                class="hero-img"
                width="900"
                height="700"
                loading="eager"
            >
            <div class="hero-badge">
                <span class="badge-emoji">🔥</span>
                <div>
                    <p class="badge-title">Trending Today</p>
                    <p class="badge-sub">Garlic Butter Ribeye</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================== HOW IT WORKS ===================== -->
    <section id="how-it-works" aria-labelledby="how-heading">
        <div class="section-intro full-width">
            <span class="section-eyebrow">Simple Process</span>
            <h2 class="sectiontitle" id="how-heading">Order in 3 Easy Steps</h2>
        </div>
        <div class="steps-grid full-width">
            <div class="step-card">
                <div class="step-number" aria-hidden="true">01</div>
                <div class="step-icon" aria-hidden="true">🔍</div>
                <h3 class="step-title">Browse Menus</h3>
                <p class="step-desc">Explore hundreds of restaurants and thousands of dishes curated for your taste.</p>
            </div>
            <div class="step-card">
                <div class="step-number" aria-hidden="true">02</div>
                <div class="step-icon" aria-hidden="true">🛒</div>
                <h3 class="step-title">Place Your Order</h3>
                <p class="step-desc">Add your favorites to the cart and checkout securely in seconds.</p>
            </div>
            <div class="step-card">
                <div class="step-number" aria-hidden="true">03</div>
                <div class="step-icon" aria-hidden="true">🚴</div>
                <h3 class="step-title">Fast Delivery</h3>
                <p class="step-desc">Sit back and relax. Your hot meal arrives at your door in under 30 minutes.</p>
            </div>
        </div>
    </section>

    <!-- ===================== ABOUT SECTION ===================== -->
    <section id="about" aria-labelledby="about-heading">
        <div class="about-image-col">
            <img
                src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800&q=85&auto=format&fit=crop"
                alt="Chef preparing gourmet food in a restaurant kitchen"
                class="about-img"
                width="800"
                height="600"
                loading="lazy"
            >
            <div class="about-badge-float">
                <span class="badge-emoji">🏆</span>
                <div>
                    <p class="badge-title">Award Winning</p>
                    <p class="badge-sub">Best Delivery App 2026</p>
                </div>
            </div>
        </div>
        <div class="about-content-col">
            <span class="section-eyebrow">Our Story</span>
            <h2 class="sectiontitle" id="about-heading">We're Obsessed With Great Food</h2>
            <p>Founded in 2026, Tapy Food has grown from a passionate local startup into one of the most trusted food delivery networks in the region. Our mission is simple — to connect food lovers with extraordinary meals from local kitchens they'll cherish.</p>
            <p>We work closely with expert chefs, certified culinary teams, and qualified delivery partners who take pride in ensuring every meal arrives piping hot and beautifully presented — just as the chef intended.</p>
            <ul class="about-list" role="list">
                <li>✓ 100% Contactless, safe delivery</li>
                <li>✓ Supporting 500+ local restaurants</li>
                <li>✓ 24 / 7 customer support</li>
                <li>✓ Real-time order tracking</li>
            </ul>
            <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary" id="about-restaurants-btn">
                Explore Restaurants
            </a>
        </div>
    </section>

    <!-- ===================== BEST RESTAURANTS SECTION ===================== -->
    <section id="best-restaurants" aria-labelledby="restaurants-heading">
        <div class="section-intro full-width">
            <span class="section-eyebrow">Highly Rated</span>
            <h2 class="sectiontitle" id="restaurants-heading">Best Restaurants</h2>
            <p class="section-lead">Discover the highest-rated dining spots in town, handpicked by our community of food lovers.</p>
        </div>

        <!-- Restaurant 1 -->
        <article class="restaurant-card" aria-label="The Grand Bistro">
            <div class="card-image-wrap">
                <img src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=700&q=85&auto=format&fit=crop"
                     alt="Elegant interior of The Grand Bistro restaurant" loading="lazy" width="700" height="400">
                <span class="card-badge">⭐ 4.9</span>
            </div>
            <div class="card-body">
                <span class="card-label">European · Fine Dining</span>
                <h3>The Grand Bistro</h3>
                <p>Classic European dining with a modern twist — artisan pasta, grilled prime steaks, and freshly baked pastries by world-class chefs.</p>
                <a href="${pageContext.request.contextPath}/menu?restaurantId=11" class="btn btn-primary" id="view-grand-bistro">View Menu →</a>
            </div>
        </article>

        <!-- Restaurant 2 -->
        <article class="restaurant-card" aria-label="Sushi Zen">
            <div class="card-image-wrap">
                <img src="https://images.unsplash.com/photo-1552566626-52f8b828add9?w=700&q=85&auto=format&fit=crop"
                     alt="Beautifully arranged sushi platter at Sushi Zen" loading="lazy" width="700" height="400">
                <span class="card-badge">⭐ 4.8</span>
            </div>
            <div class="card-body">
                <span class="card-label">Japanese · Sushi</span>
                <h3>Sushi Zen</h3>
                <p>Authentic Japanese delicacies with fresh ingredients flown in daily — traditional sashimi, signature rolls, and savory ramen bowls.</p>
                <a href="${pageContext.request.contextPath}/menu?restaurantId=12" class="btn btn-primary" id="view-sushi-zen">View Menu →</a>
            </div>
        </article>

        <!-- Restaurant 3 -->
        <article class="restaurant-card" aria-label="Bella Italia">
            <div class="card-image-wrap">
                <img src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=700&q=85&auto=format&fit=crop"
                     alt="Warm and rustic ambiance of Bella Italia restaurant" loading="lazy" width="700" height="400">
                <span class="card-badge">⭐ 4.7</span>
            </div>
            <div class="card-body">
                <span class="card-label">Italian · Pizza & Pasta</span>
                <h3>Bella Italia</h3>
                <p>Hand-stretched stone-baked pizzas, rich lasagna, and premium house wines that make every dinner feel like a celebration in Rome.</p>
                <a href="${pageContext.request.contextPath}/menu?restaurantId=13" class="btn btn-primary" id="view-bella-italia">View Menu →</a>
            </div>
        </article>
    </section>

    <!-- ===================== BEST SELLERS SECTION ===================== -->
    <section id="best-sellers" aria-labelledby="sellers-heading">
        <div class="section-intro full-width">
            <span class="section-eyebrow">Fan Favourites</span>
            <h2 class="sectiontitle" id="sellers-heading">Trending &amp; Best Selling</h2>
            <p class="section-lead">Our customers can't get enough of these crowd-pleasing dishes. Order yours before they sell out!</p>
        </div>

        <article class="food-card" aria-label="Pepperoni Supreme Pizza">
            <div class="card-image-wrap">
                <img src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=700&q=85&auto=format&fit=crop"
                     alt="Crispy pepperoni pizza with melted mozzarella" loading="lazy" width="700" height="400">
                <span class="card-badge card-badge--hot">🔥 Hot</span>
            </div>
            <div class="card-body">
                <span class="card-label">Italian · Pizza</span>
                <h3>Pepperoni Supreme Pizza</h3>
                <p>Crispy thin crust, tangy tomato sauce, fresh mozzarella, premium Italian pepperoni and organic oregano.</p>
                <div class="card-footer">
                    <span class="price">₹499</span>
                    <a href="${pageContext.request.contextPath}/menu?restaurantId=13#item-19" class="btn btn-primary btn-sm">Order Now</a>
                </div>
            </div>
        </article>

        <article class="food-card" aria-label="Butter Chicken">
            <div class="card-image-wrap">
                <img src="https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=700&q=85&auto=format&fit=crop"
                     alt="Creamy butter chicken in a rich tomato gravy" loading="lazy" width="700" height="400">
                <span class="card-badge card-badge--hot">🔥 Hot</span>
            </div>
            <div class="card-body">
                <span class="card-label">Indian · Mains</span>
                <h3>Butter Chicken</h3>
                <p>Tender chicken in a velvety, mildly spiced tomato and cream sauce. Best paired with naan or basmati rice.</p>
                <div class="card-footer">
                    <span class="price">₹349</span>
                    <a href="${pageContext.request.contextPath}/menu?restaurantId=14#item-25" class="btn btn-primary btn-sm">Order Now</a>
                </div>
            </div>
        </article>

        <article class="food-card" aria-label="Dragon Roll">
            <div class="card-image-wrap">
                <img src="https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=700&q=80"
                     alt="Dragon Roll sushi with avocado and spicy mayo" loading="lazy" width="700" height="400">
                <span class="card-badge">⭐ Chef's Pick</span>
            </div>
            <div class="card-body">
                <span class="card-label">Japanese · Sushi</span>
                <h3>Dragon Roll</h3>
                <p>Shrimp tempura and cucumber inside, topped with avocado and spicy mayo drizzle. A fan favorite.</p>
                <div class="card-footer">
                    <span class="price">₹649</span>
                    <a href="${pageContext.request.contextPath}/menu?restaurantId=12#item-13" class="btn btn-primary btn-sm">Order Now</a>
                </div>
            </div>
        </article>

        <article class="food-card" aria-label="Double Bacon Cheeseburger">
            <div class="card-image-wrap">
                <img src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=700&q=85&auto=format&fit=crop"
                     alt="Juicy double bacon cheeseburger on a brioche bun" loading="lazy" width="700" height="400">
                <span class="card-badge card-badge--hot">🔥 Hot</span>
            </div>
            <div class="card-body">
                <span class="card-label">American · Burgers</span>
                <h3>Double Bacon Cheeseburger</h3>
                <p>Two flame-grilled beef patties, melted cheddar, crispy bacon, fresh lettuce, tomato, and secret burger sauce on a toasted brioche bun.</p>
                <div class="card-footer">
                    <span class="price">₹379</span>
                    <a href="${pageContext.request.contextPath}/menu?restaurantId=15#item-31" class="btn btn-primary btn-sm">Order Now</a>
                </div>
            </div>
        </article>
    </section>

    <!-- ===================== TESTIMONIALS ===================== -->
    <section id="testimonials" aria-labelledby="testimonials-heading">
        <div class="section-intro full-width">
            <span class="section-eyebrow">Real Reviews</span>
            <h2 class="sectiontitle" id="testimonials-heading">What Our Customers Say</h2>
        </div>
        <div class="testimonial-card">
            <p class="testimonial-text">"Tapy Food changed how I eat. The quality is incredible and delivery is always on time. It's now a weekly ritual for our family."</p>
            <div class="testimonial-author">
                <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=80&q=80&auto=format&fit=crop&face" alt="Sarah M. portrait" class="author-avatar" width="48" height="48" loading="lazy">
                <div>
                    <p class="author-name">Sarah M.</p>
                    <p class="author-role">Food Enthusiast, Mumbai</p>
                </div>
            </div>
        </div>
        <div class="testimonial-card">
            <p class="testimonial-text">"The selection of restaurants is unmatched. From fine dining to street food favourites — Tapy Food has it all and delivers with care."</p>
            <div class="testimonial-author">
                <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=80&q=80&auto=format&fit=crop&face" alt="Rahul K. portrait" class="author-avatar" width="48" height="48" loading="lazy">
                <div>
                    <p class="author-name">Rahul K.</p>
                    <p class="author-role">Foodie &amp; Blogger, Bangalore</p>
                </div>
            </div>
        </div>
        <div class="testimonial-card">
            <p class="testimonial-text">"I ordered for a team lunch and it was seamless. Fresh, beautifully packed, and arrived exactly on time. Highly recommend."</p>
            <div class="testimonial-author">
                <img src="https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=80&q=80&auto=format&fit=crop&face" alt="Priya S. portrait" class="author-avatar" width="48" height="48" loading="lazy">
                <div>
                    <p class="author-name">Priya S.</p>
                    <p class="author-role">Product Manager, Hyderabad</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================== CONTACT SECTION ===================== -->
    <section id="contact" aria-labelledby="contact-heading">
        <div class="contact-intro full-width">
            <span class="section-eyebrow">Get in Touch</span>
            <h2 class="sectiontitle" id="contact-heading">Contact Us / Request Catering</h2>
            <p class="section-lead">Questions about your order, need support, or want to plan a catering event? We'll get back to you within 2 hours.</p>
        </div>
        <div class="contact-wrap full-width">
            <div class="contact-info">
                <h3>We're Here to Help</h3>
                <ul class="contact-details" role="list">
                    <li>
                        <span class="contact-icon" aria-hidden="true">📍</span>
                        <div>
                            <p class="contact-detail-label">Address</p>
                            <p>42, Food Street, Gourmet District, Mumbai 400001</p>
                        </div>
                    </li>
                    <li>
                        <span class="contact-icon" aria-hidden="true">📞</span>
                        <div>
                            <p class="contact-detail-label">Phone</p>
                            <p>+91 98765 43210</p>
                        </div>
                    </li>
                    <li>
                        <span class="contact-icon" aria-hidden="true">✉️</span>
                        <div>
                            <p class="contact-detail-label">Email</p>
                            <p>hello@tapyfood.in</p>
                        </div>
                    </li>
                    <li>
                        <span class="contact-icon" aria-hidden="true">🕐</span>
                        <div>
                            <p class="contact-detail-label">Support Hours</p>
                            <p>24 / 7, every day of the year</p>
                        </div>
                    </li>
                </ul>
            </div>
            <form action="#" method="POST" id="contact-form" aria-label="Contact and catering request form">
                <div class="form-group">
                    <label for="user-name">Full Name</label>
                    <input type="text" id="user-name" name="name" placeholder="e.g. Karthik Sharma" required autocomplete="name">
                </div>
                <div class="form-group">
                    <label for="user-email">Email Address</label>
                    <input type="email" id="user-email" name="email" placeholder="e.g. karthik@email.com" required autocomplete="email">
                </div>
                <div class="form-group">
                    <label for="user-phone">Mobile Number</label>
                    <input type="tel" id="user-phone" name="phone" placeholder="e.g. +91 98765 43210" required autocomplete="tel">
                </div>
                <div class="form-group">
                    <label for="user-message">Message / Catering Request</label>
                    <textarea id="user-message" name="message" rows="4" placeholder="Tell us how we can help you..."></textarea>
                </div>
                <button type="submit" class="btn btn-primary" id="contact-submit-btn">Send Message</button>
            </form>
        </div>
    </section>
</main>


<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
