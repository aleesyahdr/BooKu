<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
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
            <a href="EmpBookServlet">Manage Book</a>
            <a href="EmpOrderServlet" class="active">Manage Order</a>
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

        <!-- Success/Error Message -->
        <% 
            String message = (String) session.getAttribute("message");
            String messageType = (String) session.getAttribute("messageType");
            if (message != null) {
        %>
            <div style="padding: 15px; margin-bottom: 20px; border-radius: 8px; 
                        background-color: <%= messageType.equals("success") ? "#d4edda" : "#f8d7da" %>; 
                        color: <%= messageType.equals("success") ? "#155724" : "#721c24" %>; 
                        border: 1px solid <%= messageType.equals("success") ? "#c3e6cb" : "#f5c6cb" %>;">
                <%= message %>
            </div>
        <%
                session.removeAttribute("message");
                session.removeAttribute("messageType");
            }
        %>

        <div class="orders-container">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer Name</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Total Books</th>
                        <th>Total Price</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Map<String, Object>> orderList = (List<Map<String, Object>>) request.getAttribute("orderList");
                        if (orderList != null && !orderList.isEmpty()) {
                            for (Map<String, Object> order : orderList) {
                    %>
                    <tr>
                        <td>#ORD<%= String.format("%03d", order.get("orderId")) %></td>
                        <td><%= order.get("customerName") %></td>
                        <td><%= order.get("orderDate") %></td>
                        <td><%= order.get("orderTime") %></td>
                        <td><%= order.get("totalBooks") %></td>
                        <td>RM <%= String.format("%.2f", order.get("orderTotal")) %></td>
                        <td><span class="status-badge status-pending"><%= order.get("status") %></span></td>
                        <td>
                            <button class="btn btn-view" onclick="window.location.href='OrderDetailServlet?id=<%= order.get("orderId") %>'">View</button>
                            <button class="btn btn-delete" onclick="deleteOrder(<%= order.get("orderId") %>)">Delete</button>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="8" style="text-align: center; padding: 20px;">No orders found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h3>Deleted Successfully</h3>
            <button onclick="closeModal()">OK</button>
        </div>
    </div>

    <form id="deleteForm" action="EmpOrderServlet" method="post" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="orderId" id="deleteOrderId">
    </form>

    <script src="../js/main.js"></script>
    <script>
        function deleteOrder(orderId) {
            if (confirm('Are you sure you want to delete this order? This action cannot be undone.')) {
                document.getElementById('deleteOrderId').value = orderId;
                document.getElementById('deleteForm').submit();
            }
        }

        function closeModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }
    </script>
</body>
</html>