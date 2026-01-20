<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
<head>
    <title>BooKu - Contact Us</title>
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
    <h1 style="color:#004d40; text-align:center;">Contact Us</h1>

    <p style="text-align:center; font-size:16px; margin-bottom:30px;">
        We'd love to hear from you! Whether you have questions, suggestions, or need assistance, feel free to reach out.
    </p>

    <!-- Contact Info -->
    <div style="display:flex; flex-direction:column; gap:15px; margin-bottom:30px;">
        <p><strong>Email:</strong> info@booku.com</p>
        <p><strong>Phone:</strong> +60 12-345 6789</p>
        <p><strong>Address:</strong> 123 Book Street, Kuala Lumpur, Malaysia</p>
    </div>

</div>

</body>
</html>
