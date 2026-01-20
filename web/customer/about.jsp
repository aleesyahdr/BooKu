<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
<head>
    <title>BooKu - About Us</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="top-header">
    <div class="logo"><h1>BooKu</h1></div>
    <div class="header-right">
        <nav class="header-nav">
            <a href="${pageContext.request.contextPath}/IndexServlet">Home</a>
            <a href="${pageContext.request.contextPath}/BooksServlet">Books</a>
            <a href="${pageContext.request.contextPath}/customer/contact.jsp">Contact</a>
            <a href="${pageContext.request.contextPath}/customer/about.jsp">About</a>
        </nav>
        <div class="profile-menu">
            <img src="${pageContext.request.contextPath}/img/profile.jpg" class="profile-icon" alt="Profile">
            <div class="dropdown">
                <%
                    // Check if user is logged in
                    String username = (String) session.getAttribute("username");
                    Integer custId = (Integer) session.getAttribute("custId");
                    boolean isLoggedIn = (username != null && custId != null);
                %>
                
                <% if (isLoggedIn) { %>
                    <!-- User is logged in - show these options -->
                    <div class="user-info">Welcome, <%= username %>!</div>
                    <a href="${pageContext.request.contextPath}/ProfileServlet">Profile</a>
                    <a href="${pageContext.request.contextPath}/OrderHistoryServlet">Order History</a>
                    <a href="${pageContext.request.contextPath}/CartServlet">My Cart</a>
                    <a href="${pageContext.request.contextPath}/CustLoginServlet?action=logout">Logout</a>
                <% } else { %>
                    <!-- User is NOT logged in - show login option -->
                    <a href="${pageContext.request.contextPath}/customer/login.jsp">Login</a>
                    <a href="${pageContext.request.contextPath}/customer/register.jsp">Register</a>
                <% } %>
            </div>
        </div>
    </div>
</header>

<div class="page-container" style="max-width:900px; margin:50px auto; padding:20px;">
    <h1 style="color:#004d40; text-align:center;">About BooKu</h1>

    <p style="font-size:16px; line-height:1.6; margin-top:20px;">
        Welcome to BooKu, your go-to online bookstore where books come alive! Our mission is to connect readers with the stories they love, from timeless classics to the latest bestsellers. 
    </p>

    <p style="font-size:16px; line-height:1.6; margin-top:20px;">
        Founded in 2025, BooKu aims to make book shopping simple, fun, and accessible to everyone. Whether you are a passionate reader or just discovering the joy of reading, we have something for you. 
    </p>

    <p style="font-size:16px; line-height:1.6; margin-top:20px;">
        Thank you for choosing BooKu and happy reading!
    </p>
</div>

</body>
</html>
