
<%-- 
    Document   : paymentSuccess
    Created on : Jan 20, 2026, 2:07:07 AM
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BooKu - Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Top Header -->
    <header class="top-header">
        <!-- Left side: Shop name -->
        <div class="logo">
            <h1>BooKu</h1>
        </div>

        <!-- Right side: Menu + Profile -->
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

    <!-- Navigation Bar -->

    <!-- Main Content -->
    <main>

        <!-- Image Slider (UI only) -->
        <section class="slider-section">
            <div class="slider-box">
                <div class="slides">
                    <img src="${pageContext.request.contextPath}/img/banner2.png" alt="Banner 2" class="slider-img active">
                    <img src="${pageContext.request.contextPath}/img/banner1.jpg" alt="Banner 2" class="slider-img">
                </div>
                <!-- Slider arrows -->
                <button class="slide-btn left">&#10094;</button>
                <button class="slide-btn right">&#10095;</button>
            </div>
        </section>

        <!-- Popular Books -->
        <section class="popular-section">
            <h2>Popular Books</h2>

            <div class="scroll-wrapper">

                <!-- Left arrow -->
                <button class="scroll-btn left">&#10094;</button>

                <!-- Scrollable row -->
                <div class="popular-container">
                    <%
                        List<Book> books = (List<Book>) request.getAttribute("books");
                        if (books != null && books.size() > 0) {
                            for (Book book : books) {
                    %>
                    <div class="book-card">
                        <a href="${pageContext.request.contextPath}/BookDetailsServlet?book_id=<%= book.getBook_id() %>">
                            <img src="${pageContext.request.contextPath}/img/book<%= book.getBook_id() %>.jpg" alt="<%= book.getBook_name() %>">
                            <p><%= book.getBook_name() %></p>
                        </a>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <p>No books available</p>
                    <%
                        }
                    %>
                </div>

                <!-- Right arrow -->
                <button class="scroll-btn right">&#10095;</button>

            </div>
        </section>
        
        <div class="show-more">
            <a href="${pageContext.request.contextPath}/BooksServlet" class="show-more-btn">Show More</a>
        </div>
    </main>
    
    <script src="${pageContext.request.contextPath}/js/slider.js"></script>
    <script src="${pageContext.request.contextPath}/js/popular-scroll.js"></script>

</body>
</html>