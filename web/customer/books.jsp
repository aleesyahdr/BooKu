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
                    String username = (String) session.getAttribute("username");
                    Integer custId = (Integer) session.getAttribute("custId");
                    boolean isLoggedIn = (username != null && custId != null);
                %>
                <% if (isLoggedIn) { %>
                    <div class="user-info">Welcome, <%= username %>!</div>
                    <a href="${pageContext.request.contextPath}/ProfileServlet">Profile</a>
                    <a href="${pageContext.request.contextPath}/OrderHistoryServlet">Order History</a>
                    <a href="${pageContext.request.contextPath}/ShoppingCartServlet">My Cart</a>
                    <a href="${pageContext.request.contextPath}/CustLoginServlet?action=logout">Logout</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/customer/login.jsp">Login</a>
                    <a href="${pageContext.request.contextPath}/customer/register.jsp">Register</a>
                <% } %>
            </div>
        </div>
    </div>
</header>
    
    <div class="books-container">
        <div class="category-menu">
            <h3>Categories</h3>
            <%
                String selectedCategory = (String) request.getAttribute("selectedCategory");
                String searchQuery = (String) request.getAttribute("searchQuery");
                if (selectedCategory == null) selectedCategory = "All";
                if (searchQuery == null) searchQuery = "";
            %>
            <a href="${pageContext.request.contextPath}/BooksServlet?category=All" class="<%= selectedCategory.equals("All") ? "active" : "" %>">All</a>
            <a href="${pageContext.request.contextPath}/BooksServlet?category=Fiction" class="<%= selectedCategory.equals("Fiction") ? "active" : "" %>">Fiction</a>
            <a href="${pageContext.request.contextPath}/BooksServlet?category=Non-fiction" class="<%= selectedCategory.equals("Non-fiction") ? "active" : "" %>">Non-fiction</a>
            <a href="${pageContext.request.contextPath}/BooksServlet?category=Educational" class="<%= selectedCategory.equals("Educational") ? "active" : "" %>">Educational</a>
            <a href="${pageContext.request.contextPath}/BooksServlet?category=Cooking" class="<%= selectedCategory.equals("Cooking") ? "active" : "" %>">Cooking</a>
            <a href="${pageContext.request.contextPath}/BooksServlet?category=Fantasy" class="<%= selectedCategory.equals("Fantasy") ? "active" : "" %>">Fantasy</a>
            <a href="${pageContext.request.contextPath}/BooksServlet?category=Science Fiction" class="<%= selectedCategory.equals("Science Fiction") ? "active" : "" %>">Science Fiction</a>
            <a href="${pageContext.request.contextPath}/BooksServlet?category=Classic" class="<%= selectedCategory.equals("Classic") ? "active" : "" %>">Classic</a>
            <a href="${pageContext.request.contextPath}/BooksServlet?category=Romance" class="<%= selectedCategory.equals("Romance") ? "active" : "" %>">Romance</a>
        </div>
        
        <section class="books-list">
            <form action="${pageContext.request.contextPath}/BooksServlet" method="get" class="search-box">
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
                <div class="book-item">
                    <a href="${pageContext.request.contextPath}/BookDetailsServlet?book_id=<%= book.getBook_id() %>">
                        <img src="${pageContext.request.contextPath}/img/<%= book.getBook_img() %>" alt="<%= book.getBook_name() %>">
                    </a>
                    <h3><%= book.getBook_name() %></h3>
                    <p class="author">by <%= book.getBook_author() %></p>
                    <p class="category"><span class="badge"><%= book.getBook_category() %></span></p>
                    <p class="price">RM<%= String.format("%.2f", book.getBook_price()) %></p>
                    <% if (book.getBook_available()) { %>
                        <button class="cart-btn" onclick="addToCart(<%= book.getBook_id() %>, 1)">Add to Cart</button>
                    <% } else { %>
                        <button class="cart-btn out-of-stock" disabled>Out of Stock</button>
                    <% } %>
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
    
    <script src="${pageContext.request.contextPath}/js/cart.js"></script>
</body>
</html>
