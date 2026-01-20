
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
    </head>
    
    <body class="login-page">
        <div class="login-wrapper">
            <h1 class="site-title">BooKu</h1>

            <div class="login-container">
                <h2>Login</h2>

                <!-- Login form posts to CustLoginServlet -->
                <form class="login-form" action="CustLoginServlet" method="POST">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter username" required>

                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter password" required>

                    <button type="submit" class="cart-btn">Login</button>
                </form>

                <p class="register-link">
                    Don't have an account? <a href="register.jsp">Register here</a>
                </p>

                <!-- Display error message from Servlet if login fails -->
                <c:if test="${not empty errorMessage}">
                    <p class="error-message">${errorMessage}</p>
                </c:if>
            </div>
        </div>
    </body>
</html>
