<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics - Bookstore</title>
    <link rel="stylesheet" href="../css/styleEmp.css">

</head>
<body>
    <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>Booku</h2>

        <div class="sidebar-nav">
            <a href="home.html">Dashboard</a>
            <a href="books.html">Manage Book</a>
            <a href="orders.html">Manage Order</a>
            <a href="analytics.html"class="active">Analytics</a>
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
            <div class="content-wrapper">
            <div class="header">
                <h1>Analytics Overview</h1>
                <button class="btn-print" onclick="window.print()">Print</button>
            </div>

            <div class="analytics-grid">
                <div class="stat-card">
                    <h3>Total Revenue</h3>
                    <div class="value">$12,847</div>
                    <div class="change">↑ 12.5%</div>
                </div>

                <div class="stat-card">
                    <h3>Total Orders</h3>
                    <div class="value">342</div>
                    <div class="change">↑ 8.3%</div>
                </div>

                <div class="stat-card">
                    <h3>Books Sold</h3>
                    <div class="value">428</div>
                    <div class="change">↑ 15.7%</div>
                </div>

                <div class="stat-card">
                    <h3>Avg Order Value</h3>
                    <div class="value">$37.58</div>
                    <div class="change">↑ 3.2%</div>
                </div>
            </div>

            <div class="bottom-section">

            <div class="bottom-section">
                <div class="chart-container">
                    <h2>Monthly Sales</h2>
                    <div class="chart">
                        <div class="bar-container">
                            <div class="bar" style="height: 60%;"></div>
                            <div class="bar-label">Jan</div>
                        </div>
                        <div class="bar-container">
                            <div class="bar" style="height: 70%;"></div>
                            <div class="bar-label">Feb</div>
                        </div>
                        <div class="bar-container">
                            <div class="bar" style="height: 55%;"></div>
                            <div class="bar-label">Mar</div>
                        </div>
                        <div class="bar-container">
                            <div class="bar" style="height: 80%;"></div>
                            <div class="bar-label">Apr</div>
                        </div>
                        <div class="bar-container">
                            <div class="bar" style="height: 65%;"></div>
                            <div class="bar-label">May</div>
                        </div>
                        <div class="bar-container">
                            <div class="bar" style="height: 90%;"></div>
                            <div class="bar-label">Jun</div>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <h2>Top Selling Books</h2>
                    <div class="table-wrapper">
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <th>Rank</th>
                                    <th>Book Name</th>
                                    <th>Author</th>
                                    <th>Units Sold</th>
                                    <th>Revenue</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>The Great Gatsby</td>
                                    <td>F. Scott Fitzgerald</td>
                                    <td>68</td>
                                    <td>$1,767.32</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>To Kill a Mockingbird</td>
                                    <td>Harper Lee</td>
                                    <td>54</td>
                                    <td>$999.00</td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>1984</td>
                                    <td>George Orwell</td>
                                    <td>49</td>
                                    <td>$1,078.00</td>
                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td>Pride and Prejudice</td>
                                    <td>Jane Austen</td>
                                    <td>42</td>
                                    <td>$661.50</td>
                                </tr>
                                <tr>
                                    <td>5</td>
                                    <td>The Catcher in the Rye</td>
                                    <td>J.D. Salinger</td>
                                    <td>38</td>
                                    <td>$759.62</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('mainContent');
            const toggleBtn = document.getElementById('toggleBtn');
            
            sidebar.classList.toggle('hidden');
            mainContent.classList.toggle('expanded');
            toggleBtn.classList.toggle('shifted');
        }
    </script>
    <script src="../js/main.js"></script>
</body>
</html>