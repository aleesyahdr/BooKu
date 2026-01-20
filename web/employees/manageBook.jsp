<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Book" %>
<%
    Book book = (Book) request.getAttribute("book");
    String availability = (String) request.getAttribute("availability");
    if (book == null) {
        response.sendRedirect("EmpBookServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Book – Booku</title>
    <link rel="stylesheet" href="../css/styleEmp.css">
</head>
<body>
    <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>
    
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
    
    <!-- Main Content -->
    <div class="main-content" id="mainContent">
        <div class="header">
            <h1>Manage Book</h1>
        </div>
        
        <div class="book-container">
            <div class="book-image-section">
                <img src="../images/<%= book.getBook_img() %>" 
                     alt="Book Cover" 
                     class="book-image" 
                     id="bookImage"
                     onerror="this.src='https://covers.openlibrary.org/b/id/10523365-L.jpg'">
            </div>
            
            <div class="book-form-section">
                <form action="ManageBookServlet" method="post" id="bookForm">
                    <input type="hidden" name="bookId" value="<%= book.getBook_id() %>">
                    <input type="hidden" name="action" id="formAction" value="update">
                    
                    <div class="form-group">
                        <label for="bookName">Book Name *</label>
                        <input type="text" id="bookName" name="bookName" 
                               placeholder="Enter book name" 
                               value="<%= book.getBook_name() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="bookAuthor">Author *</label>
                        <input type="text" id="bookAuthor" name="bookAuthor" 
                               placeholder="Enter author name" 
                               value="<%= book.getBook_author() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="bookDescription">Description *</label>
                        <textarea id="bookDescription" name="bookDescription" 
                                  placeholder="Enter book description" required><%= book.getBook_description() %></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="bookCategory">Category *</label>
                        <select id="bookCategory" name="bookCategory" required>
                            <option value="">Select category</option>
                            <option value="Fiction" <%= "Fiction".equals(book.getBook_category()) ? "selected" : "" %>>Fiction</option>
                            <option value="Classic" <%= "Classic".equals(book.getBook_category()) ? "selected" : "" %>>Classic</option>
                            <option value="Fantasy" <%= "Fantasy".equals(book.getBook_category()) ? "selected" : "" %>>Fantasy</option>
                            <option value="Science Fiction" <%= "Science Fiction".equals(book.getBook_category()) ? "selected" : "" %>>Science Fiction</option>
                            <option value="Romance" <%= "Romance".equals(book.getBook_category()) ? "selected" : "" %>>Romance</option>
                            <option value="Mystery" <%= "Mystery".equals(book.getBook_category()) ? "selected" : "" %>>Mystery</option>
                            <option value="Thriller" <%= "Thriller".equals(book.getBook_category()) ? "selected" : "" %>>Thriller</option>
                            <option value="Horror" <%= "Horror".equals(book.getBook_category()) ? "selected" : "" %>>Horror</option>
                            <option value="Non-Fiction" <%= "Non-Fiction".equals(book.getBook_category()) ? "selected" : "" %>>Non-Fiction</option>
                            <option value="Biography" <%= "Biography".equals(book.getBook_category()) ? "selected" : "" %>>Biography</option>
                            <option value="Self-Help" <%= "Self-Help".equals(book.getBook_category()) ? "selected" : "" %>>Self-Help</option>
                            <option value="Educational" <%= "Educational".equals(book.getBook_category()) ? "selected" : "" %>>Educational</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="bookPrice">Price (RM) *</label>
                        <input type="number" id="bookPrice" name="bookPrice" 
                               step="0.01" min="0" placeholder="Enter price" 
                               value="<%= book.getBook_price() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="bookPublishDate">Publish Date *</label>
                        <input type="date" id="bookPublishDate" name="bookPublishDate" 
                               value="<%= book.getBook_publishDate() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="bookAvailability">Availability *</label>
                        <select id="bookAvailability" name="bookAvailability" required>
                            <option value="">Select availability</option>
                            <option value="in-stock" <%= "in-stock".equals(availability) ? "selected" : "" %>>In Stock</option>
                            <option value="out-of-stock" <%= "out-of-stock".equals(availability) ? "selected" : "" %>>Out of Stock</option>
                            <option value="pre-order" <%= "pre-order".equals(availability) ? "selected" : "" %>>Pre-Order</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="bookImg">Image Filename *</label>
                        <input type="text" id="bookImg" name="bookImg" 
                               placeholder="e.g., book1.jpg" 
                               value="<%= book.getBook_img() %>" required>
                    </div>
                    
                    <div class="button-group">
                        <button type="submit" class="btn btn-update" id="updateBtn">Update Book</button>
                        <button type="button" class="btn btn-delete" id="deleteBtn" onclick="confirmDelete()">Delete Book</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Overlay -->
    <div class="overlay" id="overlay"></div>
    
    <!-- Message Box -->
    <div class="message-box" id="messageBox">
        <h2 id="messageTitle">Success!</h2>
        <p id="messageText">Book updated successfully!</p>
        <button onclick="window.location.href='EmpBookServlet'">OK</button>
    </div>
    
    <!-- External JS -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        function confirmDelete() {
            if (confirm('Are you sure you want to delete this book? This action cannot be undone.')) {
                document.getElementById('formAction').value = 'delete';
                document.getElementById('bookForm').submit();
            }
        }
    </script>
</body>
</html>