<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
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
            <a href="home.html">Dashboard</a>
            <a href="books.html"class="active">Manage Book</a>
            <a href="orders.html">Manage Order</a>
            <a href="analytics.html">Analytics</a>
        </div>

        <div class="sidebar-footer">
            <div class="profile-section" onclick="window.location.href='profile.html'">
                <div class="profile-icon">👤</div>
                <div class="profile-info">
                    <div class="profile-name">User</div>
                </div>
            </div>

            <button class="logout-btn" id="logoutBtn">
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
            <div class="image-upload-section">
                <div class="image-preview-container" id="imagePreviewContainer">
                    <img src="" alt="Book Cover Preview" class="image-preview" id="imagePreview">
                    <div class="upload-placeholder" id="uploadPlaceholder">
                        <div style="font-size: 48px;">📚</div>
                        <p>Upload Book Cover</p>
                    </div>
                </div>
                <input type="file" class="file-input" id="fileInput" accept="image/*">
                <button type="button" class="upload-btn" onclick="document.getElementById('fileInput').click()">Choose Image</button>
            </div>

            <div class="book-form-section">
                <form id="addBookForm">
                    <div class="form-group">
                        <label for="bookName">Book Name</label>
                        <input type="text" id="bookName" placeholder="Enter book name" required>
                    </div>

                    <div class="form-group">
                        <label for="bookDescription">Description</label>
                        <textarea id="bookDescription" placeholder="Enter book description" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="bookPrice">Price (RM)</label>
                        <input type="text" id="bookPrice" placeholder="Enter price" required>
                    </div>

                    <div class="form-group">
                        <label for="bookAvailability">Availability</label>
                        <select id="bookAvailability" required>
                            <option value="">Select availability</option>
                            <option value="in-stock">In Stock</option>
                            <option value="out-of-stock">Out of Stock</option>
                            <option value="pre-order">Pre-Order</option>
                        </select>
                    </div>

                    <button type="button" class="btn-add" id="addBtn">Add Book</button>
                </form>
            </div>
        </div>

    </div>

    <!-- Overlay -->
    <div class="overlay" id="overlay"></div>

    <!-- Message Box -->
    <div class="message-box" id="messageBox">
        <h2>Success!</h2>
        <p>Book added successfully!</p>
        <button onclick="window.location.href='books.html'">OK</button>
    </div>

    <!-- External JS -->
    <script src="../js/main.js"></script>
    <script src="../js/addBook.js"></script>

</body>
</html>