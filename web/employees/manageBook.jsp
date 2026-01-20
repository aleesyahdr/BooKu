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
    <title>Manage Book – Booku</title>
<link rel="stylesheet" href="../css/styleEmp.css">

</head>
<body>

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
            <h1>Manage Book</h1>
        </div>

        <div class="book-container">
            <div class="book-image-section">
                <img src="https://covers.openlibrary.org/b/id/10523365-L.jpg" alt="Book Cover" class="book-image" id="bookImage">
            </div>

            <div class="book-form-section">
                <form id="bookForm">
                    <div class="form-group">
                        <label for="bookName">Book Name</label>
                        <input type="text" id="bookName" placeholder="Enter book name" value="The Silent Observer">
                    </div>

                    <div class="form-group">
                        <label for="bookDescription">Description</label>
                        <textarea id="bookDescription" placeholder="Enter book description">A thrilling mystery novel that keeps you on the edge of your seat.</textarea>
                    </div>

                    <div class="form-group">
                        <label for="bookPrice">Price (RM)</label>
                        <input type="text" id="bookPrice" placeholder="Enter price" value="35.90">
                    </div>

                    <div class="form-group">
                        <label for="bookAvailability">Availability</label>
                        <select id="bookAvailability">
                            <option value="in-stock" selected>In Stock</option>
                            <option value="out-of-stock">Out of Stock</option>
                            <option value="pre-order">Pre-Order</option>
                        </select>
                    </div>

                    <div class="button-group">
                        <button type="button" class="btn btn-update" id="updateBtn">Update Book</button>
                        <button type="button" class="btn btn-delete" id="deleteBtn">Delete Book</button>
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
        <button onclick="closeMessage()">OK</button>
    </div>

    <!-- External JS -->
    <script src="../js/main.js"></script>
    <script src="../js/manageBook.js"></script>

</body>
</html>
