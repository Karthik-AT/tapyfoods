<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<footer id="site-footer">
    <div class="footer-inner">

        <div class="footer-brand">
            <a href="<%= request.getContextPath() %>/index.jsp" class="brand-logo" aria-label="Tapy Food Home">
                <span class="brand-icon">🍽</span>
                <strong>Tapy Food</strong>
            </a>
            <p class="footer-tagline">Taste the Difference, Delivered.</p>
        </div>

        <nav class="footer-links" aria-label="Footer navigation">
            <div class="footer-link-group">
                <h4>Explore</h4>
                <ul role="list">
                    <li><a href="<%= request.getContextPath() %>/index.jsp">Home</a></li>
                    <li><a href="<%= request.getContextPath() %>/restaurants">Restaurants</a></li>
                    <li><a href="<%= request.getContextPath() %>/cart">My Cart</a></li>
                    <li><a href="<%= request.getContextPath() %>/orders">My Orders</a></li>
                </ul>
            </div>
            <div class="footer-link-group">
                <h4>Account</h4>
                <ul role="list">
                    <li><a href="<%= request.getContextPath() %>/login">Login</a></li>
                    <li><a href="<%= request.getContextPath() %>/signup">Sign Up</a></li>
                    <li><a href="<%= request.getContextPath() %>/logout">Logout</a></li>
                </ul>
            </div>
        </nav>

        <div class="footer-social">
            <h4>Follow Us</h4>
            <div class="social-links">
                <a href="https://www.instagram.com" target="_blank" rel="noopener noreferrer"
                   class="social-btn" aria-label="Instagram">
                    <img src="https://cdn-icons-png.flaticon.com/512/2111/2111463.png" alt="" width="22" height="22">
                </a>
                <a href="https://www.twitter.com" target="_blank" rel="noopener noreferrer"
                   class="social-btn" aria-label="Twitter">
                    <img src="https://cdn-icons-png.flaticon.com/512/733/733579.png" alt="" width="22" height="22">
                </a>
                <a href="https://www.youtube.com" target="_blank" rel="noopener noreferrer"
                   class="social-btn" aria-label="YouTube">
                    <img src="https://cdn-icons-png.flaticon.com/512/1384/1384060.png" alt="" width="22" height="22">
                </a>
            </div>
        </div>

    </div>

    <div class="footer-bottom">
        <p>&copy; 2026 Tapy Food Delivery Services. All Rights Reserved.</p>
        <p class="footer-legal">
            <a href="#">Privacy Policy</a> ·
            <a href="#">Terms of Service</a> ·
            <a href="#">Cookie Policy</a>
        </p>
    </div>
</footer>
