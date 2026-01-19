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
    <title>Dashboard - Bookstore</title>
<link rel="stylesheet" href="../css/styleEmp.css">

</head>
<body>
    
    <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>Booku</h2>

        <div class="sidebar-nav">
            <a href="home.html"class="active">Dashboard</a>
            <a href="books.html">Manage Book</a>
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
                <h1>Dashboard Overview</h1>
            </div>

            <div class="stats-box">
                <div class="card">
                    <h2>Total Sales</h2>
                    <p>RM 150.00</p>
                </div>

                <div class="card">
                    <h2>Total Books</h2>
                    <p>50</p>
                </div>

                <div class="card">
                    <h2>New Orders</h2>
                    <p>3</p>
                </div>

                <div class="card">
                    <h2>Uncompleted Orders</h2>
                    <p>1</p>
                </div>
            </div>

        </div>

    </div>

    <!-- External JS -->
    <script src="../js/main.js"></script>
</body>
</html>
