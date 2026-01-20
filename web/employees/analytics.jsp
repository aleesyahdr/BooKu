<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    Integer totalOrders = (Integer) request.getAttribute("totalOrders");
    Integer booksSold = (Integer) request.getAttribute("booksSold");
    Double avgOrderValue = (Double) request.getAttribute("avgOrderValue");
    List<Map<String, Object>> topBooks = (List<Map<String, Object>>) request.getAttribute("topBooks");
    Map<Integer, Double> monthlySales = (Map<Integer, Double>) request.getAttribute("monthlySales");
    
    // Default values if null
    if (totalRevenue == null) totalRevenue = 0.0;
    if (totalOrders == null) totalOrders = 0;
    if (booksSold == null) booksSold = 0;
    if (avgOrderValue == null) avgOrderValue = 0.0;
%>
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
                    <div class="value">RM <%= String.format("%.2f", totalRevenue) %></div>
                    <div class="change">↑ From orders</div>
                </div>

                <div class="stat-card">
                    <h3>Total Orders</h3>
                    <div class="value"><%= totalOrders %></div>
                    <div class="change">↑ All time</div>
                </div>

                <div class="stat-card">
                    <h3>Books Sold</h3>
                    <div class="value"><%= booksSold %></div>
                    <div class="change">↑ Total units</div>
                </div>

                <div class="stat-card">
                    <h3>Avg Order Value</h3>
                    <div class="value">RM <%= String.format("%.2f", avgOrderValue) %></div>
                    <div class="change">↑ Per order</div>
                </div>
            </div>

            <div class="bottom-section">
                <div class="chart-container">
                    <h2>Monthly Sales</h2>
                    <div class="chart">
                        <%
                            String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
                            double maxSales = 1.0;
                            
                            // Find max sales for scaling
                            if (monthlySales != null && !monthlySales.isEmpty()) {
                                for (Double value : monthlySales.values()) {
                                    if (value > maxSales) maxSales = value;
                                }
                            }
                            
                            for (int i = 1; i <= 12; i++) {
                                Double sales = (monthlySales != null) ? monthlySales.get(i) : null;
                                double percentage = 0;
                                if (sales != null && sales > 0 && maxSales > 0) {
                                    percentage = (sales / maxSales) * 90; // Max 90% height
                                }
                                if (percentage < 10 && sales != null && sales > 0) percentage = 10; // Minimum visible height
                        %>
                        <div class="bar-container">
                            <div class="bar" style="height: <%= percentage %>%;"></div>
                            <div class="bar-label"><%= months[i-1] %></div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>

                <div class="table-container">
                    <h2>Top Selling Books</h2>
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
                                <%
                                    if (topBooks != null && !topBooks.isEmpty()) {
                                        for (Map<String, Object> book : topBooks) {
                                %>
                                <tr>
                                    <td><%= book.get("rank") %></td>
                                    <td><%= book.get("bookName") %></td>
                                    <td><%= book.get("author") %></td>
                                    <td><%= book.get("unitsSold") %></td>
                                    <td>RM <%= String.format("%.2f", book.get("revenue")) %></td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="5" style="text-align: center;">No sales data available</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>