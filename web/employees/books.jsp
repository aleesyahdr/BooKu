<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books â Booku</title>
    <link rel="stylesheet" href="../css/styleEmp.css">
</head>
<body>

    <!-- Toggle Button -->
    <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">â°</button>

    <!-- Sidebar -->
   <div class="sidebar" id="sidebar">
        <h2>Booku</h2>

        <div class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/EmpHomeServlet" class="active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/ManageBookServlet">Manage Book</a>
            <a href="${pageContext.request.contextPath}/EmpOrderServlet">Manage Order</a>
            <a href="${pageContext.request.contextPath}/AnalyticsServlet">Analytics</a>
        </div>

        <div class="sidebar-footer">
            <div class="profile-section" onclick="window.location.href='${pageContext.request.contextPath}/EmpProfileServlet'">
                <div class="profile-icon">👤</div>
                <div class="profile-info">
                    <div class="profile-name">
                        <%= session.getAttribute("empFirstName") != null ? session.getAttribute("empFirstName") : "Employee" %>
                    </div>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/EmpLoginServlet?action=logout" class="logout-btn" style="text-decoration: none; text-align: center; display: block;">
                <span>Logout</span>
            </a>
        </div>
    </div>

    <div class="main-content" id="mainContent">

        <div class="header">
            <h1>Books</h1>
        </div>

        <!-- Success/Error Message -->
        <%
            String message = (String) session.getAttribute("message");
            String messageType = (String) session.getAttribute("messageType");
            if (message != null) {
        %>
        <div style="padding: 15px; margin-bottom: 20px; border-radius: 8px;
                    background-color: <%= "success".equals(messageType) ? "#d4edda" : "#f8d7da" %>;
                    color: <%= "success".equals(messageType) ? "#155724" : "#721c24" %>;
                    border: 1px solid <%= "success".equals(messageType) ? "#c3e6cb" : "#f5c6cb" %>;">
            <%= message %>
        </div>
        <%
                session.removeAttribute("message");
                session.removeAttribute("messageType");
            }
        %>

        <!-- Search Bar -->
        <div class="search-container">
            <input type="text" class="search-bar" id="searchBar" placeholder="Search books by title, author, or category...">
        </div>

        <div class="top-bar">
            <select id="categoryFilter">
                <option value="all">All Categories</option>
                <option value="Fiction">Fiction</option>
                <option value="Classic">Classic</option>
                <option value="Fantasy">Fantasy</option>
                <option value="Science Fiction">Science Fiction</option>
                <option value="Romance">Romance</option>
                <option value="Mystery">Mystery</option>
                <option value="Thriller">Thriller</option>
                <option value="Horror">Horror</option>
                <option value="Non-Fiction">Non-Fiction</option>
                <option value="Biography">Biography</option>
                <option value="Self-Help">Self-Help</option>
                <option value="Educational">Educational</option>
            </select>

            <!-- â FIXED -->
            <button class="add-btn" type="button" onclick="window.location.href='EmpAddBookServlet'">
                + Add Book
            </button>
        </div>

        <!-- BOOK GRID -->
        <div class="book-grid">
            <%
                List<Book> bookList = (List<Book>) request.getAttribute("bookList");
                if (bookList != null && !bookList.isEmpty()) {
                    for (Book book : bookList) {
            %>
            <div class="book-card"
                 data-category="<%= book.getBook_category() %>"
                 data-title="<%= book.getBook_name().toLowerCase() %>"
                 data-author="<%= book.getBook_author().toLowerCase() %>"
                 onclick="window.location.href='ManageBookServlet?id=<%= book.getBook_id() %>'">

                <img src="../images/<%= book.getBook_img() %>"
                     alt="<%= book.getBook_name() %>"
                     onerror="this.src='https://covers.openlibrary.org/b/id/10523365-L.jpg'">

                <h3><%= book.getBook_name() %></h3>
                <p class="author">by <%= book.getBook_author() %></p>
                <p class="price">RM <%= String.format("%.2f", book.getBook_price()) %></p>
            </div>
            <%
                    }
                } else {
            %>
            <div style="grid-column: 1/-1; text-align: center; padding: 40px; color: #666;">
                <p>No books found. Add your first book!</p>
            </div>
            <%
                }
            %>
        </div>

    </div>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Search functionality
        document.getElementById('searchBar').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const bookCards =
