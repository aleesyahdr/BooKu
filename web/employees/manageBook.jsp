<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Book" %>

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

        <%
            Book book = (Book) request.getAttribute("book");
            String error = (String) request.getAttribute("error");
            
            if (book == null) {
        %>
                <div class="header">
                    <h1>Book Not Found</h1>
                </div>
                <div style="text-align: center; padding: 50px;">
                    <h3>The requested book was not found.</h3>
                    <button class="btn btn-update" onclick="window.location.href='${pageContext.request.contextPath}/employees/EmpBookServlet'">
                        Back to Books
                    </button>
                </div>
        <%
            } else {
                String bookImg = book.getBook_img();
                // Handle both URL and local file paths
                String displayImg;
                if (bookImg == null || bookImg.trim().isEmpty()) {
                    displayImg = "https://via.placeholder.com/300x400/004d40/ffffff?text=" + book.getBook_name().replace(" ", "+");
                } else if (bookImg.startsWith("http")) {
                    displayImg = bookImg;
                } else {
                    displayImg = request.getContextPath() + "/img/books/" + bookImg;
                }
        %>

        <div class="header">
            <h1>Manage Book</h1>
            <p>Edit or delete book details</p>
        </div>

        <%
            String message = request.getParameter("message");
            String status = request.getParameter("status");
        %>

        <% if (message != null) { %>
            <div class="alert alert-success">
                <%= message %>
            </div>
        <% } %>

        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <div class="book-container">
            <div class="book-image-section">
                <img src="<%= displayImg %>" 
                     alt="<%= book.getBook_name() %>" 
                     class="book-image" 
                     id="bookImage"
                     onerror="this.src='https://via.placeholder.com/300x400/004d40/ffffff?text=No+Image'">
                <div class="current-image-name">
                    Current: <%= bookImg != null && !bookImg.trim().isEmpty() ? bookImg : "No image" %>
                </div>
            </div>

            <div class="book-form-section">
                <form id="bookForm" method="post" action="${pageContext.request.contextPath}/employees/ManageBookServlet" enctype="multipart/form-data">
                    <input type="hidden" name="book_id" value="<%= book.getBook_id() %>">
                    <input type="hidden" name="action" id="formAction" value="update">
                    
                    <div class="form-group">
                        <label for="book_name">Book Name *</label>
                        <input type="text" id="book_name" name="book_name" 
                               value="<%= book.getBook_name() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="book_author">Author *</label>
                        <input type="text" id="book_author" name="book_author" 
                               value="<%= book.getBook_author() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="book_description">Description *</label>
                        <textarea id="book_description" name="book_description" required><%= book.getBook_description() != null ? book.getBook_description() : "" %></textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="book_price">Price (RM) *</label>
                            <input type="number" step="0.01" id="book_price" name="book_price" 
                                   value="<%= book.getBook_price() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="book_publishDate">Publish Date *</label>
                            <input type="date" id="book_publishDate" name="book_publishDate" 
                                   value="<%= book.getBook_publishDate() %>" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="book_category">Category *</label>
                        <input type="text" id="book_category" name="book_category" 
                               value="<%= book.getBook_category() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="bookImage">Upload New Book Image (Optional)</label>
                        <input type="file" id="bookImage" name="bookImage" 
                               accept="image/*"
                               onchange="previewImage(event)">
                        <small style="color: #666; display: block; margin-top: 5px;">
                            Leave empty to keep current image. Supported formats: JPG, PNG, GIF
                        </small>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-update" onclick="setAction('update')">
                            Update Book
                        </button>
                        <button type="button" class="btn btn-delete" onclick="confirmDelete()">
                            Delete Book
                        </button>
                        <button type="button" class="btn" style="background: #999;" 
                                onclick="window.location.href='${pageContext.request.contextPath}/employees/EmpBookServlet'">
                            Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <% } %>

    </div>

    <!-- Overlay -->
    <div class="overlay" id="overlay"></div>

    <!-- Message Box -->
    <div class="message-box" id="messageBox">
        <h2 id="messageTitle">Confirm Delete</h2>
        <p id="messageText">Are you sure you want to delete this book? This action cannot be undone.</p>
        <div style="display: flex; gap: 10px; justify-content: center;">
            <button onclick="deleteBook()" style="background-color: #d32f2f;">Yes, Delete</button>
            <button onclick="closeMessage()">Cancel</button>
        </div>
    </div>
    
    <!-- External JS -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>

    <script>
        function toggleSidebar() {
            var sidebar = document.getElementById('sidebar');
            var mainContent = document.getElementById('mainContent');
            var toggleBtn = document.getElementById('toggleBtn');
            
            sidebar.classList.toggle('hidden');
            mainContent.classList.toggle('expanded');
            toggleBtn.classList.toggle('shifted');
        }
        
        function setAction(action) {
            document.getElementById('formAction').value = action;
        }
        
        function previewImage(event) {
            var input = event.target;
            var imgElement = document.getElementById('bookImage');
            
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    imgElement.src = e.target.result;
                }
                
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        function confirmDelete() {
            document.getElementById('overlay').classList.add('show');
            document.getElementById('messageBox').classList.add('show');
        }
        
        function deleteBook() {
            document.getElementById('formAction').value = 'delete';
            document.getElementById('bookForm').submit();
        }
        
        function closeMessage() {
            document.getElementById('overlay').classList.remove('show');
            document.getElementById('messageBox').classList.remove('show');
        }
    </script>
    
    <style>
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
        
        .book-container {
            display: flex;
            gap: 30px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .book-image-section {
            flex: 0 0 300px;
        }

        .book-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }

        .current-image-name {
            margin-top: 10px;
            padding: 8px;
            background: #f5f5f5;
            border-radius: 5px;
            font-size: 12px;
            color: #666;
            text-align: center;
            word-break: break-all;
        }

        .book-form-section {
            flex: 1;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #004d40;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group input[type="date"],
        .form-group input[type="file"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #999;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .form-group input[type="file"] {
            padding: 8px;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
            font-family: Arial, sans-serif;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #004d40;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
            flex: 1;
        }

        .btn-update {
            background-color: #004d40;
            color: white;
        }

        .btn-update:hover {
            background-color: #00352d;
        }

        .btn-delete {
            background-color: #d32f2f;
            color: white;
        }

        .btn-delete:hover {
            background-color: #b71c1c;
        }

        .message-box {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            z-index: 3000;
            text-align: center;
        }

        .message-box.show {
            display: block;
        }

        .message-box h2 {
            color: #004d40;
            margin-bottom: 15px;
        }

        .message-box p {
            color: #555;
            margin-bottom: 20px;
        }

        .message-box button {
            background-color: #004d40;
            color: white;
            border: none;
            padding: 10px 30px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .message-box button:hover {
            background-color: #00352d;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 2500;
        }

        .overlay.show {
            display: block;
        }
    </style>
</html>