
<%-- 
    Document   : paymentSuccess
    Created on : Jan 20, 2026, 2:07:07 AM
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>BooKu - Login</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <style>
            .error-message {
                color: #d32f2f;
                background-color: #ffebee;
                padding: 12px;
                border-radius: 5px;
                margin-top: 15px;
                border-left: 4px solid #d32f2f;
                font-size: 14px;
            }
            .success-message {
                color: #388e3c;
                background-color: #e8f5e9;
                padding: 12px;
                border-radius: 5px;
                margin-top: 15px;
                border-left: 4px solid #388e3c;
                font-size: 14px;
            }
        </style>
    </head>
    
    <body class="login-page">
        <div class="login-wrapper">
            <h1 class="site-title">BooKu</h1>
            <div class="login-container">
                <h2>Login</h2>
                
                <!-- Display error message BEFORE the form -->
                <c:if test="${not empty errorMessage}">
                    <p class="error-message">${errorMessage}</p>
                </c:if>
                
                <!-- Display success message (e.g., after registration) -->
                <c:if test="${not empty successMessage}">
                    <p class="success-message">${successMessage}</p>
                </c:if>
                
                <!-- Login form posts to CustLoginServlet -->
                <form class="login-form" action="${pageContext.request.contextPath}/CustLoginServlet" method="POST">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter username" required autofocus>
                    
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter password" required>
                    
                    <button type="submit" class="cart-btn">Login</button>
                </form>
                
                <p class="register-link">
                    Don't have an account? <a href="register.jsp">Register here</a>
                </p>
            </div>
        </div>
    </body>
</html>

