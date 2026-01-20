<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>BooKu - Login</title>
        <link rel="stylesheet" href="../css/styleEmp.css">
    </head>
    <body class="login-page">
        <div class="login-wrapper">
            <h1 class="site-title">BooKu Staff</h1>
            <div class="login-container">
                <h2>Login</h2>
                
                <c:if test="${not empty errorMessage}">
                    <p style="color: red; text-align: center;">${errorMessage}</p>
                </c:if>

                <form class="login-form" action="${pageContext.request.contextPath}/EmpLoginServlet" method="POST">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter username" required>

                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter password" required>

                    <form action="${pageContext.request.contextPath}/EmpLoginServlet" method="POST">
    <button type="submit">Login</button>
</form>
                </form>
            </div>
        </div>
    </body>
</html>