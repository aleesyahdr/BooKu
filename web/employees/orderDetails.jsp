<%
    // Get the session, but don't create a new one if it doesn't exist
    HttpSession userSession = request.getSession(false);
    String empUsername = "Guest"; // Default value
    
    if (userSession != null && userSession.getAttribute("empUsername") != null) {
        empUsername = (String) userSession.getAttribute("empUsername");
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    Map<String, Object> orderInfo = (Map<String, Object>) request.getAttribute("orderInfo");
    List<Map<String, Object>> orderItems = (List<Map<String, Object>>) request.getAttribute("orderItems");
    
    // DEBUG: Print to console what we received
    if (orderInfo == null) {
        System.out.println("⚠️ WARNING: orderInfo is NULL in orderDetails.jsp");
    } else {
        System.out.println("✓ orderInfo loaded successfully");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Bookstore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleEmp.css">
</head>
<body>
<%
    // Get status info if orderInfo exists
    String currentStatus = orderInfo != null ? (String) orderInfo.get("orderStatus") : "pending";
    String lastUpdatedBy = orderInfo != null ? (String) orderInfo.get("lastUpdatedBy") : null;
%>
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
            <h1>Order Details</h1>
        </div>

        <% if (orderInfo == null) { %>
            <div style="padding: 30px; text-align: center;">
                <h2 style="color: #d32f2f;">⚠️ Order Not Found</h2>
                <p>The order you're looking for could not be loaded.</p>
                <p style="color: #666; font-size: 14px;">This might be due to a database error or the order doesn't exist.</p>
                <button onclick="window.location.href='${pageContext.request.contextPath}/EmpOrderServlet'" 
                        style="margin-top: 20px; padding: 10px 20px; background: #004d40; color: white; border: none; border-radius: 5px; cursor: pointer;">
                    ← Back to Orders
                </button>
            </div>
        <% } else { %>

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
                    <% 
                        String proof = (String) orderInfo.get("paymentProof");
                        if (proof != null && !proof.isEmpty()) { 
                    %>
                        <img src="${pageContext.request.contextPath}/img/<%= orderInfo.get("paymentProof") %>" 
                            alt="Payment Receipt" 
                            style="max-width: 400px; border: 2px solid #004d40;">
                    <% } else { %>
                        <div style="background: #f3f4f6; padding: 40px; border-radius: 8px; text-align: center; border: 2px dashed #d1d5db;">
                            <span style="font-size: 40px;">📄</span>
                            <p style="color: #6b7280; margin-top: 10px;">No receipt uploaded yet.</p>
                        </div>
                    <% } %>
                </div>
            </div>

            <div class="section">
                <h2>Update Order Status</h2>
                <form action="OrderDetailServlet" method="post">
                    <input type="hidden" name="orderId" value="<%= orderInfo.get("orderId") %>">
                    <div class="form-group">
                        <label for="orderStatus">Status Selection:</label>
                        <select id="orderStatus" name="orderStatus">
                            <option value="pending" <%= "pending".equals(currentStatus) ? "selected" : "" %>>Pending</option>
                            <option value="In progress" <%= "In progress".equals(currentStatus) ? "selected" : "" %>>In Progress</option>
                            <option value="completed" <%= "completed".equals(currentStatus) ? "selected" : "" %>>Completed</option>
                        </select>
                    </div>
                    
                    <!-- Display Last Updated By -->
                    <% if (lastUpdatedBy != null) { %>
                    <div style="margin-top: 15px; padding: 10px; background-color: #f0f0f0; border-radius: 5px;">
                        <small style="color: #666;">
                            <strong>Last Updated By:</strong> <%= lastUpdatedBy %>
                        </small>
                    </div>
                    <% } else { %>
                    <div style="margin-top: 15px; padding: 10px; background-color: #fff3cd; border-radius: 5px;">
                        <small style="color: #856404;">
                            <strong>Note:</strong> No employee has updated this order yet
                        </small>
                    </div>
                    <% } %>
                    
                    <button type="submit" class="btn-update" style="margin-top: 15px;">Update</button>
                </form>
            </div>
        </div>
        <% } // End of orderInfo null check %>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
