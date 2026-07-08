<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Login to your Tapy Food account.">
    <title>Login — Tapy Food</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages.css">
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<div class="auth-page">
    <div class="auth-card">


        <div class="auth-header">
            <div class="auth-logo">🍽</div>
            <h1 class="auth-title">Welcome Back!</h1>
            <p class="auth-subtitle">Login to order your favourite food.</p>
        </div>


        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <div class="error-alert" role="alert">
            ⚠️ <%= error %>
        </div>
        <% } %>


        <form method="POST"
              action="${pageContext.request.contextPath}/login"
              class="auth-form"
              id="login-form">

            <% String redirect = request.getParameter("redirect"); %>
            <% if (redirect != null) { %>
            <input type="hidden" name="redirect" value="<%= redirect %>">
            <% } %>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="e.g. karthik@tapyfood.in"
                    value="<%= request.getAttribute("enteredEmail") != null ? request.getAttribute("enteredEmail") : "" %>"
                    required
                    autocomplete="email"
                >
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Enter your password"
                    required
                    autocomplete="current-password"
                    minlength="6"
                >
            </div>

            <button type="submit" class="btn btn-primary" id="login-submit-btn">
                Login →
            </button>
        </form>



        <div class="auth-footer">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/signup">Sign up for free</a>
        </div>
    </div>
</div>

</body>
</html>
