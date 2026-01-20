<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book – Booku</title>
    <link rel="stylesheet" href="../css/styleEmp.css">
</head>
<body>

    <!-- Toggle Button -->
    <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>Booku</h2>

        <div class="sidebar-nav">
            <!-- kalau ada HomeServlet nanti tukar sini -->
            <a href="home.jsp">Dashboard</a>
            <a href="EmpBookServlet" class="active">Manage Book</a>
            <a href="EmpOrderServlet">Manage Order</a>
            <a href="AnalyticsServlet">Analytics</a>
        </div>

        <div class="sidebar-footer">
            <div class="profile-section" onclick="window.location.href='profile.jsp'">
                <div class="profile-icon">👤</div>
                <div class="profile-info">
                    <div class="profile-name">User</div>
                </div>
            </div>

            <button class="logout-btn" id="logoutBtn" type="button">
                <span>Logout</span>
            </button>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content" id="mainContent">

        <div class="header">
            <h1>Add New Book</h1>
        </div>

        <div class="add-book-container">

            <!-- ✅ START FORM (bookImg sekarang memang akan submit) -->
            <form action="EmpAddBookServlet" method="post" id="addBookForm" class="add-book-form">

                <div class="image-upload-section">
                    <div class="image-preview-container" id="imagePreviewContainer">
                        <img src="" alt="Book Cover Preview" class="image-preview" id="imagePreview">
                        <div class="upload-placeholder" id="uploadPlaceholder">
                            <div style="font-size: 48px;">📚</div>
                            <p>Upload Book Cover</p>
                        </div>
                    </div>

                    <!-- ✅ ini sekarang DALAM form -->
                    <input type="text" id="bookImg" name="bookImg"
                           placeholder="e.g., book1.jpg"
                           style="margin-top: 10px; width: 100%; padding: 8px;" required>
                    <small style="color: #666;">Enter image filename (e.g., book1.jpg)</small>
                </div>

                <div class="book-form-section">

                    <div class="form-group">
                        <label for="bookName">Book Name *</label>
                        <input type="text" id="bookName" name="bookName" placeholder="Enter book name" required>
                    </div>

                    <div class="form-group">
                        <label for="bookAuthor">Author *</label>
                        <input type="text" id="bookAuthor" name="bookAuthor" placeholder="Enter author name" required>
                    </div>

                    <div class="form-group">
                        <label for="bookDescription">Description *</label>
                        <textarea id="bookDescription" name="bookDescription" placeholder="Enter book description" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="bookCategory">Category *</label>
                        <select id="bookCategory" name="bookCategory" required>
                            <option value="">Select category</option>
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
                    </div>

                    <div class="form-group">
                        <label for="bookPrice">Price (RM) *</label>
                        <input type="number" id="bookPrice" name="bookPrice" step="0.01" min="0"
                               placeholder="Enter price" required>
                    </div>

                    <div class="form-group">
                        <label for="bookPublishDate">Publish Date *</label>
                        <input type="date" id="bookPublishDate" name="bookPublishDate" required>
                    </div>

                    <div class="form-group">
                        <label for="bookAvailability">Availability *</label>
                        <select id="bookAvailability" name="bookAvailability" required>
                            <option value="">Select availability</option>
                            <option value="in-stock">In Stock</option>
                            <option value="out-of-stock">Out of Stock</option>
                            <option value="pre-order">Pre-Order</option>
                        </select>
                    </div>

                    <button type="submit" class="btn-add" id="addBtn">Add Book</button>

                </div>
            </form>
            <!-- ✅ END FORM -->

        </div>

    </div>

    <script src="../js/main
