<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    Map<String, Object> orderInfo = (Map<String, Object>) request.getAttribute("orderInfo");
    List<Map<String, Object>> orderItems = (List<Map<String, Object>>) request.getAttribute("orderItems");
    if (orderInfo == null) {
        response.sendRedirect("EmpOrderServlet");
        return;
    }
%>
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
            <h1>Order Details</h1>
        </div>

        <div class="details-container">
            <div class="section">
                <h2>Order Summary</h2>
                <div class="info-row">
                    <div class="info-label">Order ID:</div>
                    <div class="info-value">#ORD<%= String.format("%03d", orderInfo.get("orderId")) %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Customer Name:</div>
                    <div class="info-value"><%= orderInfo.get("customerName") %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Email:</div>
                    <div class="info-value"><%= orderInfo.get("customerEmail") != null ? orderInfo.get("customerEmail") : "N/A" %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Phone:</div>
                    <div class="info-value"><%= orderInfo.get("customerPhone") != null ? orderInfo.get("customerPhone") : "N/A" %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Address:</div>
                    <div class="info-value"><%= orderInfo.get("customerAddress") %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Order Date:</div>
                    <div class="info-value"><%= orderInfo.get("orderDate") %> at <%= orderInfo.get("orderTime") %></div>
                </div>
            </div>

            <div class="section">
                <h2>Book Details</h2>
                <%
                    if (orderItems != null && !orderItems.isEmpty()) {
                        for (Map<String, Object> item : orderItems) {
                %>
                <div style="margin-bottom: 20px; padding-bottom: 20px; border-bottom: 1px solid #e5e7eb;">
                    <div class="info-row">
                        <div class="info-label">Book Name:</div>
                        <div class="info-value"><%= item.get("bookName") %></div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Author:</div>
                        <div class="info-value"><%= item.get("bookAuthor") %></div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Description:</div>
                        <div class="info-value"><%= item.get("bookDescription") %></div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Price:</div>
                        <div class="info-value">RM <%= String.format("%.2f", item.get("bookPrice")) %></div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Quantity:</div>
                        <div class="info-value"><%= item.get("quantity") %></div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Subtotal:</div>
                        <div class="info-value" style="font-weight: bold;">RM <%= String.format("%.2f", item.get("subtotal")) %></div>
                    </div>
                </div>
                <%
                        }
                    }
                %>
                <div class="info-row">
                    <div class="info-label" style="font-size: 1.2em; font-weight: bold;">Total Price:</div>
                    <div class="info-value" style="font-weight: bold; color: #004d40; font-size: 1.2em;">
                        RM <%= String.format("%.2f", orderInfo.get("orderTotal")) %>
                    </div>
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
                <form action="OrderDetailServlet" method="post">
                    <input type="hidden" name="orderId" value="<%= orderInfo.get("orderId") %>">
                    <div class="form-group">
                        <label for="orderStatus">Status Selection:</label>
                        <select id="orderStatus" name="orderStatus">
                            <option value="pending">Pending</option>
                            <option value="progress">In Progress</option>
                            <option value="completed">Completed</option>
                        </select>
                    </div>
                    <button type="submit" class="btn-update">Update</button>
                </form>
            </div>
        </div>
    </div>

    <div id="updateModal" class="modal">
        <div class="modal-content">
            <h3>Updated Successfully</h3>
            <button onclick="window.location.href='EmpOrderServlet'">OK</button>
        </div>
    </div>

    <script src="../js/main.js"></script>
</body>
</html>