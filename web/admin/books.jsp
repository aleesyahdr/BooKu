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

    <style>
        body {
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #ffffff;
    }

    /* Sidebar same theme */
    .sidebar {
        width: 250px;
        background-color: black;
        color: #ffffff;
        padding: 20px 20px 0 20px;
        position: fixed;
        height: 100vh;
        top: 0;
        left: 0;
        transition: transform 0.3s ease;
        z-index: 1000;
        display: flex;
        flex-direction: column;
        overflow: hidden;
    }

    .sidebar.hidden {
        transform: translateX(-100%);
    }

    .sidebar h2 {
        margin-bottom: 30px;
        color:#4caf50;
    }

    /* Sidebar Navigation */
    .sidebar-nav {
        flex: 1;
        overflow-y: auto;
        margin-bottom: 15px;
    }

    .sidebar-nav::-webkit-scrollbar {
        width: 5px;
    }

    .sidebar-nav::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.3);
        border-radius: 10px;
    }

    .sidebar a {
        color: white;
        text-decoration: none;
        padding: 12px;
        display: block;
        border-radius: 5px;
        margin-bottom: 10px;
        font-weight: bold;
    }

    .sidebar a:hover,
    .sidebar a.active {
        background-color: #004d40;
    }

    /* Sidebar Footer */
    .sidebar-footer {
        padding: 15px 0 15px 0;
        border-top: 1px solid rgba(255, 255, 255, 0.2);
    }

    .profile-section {
        display: flex;
        align-items: center;
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .profile-section:hover {
        background-color: rgba(0, 0, 0, 0.3);
    }

    .profile-icon {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        background-color: #ffffff;
        color: #004d40;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        font-weight: bold;
        margin-right: 12px;
    }

    .profile-info {
        flex: 1;
    }

    .profile-name {
        font-size: 14px;
        font-weight: bold;
    }

    .logout-btn {
        background-color: #d32f2f;
        color: white;
        border: none;
        padding: 10px;
        width: 100%;
        border-radius: 5px;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        margin-bottom: 20px;
    }

    .logout-btn:hover {
        background-color: #b71c1c;
    }

    /* Main Content */
    .main-content {
        margin-left: 290px;
        padding: 30px 40px;
        flex: 1;
        transition: margin-left 0.3s ease;
    }

    .main-content.expanded {
        margin-left: 80px;
    }

    /* Toggle Button */
    .toggle-btn {
        position: fixed;
        top: 20px;
        left: 270px;
        background-color: black;
        color: white;
        border: none;
        padding: 10px 15px;
        font-size: 22px;
        cursor: pointer;
        border-radius: 5px;
        z-index: 2001;
        transition: left 0.3s ease;
    }

    .toggle-btn.shifted {
        left: 20px;
    }

    /* Page Header */
    .header {
        background: white;
        padding: 20px 30px;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        margin-bottom: 25px;
    }

    .header h1 {
        color: #004d40;
        margin: 0;
        font-size: 28px;
    }

        /* Search Bar */
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

        /* Category + Add Button */
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
        }

        .add-btn:hover {
            background-color: #00352d;
        }

        /* Book Grid - 4 columns */
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
</head>
<body>

    <!-- Toggle Button -->
<button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>Booku</h2>

        <div class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/home.jsp">Dashboard</a>
            <a href="${pageContext.request.contextPath}/manageUserServlet">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/books.jsp" class="active">Manage Book</a>
            <a href="${pageContext.request.contextPath}/admin/orders.jsp">Manage Order</a>
            <a href="${pageContext.request.contextPath}/admin/analytics.jsp">Analytics</a>
        </div>

        <div class="sidebar-footer">
            <div class="profile-section" onclick="window.location.href='${pageContext.request.contextPath}/admin/profile.jsp'">
                <div class="profile-icon">👤</div>
                <div class="profile-info">
                    <div class="profile-name">Admin User</div>
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
