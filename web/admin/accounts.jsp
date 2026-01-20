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
    <title>Account Management - Bookstore Admin</title>
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

        /* Account Type Selection */
        .account-type-section {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .account-btn {
            background: white;
            border: 2px solid #004d40;
            padding: 30px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 18px;
            font-weight: bold;
            color: #004d40;
            transition: all 0.3s;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .account-btn:hover {
            background-color: #004d40;
            color: white;
            transform: translateY(-5px);
        }

        /* Page Sections */
        .page-section { display: none; }
        .page-section.active { display: block; }

        /* Table Styles */
        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table thead {
            background-color: #004d40;
            color: white;
        }

        table th, table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table tbody tr:hover {
            background-color: #f5f5f5;
        }

        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            margin-right: 5px;
        }

        .btn-edit {
            background-color: #2196F3;
            color: white;
        }

        .btn-delete {
            background-color: #f44336;
            color: white;
        }

        .btn-add {
            background-color: #4caf50;
            color: white;
            padding: 12px 20px;
            margin-bottom: 15px;
        }

        .btn:hover {
            opacity: 0.8;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .modal.active { display: block; }

        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 30px;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .modal-header {
            font-size: 20px;
            font-weight: bold;
            color: #004d40;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .modal-footer {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .btn-save {
            background-color: #4caf50;
            color: white;
        }

        .btn-cancel {
            background-color: #999;
            color: white;
        }

        .back-btn {
            background-color: #666;
            color: white;
            padding: 10px 20px;
            margin-bottom: 20px;
            display: inline-block;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .status-active {
            background-color: #4caf50;
            color: white;
        }

        .status-inactive {
            background-color: #ff9800;
            color: white;
        }
        
    </style>
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
            <a href="analytics.html">Analytics</a>
            <a href="accounts.html"class="active">Accounts</a>
        </div>

        <div class="sidebar-footer">
            <div class="profile-section" onclick="window.location.href='profile.html'">
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

    <!-- Main Content -->
    <div class="main-content" id="mainContent">
        <!-- Account Type Selection Page -->
        <div class="page-section active" id="accountTypePage">
            <div class="header">
                <h1>Account Management</h1>
            </div>
            <div class="account-type-section">
                <button class="account-btn" onclick="navigateTo('customersPage')">
                   Manage Customers
                </button>
                <button class="account-btn" onclick="navigateTo('staffPage')">
                   Manage Staff
                </button>
            </div>
        </div>

        <!-- Customers Management Page -->
        <div class="page-section" id="customersPage">
            <button class="back-btn" onclick="navigateTo('accountTypePage')">← Back</button>
            <div class="header">
                <h1>Customer Accounts</h1>
            </div>
            <button class="btn btn-add" onclick="openModal('customerModal')">+ Add New Customer</button>
            
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Customer ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Status</th>
                            <th>Joined Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="customerTable">
                        <tr>
                            <td>#C001</td>
                            <td>johndoe</td>
                            <td>john@example.com</td>
                            <td><span class="status-badge status-active">Active</span></td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="btn btn-edit" onclick="editCustomer(1)">Edit</button>
                                <button class="btn btn-delete" onclick="deleteAccount('customer', 1)">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#C002</td>
                            <td>janesmith</td>
                            <td>jane@example.com</td>
                            <td><span class="status-badge status-active">Active</span></td>
                            <td>2024-02-10</td>
                            <td>
                                <button class="btn btn-edit" onclick="editCustomer(2)">Edit</button>
                                <button class="btn btn-delete" onclick="deleteAccount('customer', 2)">Delete</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Staff Management Page -->
        <div class="page-section" id="staffPage">
            <button class="back-btn" onclick="navigateTo('accountTypePage')">← Back</button>
            <div class="header">
                <h1>Staff Accounts</h1>
            </div>
            <button class="btn btn-add" onclick="openModal('staffModal')">+ Add New Staff</button>
            
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Staff ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Position</th>
                            <th>Status</th>
                            <th>Joined Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="staffTable">
                        <tr>
                            <td>#S001</td>
                            <td>Michael Brown</td>
                            <td>michael@bookstore.com</td>
                            <td>Manager</td>
                            <td><span class="status-badge status-active">Active</span></td>
                            <td>2023-06-01</td>
                            <td>
                                <button class="btn btn-edit" onclick="editStaff(1)">Edit</button>
                                <button class="btn btn-delete" onclick="deleteAccount('staff', 1)">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#S002</td>
                            <td>Sarah Lee</td>
                            <td>sarah@bookstore.com</td>
                            <td>Sales Associate</td>
                            <td><span class="status-badge status-inactive">Inactive</span></td>
                            <td>2023-08-15</td>
                            <td>
                                <button class="btn btn-edit" onclick="editStaff(2)">Edit</button>
                                <button class="btn btn-delete" onclick="deleteAccount('staff', 2)">Delete</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Customer Modal -->
    <div class="modal" id="customerModal">
        <div class="modal-content">
            <div class="modal-header">Add/Edit Customer</div>
            <form id="customerForm">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" id="customerUsername" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" id="customerEmail" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" id="customerPassword" required>
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select id="customerStatus">
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-cancel" onclick="closeModal('customerModal')">Cancel</button>
                    <button type="submit" class="btn btn-save">Save</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Staff Modal -->
    <div class="modal" id="staffModal">
        <div class="modal-content">
            <div class="modal-header">Add/Edit Staff</div>
            <form id="staffForm">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" id="staffUsername" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" id="staffEmail" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" id="staffPassword" required>
                </div>
                <div class="form-group">
                    <label>Position</label>
                    <select id="staffPosition" required>
                        <option value="">Select Position</option>
                        <option value="Manager">Manager</option>
                        <option value="Sales Associate">Sales Associate</option>
                        <option value="Warehouse Staff">Warehouse Staff</option>
                        <option value="Accountant">Accountant</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select id="staffStatus" required>
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-cancel" onclick="closeModal('staffModal')">Cancel</button>
                    <button type="submit" class="btn btn-save">Save</button>
                </div>
            </form>
        </div>
    </div>
    <script>
        function navigateTo(pageId) {
            document.querySelectorAll('.page-section').forEach(section => {
                section.classList.remove('active');
            });
            document.getElementById(pageId).classList.add('active');
        }

        function openModal(modalId) {
            document.getElementById(modalId).classList.add('active');
        }

        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('active');
        }

        function editCustomer(id) {
            openModal('customerModal');
            // Load customer data based on id
        }

        function editStaff(id) {
            openModal('staffModal');
            // Load staff data based on id
        }

        function deleteAccount(type, id) {
            if (confirm(`Are you sure you want to delete this ${type} account?`)) {
                alert(`${type} account ${id} deleted successfully!`);
            }
        }

        document.getElementById('customerForm').addEventListener('submit', (e) => {
            e.preventDefault();
            alert('Customer updated successfully!');
            closeModal('customerModal');
        });

        document.getElementById('staffForm').addEventListener('submit', (e) => {
            e.preventDefault();
            alert('Staff updated successfully!');
            closeModal('staffModal');
        });

        // Close modal when clicking outside
        window.addEventListener('click', (e) => {
            if (e.target.classList.contains('modal')) {
                e.target.classList.remove('active');
            }
        });
    </script>
    <script src="../js/main.js"></script>
</body>
</html>