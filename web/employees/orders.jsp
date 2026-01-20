<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Bookstore</title>
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
            <a href="orders.html"class="active">Manage Order</a>
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
                <h1>Manage Orders</h1>
            </div>

            <div class="orders-container">
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer Name</th>
                            <th>Book Title</th>
                            <th>Total Price</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#ORD001</td>
                            <td>John Smith</td>
                            <td>The Great Gatsby</td>
                            <td>$25.99</td>
                            <td><span class="status-badge status-pending">Pending</span></td>
                            <td>
                                <button class="btn btn-view" onclick="viewOrder('ORD001')">View</button>
                                <button class="btn btn-delete" onclick="deleteOrder('ORD001')">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD002</td>
                            <td>Sarah Johnson</td>
                            <td>To Kill a Mockingbird</td>
                            <td>$18.50</td>
                            <td><span class="status-badge status-progress">In Progress</span></td>
                            <td>
                                <button class="btn btn-view" onclick="viewOrder('ORD002')">View</button>
                                <button class="btn btn-delete" onclick="deleteOrder('ORD002')">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD003</td>
                            <td>Michael Brown</td>
                            <td>1984</td>
                            <td>$22.00</td>
                            <td><span class="status-badge status-completed">Completed</span></td>
                            <td>
                                <button class="btn btn-view" onclick="viewOrder('ORD003')">View</button>
                                <button class="btn btn-delete" onclick="deleteOrder('ORD003')">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD004</td>
                            <td>Emily Davis</td>
                            <td>Pride and Prejudice</td>
                            <td>$15.75</td>
                            <td><span class="status-badge status-pending">Pending</span></td>
                            <td>
                                <button class="btn btn-view" onclick="viewOrder('ORD004')">View</button>
                                <button class="btn btn-delete" onclick="deleteOrder('ORD004')">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD005</td>
                            <td>David Wilson</td>
                            <td>The Catcher in the Rye</td>
                            <td>$19.99</td>
                            <td><span class="status-badge status-progress">In Progress</span></td>
                            <td>
                                <button class="btn btn-view" onclick="viewOrder('ORD005')">View</button>
                                <button class="btn btn-delete" onclick="deleteOrder('ORD005')">Delete</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h3>Deleted Successfully</h3>
            <button onclick="closeModal()">OK</button>
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

        function viewOrder(orderId) {
            window.location.href = 'orderDetails.html?id=' + orderId;
        }

        function deleteOrder(orderId) {
            document.getElementById('deleteModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }
    </script>
    <script src="../js/main.js"></script>
</body>
</html>