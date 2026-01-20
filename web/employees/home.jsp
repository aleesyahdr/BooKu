<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Check if employee is logged in manually (backup for the filter)
    String empUsername = (String) session.getAttribute("empUsername");
    if (empUsername == null) {
        response.sendRedirect("index.jsp"); // Go back to login if no session
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Bookstore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleEmp.css">
</head>
<body>
    
    <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>

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
            <h1>Dashboard Overview</h1>
            <p>Welcome back, staff member!</p>
        </div>

        <div class="stats-box">
            <div class="card">
                <h2>Total Sales</h2>
                <p>RM <fmt:formatNumber value="${totalSales}" minFractionDigits="2" /></p>
            </div>

            <div class="card">
                <h2>Total Books</h2>
                <p>${totalBooks}</p>
            </div>

            <div class="card">
                <h2>New Orders</h2>
                <p>${newOrders}</p>
            </div>

            <div class="card">
                <h2>Uncompleted Orders</h2>
                <p>${newOrders}</p> </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>