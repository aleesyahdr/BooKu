<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    // Get orderList from request (set by servlet)
    List<Map<String, Object>> orderList = (List<Map<String, Object>>) request.getAttribute("orderList");
    
    // Get the session, but don't create a new one if it doesn't exist
    HttpSession userSession = request.getSession(false);
    String empUsername = "Guest"; // Default value
    
    if (userSession != null && userSession.getAttribute("empUsername") != null) {
        empUsername = (String) userSession.getAttribute("empUsername");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Bookstore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleEmp.css">
</head>
<body>
<button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>

    <!-- Sidebar -->
     <div class="sidebar" id="sidebar">
        <h2>Booku</h2>

        <div class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/EmpHomeServlet" class="active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/ManageBookServlet">Manage Book</a>
            <a href="${pageContext.request.contextPath}/EmpOrderServlet">Manage Order</a>
            <a href="${pageContext.request.contextPath}/AnalyticsServlet">Analytics</a>
        </div>

        <div class="sidebar-footer">
            <div class="profile-section" onclick="window.location.href='${pageContext.request.contextPath}/EmpProfileServlet'">
                <div class="profile-icon">👤</div>
                <div class="profile-info">
                    <div class="profile-name">
                        <%= session.getAttribute("empFirstName") != null ? session.getAttribute("empFirstName") : "Employee" %>
                    </div>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/EmpLoginServlet?action=logout" class="logout-btn" style="text-decoration: none; text-align: center; display: block;">
                <span>Logout</span>
            </a>
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

        <!-- Error Message from Servlet -->
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div style="padding: 15px; margin-bottom: 20px; border-radius: 8px; 
                        background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;">
                <%= errorMessage %>
            </div>
        <%
            }
        %>

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
                    <%
                        if (orderList != null && !orderList.isEmpty()) {
                            for (Map<String, Object> order : orderList) {
                    %>
                    <tr>
                        <td>#ORD<%= String.format("%03d", order.get("orderId")) %></td>
                        <td><%= order.get("customerName") %></td>
                        <td><%= order.get("bookTitle") %></td>
                        <td>RM <%= String.format("%.2f", order.get("orderTotal")) %></td>
                        <td><span class="status-badge status-pending"><%= order.get("status") %></span></td>
                        <td>
                            <button class="btn btn-view" onclick="window.location.href='${pageContext.request.contextPath}/OrderDetailServlet?id=<%= order.get("orderId") %>'">View</button>
                            <button class="btn btn-delete" onclick="deleteOrder(<%= order.get("orderId") %>)">Delete</button>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" style="text-align: center; padding: 20px;">No orders found.</td>
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

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
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
