<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Order" %>
<%
    Integer custId = (Integer) session.getAttribute("custId");
    String username = (String) session.getAttribute("username");
    
    if (custId == null || username == null) {
        session.setAttribute("redirectAfterLogin", request.getRequestURI());
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>BooKu - Order History</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>        
        
        /* Order Items */
.order-items {
    padding: 15px 20px;
    border-top: 1px solid #eee;
    border-bottom: 1px solid #eee;
}

.order-item {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 10px 0;
    border-bottom: 1px solid #f0f0f0;
}

.order-item:last-child {
    border-bottom: none;
}

.order-item-img {
    width: 60px;
    height: 80px;
    object-fit: cover;
    border-radius: 5px;
}

.order-item-details h4 {
    margin: 0 0 5px 0;
    font-size: 14px;
    color: #333;
}

.order-item-details .item-price {
    color: #004d40;
    font-weight: 600;
    margin: 3px 0;
    font-size: 13px;
}

.order-item-details .item-qty {
    color: #666;
    font-size: 12px;
    margin: 3px 0;
}

.order-status.pending {
    background-color: #fff3cd;
    color: #856404;
}

.order-status.processing {
    background-color: #cce5ff;
    color: #004085;
}

.order-status.shipped {
    background-color: #d1ecf1;
    color: #0c5460;
}

.order-status.completed {
    background-color: #d4edda;
    color: #155724;
}

.order-status.cancelled {
    background-color: #f8d7da;
    color: #721c24;
}
</style>
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
    
    <!-- Order History Container -->
    <div class="order-history-container">
        <h1 class="page-title">Order History</h1>
        
        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            Map<Integer, List<Map<String, Object>>> orderItemsMap = 
                (Map<Integer, List<Map<String, Object>>>) request.getAttribute("orderItemsMap");
            
            if (orders != null && !orders.isEmpty()) {
                for (Order order : orders) {
                    List<Map<String, Object>> items = orderItemsMap.get(order.getOrder_id());
        %>
        <!-- Order Card -->
        <div class="order-card">
            <div class="order-header">
                <div class="order-info">
                    <span class="order-id">Order #<%= order.getOrder_id() %></span>
                    <span class="order-date">Placed on: <%= order.getOrder_date() %></span>
                </div>
                <div class="order-status <%= order.getOrder_status().toLowerCase() %>"><%= order.getOrder_status() %></div>
            </div>
            
            <!-- Order Items - Books with Images -->
            <div class="order-items">
                <% if (items != null && !items.isEmpty()) { 
                    for (Map<String, Object> item : items) { %>
                <div class="order-item">
                    <a href="${pageContext.request.contextPath}/BookDetailsServlet?book_id=<%= item.get("bookId") %>">
                        <img src="${pageContext.request.contextPath}/img/<%= item.get("bookImg") %>" 
                             alt="<%= item.get("bookName") %>" class="order-item-img">
                    </a>
                    <div class="order-item-details">
                        <h4><%= item.get("bookName") %></h4>
                        <p class="item-price">RM <%= String.format("%.2f", item.get("bookPrice")) %></p>
                        <p class="item-qty">Qty: <%= item.get("quantity") %></p>
                    </div>
                </div>
                <%  } 
                   } else { %>
                <p>No items found</p>
                <% } %>
            </div>
            
            <div class="order-footer">
                <div class="order-total">
                    <span>Total:</span>
                    <span class="total-amount">RM <%= String.format("%.2f", order.getOrder_total()) %></span>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="empty-orders">
            <h2>No Orders Yet</h2>
            <p>You haven't placed any orders yet.</p>
            <button class="continue-shopping" onclick="location.href='${pageContext.request.contextPath}/BooksServlet'">Start Shopping</button>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>