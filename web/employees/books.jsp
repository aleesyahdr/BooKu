<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books – Booku</title>
    <link rel="stylesheet" href="../css/styleEmp.css">
</head>
<body>

    <!-- Toggle Button -->
    <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>Booku</h2>

        <div class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/employees/home.jsp">Dashboard</a>
            <a href="${pageContext.request.contextPath}/employees/EmpBookServlet" class="active">Manage Books</a>
            <a href="${pageContext.request.contextPath}/employees/orders.jsp">Manage Orders</a>
            <a href="${pageContext.request.contextPath}/employees/analytics.jsp">Analytics</a>
        </div>

        <div class="sidebar-footer">
            <div class="profile-section" onclick="window.location.href='${pageContext.request.contextPath}/employees/profile.jsp'">
                <div class="profile-icon">A</div>
                <div class="profile-info">
                    <div class="profile-name">Employee User</div>
                </div>
            </div>

            <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/employees/logout.jsp'">
                <span>🚪</span> Logout
            </button>
        </div>
    </div>

    <div class="main-content" id="mainContent">

        <div class="header">
            <h1>Manage Books</h1>
            <p>View and manage your book inventory</p>
        </div>

        <%
            String message = (String) request.getAttribute("message");
            String error = (String) request.getAttribute("error");
            String selectedCategory = request.getParameter("category");
            if (selectedCategory == null) selectedCategory = "all";
            
            List<Book> books = (List<Book>) request.getAttribute("books");
            List<String> categories = (List<String>) request.getAttribute("categories");
            
            if (books == null) books = new ArrayList<Book>();
            if (categories == null) categories = new ArrayList<String>();
        %>
        
        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <!-- Search Bar -->
        <div class="search-container">
            <input type="text" class="search-bar" id="searchBar" 
                   placeholder="Search books by title, author, or category..."
                   onkeyup="searchBooks()">
        </div>

        <div class="top-bar">
            <select id="categoryFilter" onchange="filterByCategory()">
                <option value="all" <%= selectedCategory.equals("all") ? "selected" : "" %>>All Categories</option>
                <% for (String cat : categories) { %>
                    <option value="<%= cat %>" <%= selectedCategory.equals(cat) ? "selected" : "" %>>
                        <%= cat %>
                    </option>
                <% } %>
            </select>

            <button class="add-btn" onclick="window.location.href='${pageContext.request.contextPath}/employees/addBook.jsp'">
                + Add Book
            </button>
        </div>

        <!-- BOOK GRID - Dynamic from Database -->
        <div class="book-grid">
            <% if (books.isEmpty()) { %>
                <div style="grid-column: 1/-1; text-align: center; padding: 50px;">
                    <h3>No books found</h3>
                    <p>Start by adding your first book!</p>
                </div>
            <% } else { %>
                <% for (Book book : books) { %>
                    <div class="book-card" onclick="viewBook(<%= book.getBook_id() %>)">
                        <% 
                            String bookImg = book.getBook_img();
                            // Use default image if book_img is null or empty
                            if (bookImg == null || bookImg.trim().isEmpty()) {
                                bookImg = "https://via.placeholder.com/300x400/004d40/ffffff?text=No+Image";
                            }
                        %>
                        <img src="<%= bookImg.startsWith("http") 
                                ? bookImg 
                                : request.getContextPath() + "/img/books/" + bookImg %>"
                             alt="Book Image">
                        <h3><%= book.getBook_name() %></h3>
                        <p class="author">by <%= book.getBook_author() %></p>
                        <p class="category" style="font-size: 12px; color: #999; margin: 3px 0;">
                            <%= book.getBook_category() %>
                        </p>
                        <p class="price">RM <%= String.format("%.2f", book.getBook_price()) %></p>
                    </div>
                <% } %>
            <% } %>
        </div>

    </div>

    <script>
        // Sidebar toggle
        function toggleSidebar() {
            var sidebar = document.getElementById('sidebar');
            var mainContent = document.getElementById('mainContent');
            var toggleBtn = document.getElementById('toggleBtn');
            
            sidebar.classList.toggle('hidden');
            mainContent.classList.toggle('expanded');
            toggleBtn.classList.toggle('shifted');
        }
        
        // View book details
        function viewBook(bookId) {
            window.location.href = '${pageContext.request.contextPath}/employees/ManageBookServlet?id=' + bookId;
        }
        s
        // Filter by category
        function filterByCategory() {
            var category = document.getElementById('categoryFilter').value;
            window.location.href = '${pageContext.request.contextPath}/empoyees/EmpBookServlet?category=' + category;
        }
        
        // Search books (client-side filtering for better UX)
        function searchBooks() {
            var input = document.getElementById('searchBar');
            var filter = input.value.toUpperCase();
            var cards = document.getElementsByClassName('book-card');
            
            for (var i = 0; i < cards.length; i++) {
                var title = cards[i].getElementsByTagName('h3')[0];
                var author = cards[i].getElementsByClassName('author')[0];
                var category = cards[i].getElementsByClassName('category')[0];
                
                var titleText = title.textContent || title.innerText;
                var authorText = author.textContent || author.innerText;
                var categoryText = category ? (category.textContent || category.innerText) : '';
                
                if (titleText.toUpperCase().indexOf(filter) > -1 || 
                    authorText.toUpperCase().indexOf(filter) > -1 ||
                    categoryText.toUpperCase().indexOf(filter) > -1) {
                    cards[i].style.display = "";
                } else {
                    cards[i].style.display = "none";
                }
            }
        }
    </script>
    
    <style>
        /* Alert styles */
        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* Search and filter styles */
        .search-container {
            margin-bottom: 25px;
        }

        .search-bar {
            width: 100%;
            padding: 12px 20px;
            font-size: 16px;
            border: 1px solid #999;
            border-radius: 8px;
            box-sizing: border-box;
        }

        .search-bar:focus {
            outline: none;
            border-color: #004d40;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
            align-items: center;
        }

        select {
            padding: 10px;
            width: 200px;
            border-radius: 5px;
            border: 1px solid #999;
            font-size: 16px;
        }

        .add-btn {
            background-color: #004d40;
            color: white;
            border: none;
            padding: 12px 18px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .add-btn:hover {
            background-color: #00352d;
        }

        /* Book Grid */
        .book-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            max-height: 800px;
            overflow-y: auto;
            padding: 15px 0;
        }

        .book-grid::-webkit-scrollbar {
            width: 8px;
        }

        .book-grid::-webkit-scrollbar-thumb {
            background: #0b3f34;
            border-radius: 10px;
        }

        .book-card {
            background: #ffffff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            cursor: pointer;
            transition: 0.2s ease;
        }

        .book-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }

        .book-card img {
            width: 100%;
            height: 260px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 12px;
        }

        .book-card h3 {
            margin: 8px 0;
            color: #004d40;
            font-size: 16px;
        }

        .book-card .author {
            font-size: 14px;
            color: #666;
            margin: 5px 0;
        }

        .book-card .price {
            margin-top: 5px;
            font-weight: bold;
            color: #0b3f34;
        }
    </style>
</body>
</html>