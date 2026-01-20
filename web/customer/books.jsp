<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<!DOCTYPE html>
<html>
<head>
    <title>BooKu - Books</title>
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
    
    <div class="books-container">
        <!-- LEFT: Categories -->
        <div class="category-menu">
            <h3>Categories</h3>
            <%
                String selectedCategory = (String) request.getAttribute("selectedCategory");
                String searchQuery = (String) request.getAttribute("searchQuery");
                if (selectedCategory == null) selectedCategory = "All";
                if (searchQuery == null) searchQuery = "";
            %>
            <a href="BooksServlet?category=All" class="<%= selectedCategory.equals("All") ? "active" : "" %>">All</a>
            <a href="BooksServlet?category=Fiction" class="<%= selectedCategory.equals("Fiction") ? "active" : "" %>">Fiction</a>
            <a href="BooksServlet?category=Non-fiction" class="<%= selectedCategory.equals("Non-fiction") ? "active" : "" %>">Non-fiction</a>
            <a href="BooksServlet?category=Educational" class="<%= selectedCategory.equals("Educational") ? "active" : "" %>">Educational</a>
            <a href="BooksServlet?category=Cooking" class="<%= selectedCategory.equals("Cooking") ? "active" : "" %>">Cooking</a>
            <a href="BooksServlet?category=Fantasy" class="<%= selectedCategory.equals("Fantasy") ? "active" : "" %>">Fantasy</a>
            <a href="BooksServlet?category=Science Fiction" class="<%= selectedCategory.equals("Science Fiction") ? "active" : "" %>">Science Fiction</a>
            <a href="BooksServlet?category=Classic" class="<%= selectedCategory.equals("Classic") ? "active" : "" %>">Classic</a>
            <a href="BooksServlet?category=Romance" class="<%= selectedCategory.equals("Romance") ? "active" : "" %>">Romance</a>
        </div>
        
        <!-- RIGHT: Books section -->
        <section class="books-list">
            <!-- SEARCH FORM -->
            <form action="BooksServlet" method="get" class="search-box">
                <input type="text" name="search" placeholder="Search books..." value="<%= searchQuery %>">
                <input type="hidden" name="category" value="<%= selectedCategory %>">
                <button type="submit">Search</button>
            </form>
            
            <h2>
                <% if (!searchQuery.isEmpty()) { %>
                    Search Results for "<%= searchQuery %>"
                <% } else if (selectedCategory.equals("All")) { %>
                    All Books
                <% } else { %>
                    <%= selectedCategory %> Books
                <% } %>
            </h2>
            
            <div class="books-grid">
                <%
                    List<Book> books = (List<Book>) request.getAttribute("books");
                    if (books != null && books.size() > 0) {
                        for (Book book : books) {
                %>
                <!-- Book Item -->
                <div class="book-item">
                    <a href="BookDetailsServlet?book_id=<%= book.getBook_id() %>">
                        <img src="${pageContext.request.contextPath}/img/<%= book.getBook_img() %>" alt="<%= book.getBook_name() %>">
                    </a>
                    <h3><%= book.getBook_name() %></h3>
                    <p class="author">by <%= book.getBook_author() %></p>
                    <p class="category"><span class="badge"><%= book.getBook_category() %></span></p>
                    <p class="price">RM<%= String.format("%.2f", book.getBook_price()) %></p>
                    <button class="cart-btn" onclick="window.location.href='cart.html'">Add to Cart</button>
                </div>
                <%
                        }
                    } else {
                %>
                <p>
                    <% if (!searchQuery.isEmpty()) { %>
                        No books found matching "<%= searchQuery %>"
                    <% } else { %>
                        No books available in this category
                    <% } %>
                </p>
                <%
                    }
                %>
            </div>
        </section>
    </div>
</body>
</html>
