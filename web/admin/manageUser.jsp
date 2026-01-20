<%-- 
    Document   : manageUser
    Created on : Jan 20, 2026, 1:10:30 PM
    Author     : USER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.Employee, model.Customer"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BooKu - Manage Users</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleAdmin.css">
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>BooKu Admin</h2>
        
        <div class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/home.jsp">Dashboard</a>
            <a href="${pageContext.request.contextPath}/manageUserServlet"class="active">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/books.jsp">Manage Book</a>
            <a href="${pageContext.request.contextPath}/admin/orders.jsp">Manage Order</a>
            <a href="${pageContext.request.contextPath}/admin/analytics.jsp">Analytics</a>
        </div>
        
        <div class="sidebar-footer">
            <div class="profile-section">
                <div class="profile-icon">A</div>
                <div class="profile-info">
                    <div class="profile-name">Admin</div>
                </div>
            </div>
            <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/admin/logout.jsp'">
                <span>🚪</span> Logout
            </button>
        </div>
    </div>
    
    <!-- Toggle Button -->
    <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>
    
    <!-- Main Content -->
    <div class="main-content" id="mainContent">
        <div class="header">
            <h1>User Management System</h1>
            <p>Manage Employees and Customers</p>
        </div>
        
        <% 
            String message = (String) request.getAttribute("message");
            String error = (String) request.getAttribute("error");
            
            List<Employee> employees = (List<Employee>) request.getAttribute("employees");
            List<Customer> customers = (List<Customer>) request.getAttribute("customers");
            
            if (employees == null) employees = new ArrayList<Employee>();
            if (customers == null) customers = new ArrayList<Customer>();
        %>
        
        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>
        
        <div class="tabs">
            <button class="tab active" onclick="openTab(event, 'employees')">Employees</button>
            <button class="tab" onclick="openTab(event, 'customers')">Customers</button>
        </div>
        
        <!-- Employees Tab -->
        <div id="employees" class="tab-content active">
            <div class="action-buttons">
                <button class="btn btn-primary" onclick="openAddModal('employee')">
                    + Add Employee
                </button>
            </div>
            
            <div class="search-box">
                <input type="text" id="empSearch" placeholder="Search employees..." 
                       onkeyup="searchTable('empTable', 'empSearch')">
            </div>
            
            <table id="empTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>City</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Employee emp : employees) { %>
                    <tr>
                        <td><%= emp.getEmp_id() %></td>
                        <td><%= emp.getEmp_username() %></td>
                        <td><%= emp.getEmp_firstName() + " " + emp.getEmp_lastName() %></td>
                        <td><%= emp.getEmp_email() %></td>
                        <td><%= emp.getEmp_phoneNum() %></td>
                        <td><%= emp.getEmp_city() %></td>
                        <td>
                            <button class="btn btn-warning btn-sm" 
                                    onclick='editEmployee(<%= emp.getEmp_id() %>, "<%= emp.getEmp_username() %>", "<%= emp.getEmp_password() %>", "<%= emp.getEmp_firstName() %>", "<%= emp.getEmp_lastName() %>", "<%= emp.getEmp_phoneNum() %>", "<%= emp.getEmp_email() %>", "<%= emp.getEmp_address() %>", "<%= emp.getEmp_city() %>", "<%= emp.getEmp_state() %>", "<%= emp.getEmp_postcode() %>", "<%= emp.getEmp_dob() %>")'>
                                Edit
                            </button>
                            <button class="btn btn-danger btn-sm" 
                                    onclick="deleteUser('employee', <%= emp.getEmp_id() %>)">
                                Delete
                            </button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <!-- Customers Tab -->
        <div id="customers" class="tab-content">
            <div class="action-buttons">
                <button class="btn btn-primary" onclick="openAddModal('customer')">
                    + Add Customer
                </button>
            </div>
            
            <div class="search-box">
                <input type="text" id="custSearch" placeholder="Search customers..." 
                       onkeyup="searchTable('custTable', 'custSearch')">
            </div>
            
            <table id="custTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>City</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Customer cust : customers) { %>
                    <tr>
                        <td><%= cust.getCust_id() %></td>
                        <td><%= cust.getCust_username() %></td>
                        <td><%= cust.getCust_firstName() + " " + cust.getCust_lastName() %></td>
                        <td><%= cust.getCust_email() %></td>
                        <td><%= cust.getCust_phoneNum() %></td>
                        <td><%= cust.getCust_city() %></td>
                        <td>
                            <button class="btn btn-warning btn-sm" 
                                    onclick='editCustomer(<%= cust.getCust_id() %>, "<%= cust.getCust_username() %>", "<%= cust.getCust_password() %>", "<%= cust.getCust_firstName() %>", "<%= cust.getCust_lastName() %>", "<%= cust.getCust_phoneNum() %>", "<%= cust.getCust_email() %>", "<%= cust.getCust_dob() %>", "<%= cust.getCust_address() %>", "<%= cust.getCust_city() %>", "<%= cust.getCust_state() %>", "<%= cust.getCust_postcode() %>")'>
                                Edit
                            </button>
                            <button class="btn btn-danger btn-sm" 
                                    onclick="deleteUser('customer', <%= cust.getCust_id() %>)">
                                Delete
                            </button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Modal for Add/Edit -->
    <div id="userModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle">Add User</h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <div class="modal-body">
                <form id="userForm" method="post" action="manageUserServlet">
                    <input type="hidden" name="action" id="formAction" value="add">
                    <input type="hidden" name="userType" id="userType" value="">
                    <input type="hidden" name="userId" id="userId" value="">
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Username *</label>
                            <input type="text" name="username" id="username" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Password *</label>
                            <input type="password" name="password" id="password" required>
                        </div>
                        
                        <div class="form-group">
                            <label>First Name *</label>
                            <input type="text" name="firstName" id="firstName" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Last Name *</label>
                            <input type="text" name="lastName" id="lastName" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Email *</label>
                            <input type="email" name="email" id="email" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Phone Number *</label>
                            <input type="tel" name="phoneNum" id="phoneNum" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Date of Birth *</label>
                            <input type="date" name="dob" id="dob" required>
                        </div>
                        
                        <div class="form-group">
                            <label>City *</label>
                            <input type="text" name="city" id="city" required>
                        </div>
                        
                        <div class="form-group">
                            <label>State *</label>
                            <input type="text" name="state" id="state" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Postcode *</label>
                            <input type="text" name="postcode" id="postcode" required>
                        </div>
                        
                        <div class="form-group full-width">
                            <label>Address *</label>
                            <input type="text" name="address" id="address" required>
                        </div>
                        
                        <div class="form-group full-width" style="margin-top: 20px;">
                            <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/manageUser.js"></script>
</body>
</html>