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
                        <a href="${pageContext.request.contextPath}/customer/orderHistoryServlet">Order History</a>
                        <a href="${pageContext.request.contextPath}/ShoppingCartServlet">My Cart</a>
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
    
    <a href="${pageContext.request.contextPath}/BooksServlet" class="back-btn">Back to Books</a>
    
    <div class="details-container">
        <%
            Book book = (Book) request.getAttribute("book");
            if (book != null) {
        %>
        <!-- LEFT: book image -->
        <img src="${pageContext.request.contextPath}/img/<%= book.getBook_img() %>" alt="<%= book.getBook_name() %>">
        
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
                <input type="number" id="quantity-input" value="1" min="1" max="10">
            </div>
            <% if (book.getBook_available()) { %>
                <button class="cart-btn" onclick="addToCartWithQty(<%= book.getBook_id() %>)">Add to Cart</button>
            <% } else { %>
                <button class="cart-btn out-of-stock" disabled>Out of Stock</button>
            <% } %>
            
        </div>
        <% } else { %>
            <p>Book not found</p>
        <% } %>
    </div>
    
    <!-- Add cart.js for Add to Cart functionality -->
    <script src="${pageContext.request.contextPath}/js/cart.js"></script>
    <script>
        // Function to add to cart with custom quantity from input field
        function addToCartWithQty(bookId) {
            const quantityInput = document.getElementById('quantity-input');
            const quantity = parseInt(quantityInput.value);
            
            // Validate quantity
            if (quantity < 1) {
                alert('Please enter a valid quantity (minimum 1)');
                return;
            }
            
            if (quantity > 10) {
                alert('Maximum quantity is 10');
                return;
            }
            
            // Call the addToCart function from cart.js
            addToCart(bookId, quantity);
        }
    </script>
</body>
</html>



