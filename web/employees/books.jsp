<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
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

       <div class="main-content" id="mainContent">

        <div class="header">
            <h1>Books</h1>
        </div>

        <!-- Search Bar -->
        <div class="search-container">
            <input type="text" class="search-bar" id="searchBar" placeholder="Search books by title, author, or category...">
        </div>

        <div class="top-bar">
            <select id="categoryFilter">
                <option value="all">All Categories</option>
                <option value="malay">Malay</option>
                <option value="english">English</option>
                <option value="novel">Novel</option>
                <option value="comic">Comic</option>
            </select>

            <button class="add-btn" onclick="window.location.href='addBook.html'">+ Add Book</button>
        </div>

        <!-- BOOK GRID -->
        <div class="book-grid">
            <div class="book-card" onclick="window.location.href='manageBook.html'">
                <img src="https://covers.openlibrary.org/b/id/10523365-L.jpg" alt="Book">
                <h3>The Silent Observer</h3>
                <p class="author">by John Michael</p>
                <p class="price">RM 35.90</p>
            </div>

            <div class="book-card" onclick="window.location.href='manageBook.html'">
                <img src="https://covers.openlibrary.org/b/id/11153262-L.jpg" alt="Book">
                <h3>Midnight Library</h3>
                <p class="author">by Matt Haig</p>
                <p class="price">RM 29.90</p>
            </div>

            <div class="book-card" onclick="window.location.href='manageBook.html'">
                <img src="https://covers.openlibrary.org/b/id/12625165-L.jpg" alt="Book">
                <h3>The Lost City</h3>
                <p class="author">by A. Zahir</p>
                <p class="price">RM 24.50</p>
            </div>

            <div class="book-card" onclick="window.location.href='manageBook.html'">
                <img src="https://covers.openlibrary.org/b/id/9876543-L.jpg" alt="Book">
                <h3>Dream Walker</h3>
                <p class="author">by Sarah Ann</p>
                <p class="price">RM 32.00</p>
            </div>

            <div class="book-card" onclick="window.location.href='manageBook.html'">
                <img src="https://covers.openlibrary.org/b/id/12876532-L.jpg" alt="Book">
                <h3>Echoes of Yesterday</h3>
                <p class="author">by Amir Rahman</p>
                <p class="price">RM 27.90</p>
            </div>
        </div>

    </div>

    <!-- External JS -->
    <script src="../js/main.js"></script>
    <script src="../js/books.js"></script>
</body>
</html>
