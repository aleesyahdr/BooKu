<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%-- 
    Document   : paymentSuccess
    Created on : Jan 20, 2026, 2:07:07 AM
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Book" %>

<!DOCTYPE html>
<html>
<head>
    <title>BooKu - Book Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
    
    <a href="BooksServlet" class="back-btn">Back to Books</a>
    
    <div class="details-container">
        <%
            Book book = (Book) request.getAttribute("book");
            if (book != null) {
        %>
        <!-- LEFT: book image -->
        <img src="${pageContext.request.contextPath}/img/book<%= book.getBook_id() %>.jpg" alt="<%= book.getBook_name() %>">
        
        <!-- RIGHT: book info -->
        <div class="details-info">
            <p class="category"><span class="badge"><%= book.getBook_category() %></span></p>
            <h1><%= book.getBook_name() %></h1>
            <p class="price">RM<%= String.format("%.2f", book.getBook_price()) %></p>
            
            <!-- Book Info -->
            <p class="author"><strong>Author:</strong> <%= book.getBook_author() %></p>
            <p class="published"><strong>Published:</strong> <%= book.getBook_publishDate() %></p>
            <p class="description">
                <strong>Description:</strong><br>
                <%= book.getBook_description() %>
            </p>
            
            <div class="quantity-box">
                <label>Quantity: </label>
                <input type="number" value="1" min="1">
            </div>
            <button class="cart-btn" onclick="window.location.href='cart.html'">Add to Cart</button>
        </div>
        <% } else { %>
            <p>Book not found</p>
        <% } %>
    </div>
</body>
</html>


