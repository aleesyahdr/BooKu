<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
<head>
    <title>BooKu - About Us</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<header class="top-header">
    <div class="logo"><h1>BooKu</h1></div>
    <div class="header-right">
            <!-- Menu Links -->
            <nav class="header-nav">
                <a href="${pageContext.request.contextPath}/IndexServlet">Home</a>
                <a href="${pageContext.request.contextPath}/BooksServlet">Books</a>
                <a href="${pageContext.request.contextPath}/customer/contact.jsp">Contact</a>
                <a href="${pageContext.request.contextPath}/customer/about.jsp">About</a>
            </nav>

            <!-- Profile Icon + Dropdown -->
            <div class="profile-menu">
                <img src="${pageContext.request.contextPath}/img/profile.jpg" class="profile-icon" alt="Profile">
                <div class="dropdown">
                    <a href="${pageContext.request.contextPath}/customer/profile.jsp">Profile</a>
                    <a href="${pageContext.request.contextPath}/customer/orderHistory.jsp">Order History</a>
                    <% if (session.getAttribute("username") != null) { %>
                        <a href="${pageContext.request.contextPath}/customer/CustLoginServlet?action=logout">Logout</a>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/customer/login.jsp">Login</a>
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
