<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Bookstore</title>
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
                <h1>Order Details</h1>
            </div>

            <div class="details-container">
                <div class="section">
                    <h2>Order Summary</h2>
                    <div class="info-row">
                        <div class="info-label">Order ID:</div>
                        <div class="info-value">#ORD001</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Customer Name:</div>
                        <div class="info-value">John Smith</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Email:</div>
                        <div class="info-value">john.smith@email.com</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Phone:</div>
                        <div class="info-value">+1 234-567-8900</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Order Date:</div>
                        <div class="info-value">November 20, 2025</div>
                    </div>
                </div>

                <div class="section">
                    <h2>Book Details</h2>
                    <div class="info-row">
                        <div class="info-label">Book Name:</div>
                        <div class="info-value">The Great Gatsby</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Author:</div>
                        <div class="info-value">F. Scott Fitzgerald</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Description:</div>
                        <div class="info-value">A classic American novel set in the Jazz Age, exploring themes of wealth, love, and the American Dream.</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Price:</div>
                        <div class="info-value">$25.99</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Quantity:</div>
                        <div class="info-value">1</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Total Price:</div>
                        <div class="info-value" style="font-weight: bold; color: #004d40;">$25.99</div>
                    </div>
                </div>

                <div class="section">
                    <h2>Proof of Payment</h2>
                    <div class="payment-proof">
                        <img src="https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=600" alt="Payment Proof">
                        <p style="margin-top: 10px; color: #6b7280;">Payment receipt uploaded by customer</p>
                    </div>
                </div>

                <div class="section">
                    <h2>Update Order Status</h2>
                    <div class="form-group">
                        <label for="orderStatus">Status Selection:</label>
                        <select id="orderStatus">
                            <option value="pending">Pending</option>
                            <option value="progress">In Progress</option>
                            <option value="completed">Completed</option>
                        </select>
                    </div>
                    <button class="btn-update" onclick="updateOrder()">Update</button>
                </div>
            </div>
        </div>
    </div>

    <div id="updateModal" class="modal">
        <div class="modal-content">
            <h3>Updated Successfully</h3>
            <button onclick="redirectToOrders()">OK</button>
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

        function updateOrder() {
            document.getElementById('updateModal').style.display = 'flex';
        }

        function redirectToOrders() {
            window.location.href = 'orders.html';
        }
    </script>
    <script src="../js/main.js"></script>
</body>
</html>