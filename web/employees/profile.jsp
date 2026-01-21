<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Employee" %>
<%
    // Get the employee object. If null, create a blank one so the page doesn't crash.
    Employee emp = (Employee) request.getAttribute("employee");
    if (emp == null) {
        emp = new Employee();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Profile – Booku</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleEmp.css">
    <style>
        .msg { padding: 10px; margin-bottom: 20px; border-radius: 4px; text-align: center; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>

    <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

    <div class="sidebar" id="sidebar">
        <h2>Booku</h2>
        <div class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/EmpHomeServlet">Dashboard</a>
            <a href="${pageContext.request.contextPath}/ManageBookServlet">Manage Book</a>
            <a href="${pageContext.request.contextPath}/EmpOrderServlet">Manage Order</a>
            <a href="${pageContext.request.contextPath}/AnalyticsServlet">Analytics</a>
        </div>
        <div class="sidebar-footer">
            <div class="profile-section" onclick="window.location.href='${pageContext.request.contextPath}/EmpProfileServlet'">
                <div class="profile-icon-sidebar">👤</div>
                <div class="profile-info">
                    <div class="profile-name">
                        <%-- Using session for the sidebar name --%>
                        <%= session.getAttribute("empFirstName") != null ? session.getAttribute("empFirstName") : emp.getEmp_firstName() %>
                    </div>
                </div>
            </div>
            <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/LogoutServlet'">Logout</button>
        </div>
    </div>

    <div class="main-content" id="mainContent">
        <div class="header"><h1>My Profile</h1></div>

        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="msg success"><%= request.getAttribute("successMessage") %></div>
        <% } %>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="msg error"><%= request.getAttribute("errorMessage") %></div>
        <% } %>

        <div class="profile-container">
            <div class="profile-picture-section">
                <img src="${pageContext.request.contextPath}/img/profile.jpg" alt="Profile" class="profile-picture">
             
            </div>

            <div class="profile-form-section">
                <form action="${pageContext.request.contextPath}/EmpProfileServlet" method="POST">
                    <div class="form-row">
                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" name="firstName" value="<%= emp.getEmp_firstName() %>" class="form-input">
                        </div>
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" name="lastName" value="<%= emp.getEmp_lastName() %>" class="form-input">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" value="<%= emp.getEmp_email() %>" class="form-input">
                    </div>

                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="phoneNum" value="<%= emp.getEmp_phoneNum() %>" class="form-input">
                    </div>

                    <div class="form-group">
                        <label>Date of Birth</label>
                        <input type="date" name="dob" value="<%= emp.getEmp_dob() != null ? emp.getEmp_dob() : "" %>" class="form-input">
                    </div>

                    <div class="form-group">
                        <label>Address</label>
                        <textarea name="address" rows="3" class="form-input"><%= emp.getEmp_address() %></textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>City</label>
                            <input type="text" name="city" value="<%= emp.getEmp_city() %>" class="form-input">
                        </div>
                        <div class="form-group">
                            <label>State</label>
                            <select name="state" class="form-input">
                                <% String currentS = emp.getEmp_state(); %>
                                <option value="Selangor" <%= "Selangor".equals(currentS) ? "selected" : "" %>>Selangor</option>
                                <option value="Johor" <%= "Johor".equals(currentS) ? "selected" : "" %>>Johor</option>
                                <option value="Kuala Lumpur" <%= "Kuala Lumpur".equals(currentS) ? "selected" : "" %>>Kuala Lumpur</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Postcode</label>
                            <input type="text" name="postcode" value="<%= emp.getEmp_postcode() %>" class="form-input">
                        </div>
                    </div>

                    <div class="profile-actions">
                        <button type="submit" class="update-btn">Update Profile</button>
                        <button type="button" class="cancel-btn" onclick="window.history.back()">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('mainContent').classList.toggle('active');
        }
    </script>
</body>
</html>