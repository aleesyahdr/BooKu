<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
<head>
    <title>BooKu - Contact Us</title>
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

    <!-- Contact Form -->
    <form>
        <label>Name:</label><br>
        <input type="text" placeholder="Your name" style="width:100%; padding:10px; margin-bottom:15px; border-radius:5px; border:1px solid #ccc;"><br>

        <label>Email:</label><br>
        <input type="email" placeholder="Your email" style="width:100%; padding:10px; margin-bottom:15px; border-radius:5px; border:1px solid #ccc;"><br>

        <label>Message:</label><br>
        <textarea placeholder="Your message" style="width:100%; padding:10px; height:150px; border-radius:5px; border:1px solid #ccc;"></textarea><br>

        <button type="submit" class="cart-btn">Send Message</button>
    </form>
</div>

</body>
</html>
