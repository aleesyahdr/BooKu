<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer" %>
<%
    Integer custId = (Integer) session.getAttribute("custId");
    String username = (String) session.getAttribute("username");
    
    if (custId == null || username == null) {
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
    
    Customer customer = (Customer) request.getAttribute("customer");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <title>BooKu - My Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <!-- Top Header -->
    <header class="top-header">
        <div class="logo"><h1>BooKu</h1></div>
        <div class="header-right">
            <nav class="header-nav">
                <a href="${pageContext.request.contextPath}/IndexServlet">Home</a>
                <a href="${pageContext.request.contextPath}/BooksServlet">Books</a>
                <a href="${pageContext.request.contextPath}/customer/contact.jsp">Contact</a>
                <a href="${pageContext.request.contextPath}/customer/about.jsp">About</a>
            </nav>
            <div class="profile-menu">
                <img src="${pageContext.request.contextPath}/img/profile.jpg" class="profile-icon" alt="Profile">
                <div class="dropdown">
                    <div class="user-info">Welcome, <%= username %>!</div>
                    <a href="${pageContext.request.contextPath}/ProfileServlet">Profile</a>
                    <a href="${pageContext.request.contextPath}/OrderHistoryServlet">Order History</a>
                    <a href="${pageContext.request.contextPath}/ShoppingCartServlet">My Cart</a>
                    <a href="${pageContext.request.contextPath}/CustLoginServlet?action=logout">Logout</a>
                </div>
            </div>
        </div>
    </header>

    <!-- Profile Content -->
    <div class="profile-container">
        <h1 class="page-title">My Profile</h1>
        
        <!-- Success/Error Messages -->
        <% if (successMessage != null) { %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% } %>
        <% if (errorMessage != null) { %>
            <div class="alert alert-error"><%= errorMessage %></div>
        <% } %>
        
        <div class="profile-content">
            <!-- Left: Profile Picture -->
            <div class="profile-picture-section">
                <img src="${pageContext.request.contextPath}/img/profile.jpg" alt="Profile Picture" class="profile-picture">
<!--                <button class="change-picture-btn">Change Picture</button>-->
                
                <!-- Account Info (Read Only) -->
                <div class="account-info">
                    <p><strong>Username:</strong> <%= username %></p>
                </div>
            </div>
            
            <!-- Right: Profile Form -->
            <div class="profile-form-section">
                <form class="profile-form" action="${pageContext.request.contextPath}/ProfileServlet" method="post">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" name="firstName" value="<%= customer != null && customer.getCust_firstName() != null ? customer.getCust_firstName() : "" %>" required>
                        </div>
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" name="lastName" value="<%= customer != null && customer.getCust_lastName() != null ? customer.getCust_lastName() : "" %>" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" value="<%= customer != null && customer.getCust_email() != null ? customer.getCust_email() : "" %>" required>
                        </div>
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phoneNum" value="<%= customer != null && customer.getCust_phoneNum() != null ? customer.getCust_phoneNum() : "" %>">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Date of Birth</label>
                        <input type="date" name="dob" value="<%= customer != null && customer.getCust_dob() != null ? customer.getCust_dob() : "" %>">
                    </div>
                    
                    <div class="form-group">
                        <label>Address</label>
                        <input type="text" name="address" value="<%= customer != null && customer.getCust_address() != null ? customer.getCust_address() : "" %>">
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>City</label>
                            <input type="text" name="city" value="<%= customer != null && customer.getCust_city() != null ? customer.getCust_city() : "" %>">
                        </div>
                        <div class="form-group">
    <label>State</label>
    <select name="state" required class="form-input">
        <option value="">Select State</option>

        <option value="Johor" <%= (customer != null && "Johor".equals(customer.getCust_state())) ? "selected" : "" %>>Johor</option>
        <option value="Kedah" <%= (customer != null && "Kedah".equals(customer.getCust_state())) ? "selected" : "" %>>Kedah</option>
        <option value="Kelantan" <%= (customer != null && "Kelantan".equals(customer.getCust_state())) ? "selected" : "" %>>Kelantan</option>
        <option value="Melaka" <%= (customer != null && "Melaka".equals(customer.getCust_state())) ? "selected" : "" %>>Melaka</option>
        <option value="Negeri Sembilan" <%= (customer != null && "Negeri Sembilan".equals(customer.getCust_state())) ? "selected" : "" %>>Negeri Sembilan</option>
        <option value="Pahang" <%= (customer != null && "Pahang".equals(customer.getCust_state())) ? "selected" : "" %>>Pahang</option>
        <option value="Penang" <%= (customer != null && "Penang".equals(customer.getCust_state())) ? "selected" : "" %>>Penang</option>
        <option value="Perak" <%= (customer != null && "Perak".equals(customer.getCust_state())) ? "selected" : "" %>>Perak</option>
        <option value="Perlis" <%= (customer != null && "Perlis".equals(customer.getCust_state())) ? "selected" : "" %>>Perlis</option>
        <option value="Sabah" <%= (customer != null && "Sabah".equals(customer.getCust_state())) ? "selected" : "" %>>Sabah</option>
        <option value="Sarawak" <%= (customer != null && "Sarawak".equals(customer.getCust_state())) ? "selected" : "" %>>Sarawak</option>
        <option value="Selangor" <%= (customer != null && "Selangor".equals(customer.getCust_state())) ? "selected" : "" %>>Selangor</option>
        <option value="Terengganu" <%= (customer != null && "Terengganu".equals(customer.getCust_state())) ? "selected" : "" %>>Terengganu</option>
        <option value="Kuala Lumpur" <%= (customer != null && "Kuala Lumpur".equals(customer.getCust_state())) ? "selected" : "" %>>Kuala Lumpur</option>
        <option value="Labuan" <%= (customer != null && "Labuan".equals(customer.getCust_state())) ? "selected" : "" %>>Labuan</option>
        <option value="Putrajaya" <%= (customer != null && "Putrajaya".equals(customer.getCust_state())) ? "selected" : "" %>>Putrajaya</option>

    </select>
</div>

                        <div class="form-group">
                            <label>Postcode</label>
                            <input type="text" name="postcode" value="<%= customer != null && customer.getCust_postcode() != null ? customer.getCust_postcode() : "" %>">
                        </div>
                    </div>
                    
                    <div class="profile-actions">
                        <button type="submit" class="update-btn">Update Profile</button>
                        <button type="button" class="cancel-btn" onclick="location.href='${pageContext.request.contextPath}/IndexServlet'">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>