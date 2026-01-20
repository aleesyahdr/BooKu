<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Analytics - Bookstore</title>
    <style>
        body { margin: 0; font-family: 'Segoe UI', Arial, sans-serif; background-color: #f8f9fa; }
        .sidebar { width: 250px; background-color: #000; color: #fff; padding: 20px; position: fixed; height: 100vh; transition: 0.3s; z-index: 1000; }
        .sidebar.hidden { transform: translateX(-100%); }
        .sidebar h2 { color: #4caf50; margin-bottom: 30px; }
        .sidebar a { color: white; text-decoration: none; padding: 12px; display: block; border-radius: 5px; margin-bottom: 5px; }
        .sidebar a:hover, .sidebar a.active { background-color: #004d40; }
        
        .main-content { margin-left: 290px; padding: 30px; transition: 0.3s; }
        .main-content.expanded { margin-left: 50px; }
        
        .header { background: #fff; padding: 20px; border-radius: 8px; margin-bottom: 25px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .btn-print { background: #004d40; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; font-weight: bold; }
        
        .analytics-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); border-left: 4px solid #4caf50; }
        .stat-card h3 { color: #888; font-size: 12px; text-transform: uppercase; margin: 0 0 10px 0; }
        .stat-card .value { color: #333; font-size: 24px; font-weight: bold; }

        .bottom-section { display: grid; grid-template-columns: 1fr 1.5fr; gap: 20px; }
        .card-box { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { text-align: left; padding: 12px; border-bottom: 2px solid #eee; color: #004d40; }
        td { padding: 12px; border-bottom: 1px solid #eee; font-size: 14px; }
        
        .toggle-btn { position: fixed; top: 20px; left: 270px; background: #000; color: #fff; border: none; padding: 10px 15px; cursor: pointer; z-index: 2001; border-radius: 4px; transition: 0.3s; }
        .toggle-btn.shifted { left: 20px; }
    </style>
</head>
<body>

    <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>

    <div class="sidebar" id="sidebar">
        <h2>Booku</h2>
        <a href="${pageContext.request.contextPath}/admin/home.jsp">Dashboard</a>
        <a href="${pageContext.request.contextPath}/manageUserServlet">Manage Users</a>
        <a href="${pageContext.request.contextPath}/AdminBookServlet">Manage Book</a>
        <a href="${pageContext.request.contextPath}/admin/orders.jsp">Manage Order</a>
        <a href="${pageContext.request.contextPath}/AdminAnalyticsServlet" class="active">Analytics</a>
    </div>

    <div class="main-content" id="mainContent">
        <div class="header">
            <h1>Analytics Overview</h1>
            <button class="btn-print" onclick="window.print()">Print Report</button>
        </div>

        <div class="analytics-grid">
            <div class="stat-card">
                <h3>Total Revenue</h3>
                <div class="value">RM <fmt:formatNumber value="${stats.totalRevenue}" pattern="#,##0.00"/></div>
            </div>
            <div class="stat-card">
                <h3>Total Orders</h3>
                <div class="value">${stats.totalOrders}</div>
            </div>
            <div class="stat-card">
                <h3>Books Sold</h3>
                <div class="value">${stats.booksSold}</div>
            </div>
            <div class="stat-card">
                <h3>Avg Order Value</h3>
                <div class="value">RM <fmt:formatNumber value="${stats.avgOrder}" pattern="#,##0.00"/></div>
            </div>
        </div>

        <div class="bottom-section">
            <div class="card-box">
                <h2>Monthly Target</h2>
                <p>Visual representation of sales volume.</p>
                <div style="height: 200px; display: flex; align-items: flex-end; justify-content: space-around; border-bottom: 2px solid #eee;">
                    <div style="width: 30px; height: 70%; background: #4caf50; border-radius: 4px 4px 0 0;"></div>
                    <div style="width: 30px; height: 40%; background: #004d40; border-radius: 4px 4px 0 0;"></div>
                    <div style="width: 30px; height: 90%; background: #4caf50; border-radius: 4px 4px 0 0;"></div>
                </div>
            </div>

            <div class="card-box">
                <h2>Top Selling Books</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>Book</th>
                            <th>Author</th>
                            <th>Sold</th>
                            <th>Revenue</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="book" items="${topBooks}" varStatus="status">
                            <tr>
                                <td>#${status.index + 1}</td>
                                <td><strong>${book.name}</strong></td>
                                <td>${book.author}</td>
                                <td>${book.sold}</td>
                                <td>RM <fmt:formatNumber value="${book.revenue}" pattern="#,##0.00"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty topBooks}">
                            <tr><td colspan="5" style="text-align:center;">No sales recorded yet.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
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
    </script>
</body>
</html>