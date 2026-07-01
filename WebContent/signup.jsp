<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Create your Tapy Food account and start ordering.">
    <title>Sign Up — Tapy Food</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages.css">
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<div class="auth-page">
    <div class="auth-card" style="max-width:500px;">

        <div class="auth-header">
            <div class="auth-logo">🍽</div>
            <h1 class="auth-title">Create Account</h1>
            <p class="auth-subtitle">Join Tapy Food and order in minutes.</p>
        </div>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <div class="error-alert" role="alert">⚠️ <%= error %></div>
        <% } %>

        <form method="POST"
              action="${pageContext.request.contextPath}/signup"
              class="auth-form"
              id="signup-form">

            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name"
                       placeholder="e.g. Karthik Sharma"
                       value="<%= request.getAttribute("enteredName") != null ? request.getAttribute("enteredName") : "" %>"
                       required autocomplete="name">
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       placeholder="e.g. karthik@email.com"
                       value="<%= request.getAttribute("enteredEmail") != null ? request.getAttribute("enteredEmail") : "" %>"
                       required autocomplete="email">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       placeholder="At least 6 characters"
                       required autocomplete="new-password" minlength="6">
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone"
                       placeholder="+91 98765 43210"
                       autocomplete="tel">
            </div>

            <div class="form-group">
                <label for="address">Delivery Address</label>
                <textarea id="address" name="address" rows="2"
                          placeholder="Your default delivery address…"></textarea>
            </div>

            <button type="submit" class="btn btn-primary" id="signup-submit-btn">
                Create Account →
            </button>
        </form>

        <div class="auth-footer">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
