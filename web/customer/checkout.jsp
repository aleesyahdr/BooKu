<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Cart" %>

<%
    // Check if user is logged in
    Integer custId = (Integer) session.getAttribute("custId");
    String username = (String) session.getAttribute("username");
    
    if (custId == null || username == null) {
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
    
    // Get checkout data with null checks
    List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
    
    // Handle null values properly
    double subtotal = 0.0;
    double shipping = 0.0;
    double tax = 0.0;
    double total = 0.0;
    
    Object subtotalObj = request.getAttribute("subtotal");
    Object shippingObj = request.getAttribute("shipping");
    Object taxObj = request.getAttribute("tax");
    Object totalObj = request.getAttribute("total");
    
    if (subtotalObj != null) subtotal = (Double) subtotalObj;
    if (shippingObj != null) shipping = (Double) shippingObj;
    if (taxObj != null) tax = (Double) taxObj;
    if (totalObj != null) total = (Double) totalObj;
    
    System.out.println("Checkout JSP - Subtotal: " + subtotal + ", Tax: " + tax + ", Shipping: " + shipping + ", Total: " + total);
%>

<!DOCTYPE html>
<html>
<head>
    <title>BooKu - Checkout</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header class="top-header">
        <div class="logo"><h1>BooKu</h1></div>
        <div class="header-right">
            <nav class="header-nav">
                <a href="${pageContext.request.contextPath}/IndexServlet">Home</a>
                <a href="${pageContext.request.contextPath}/BooksServlet">Books</a>
            </nav>
            <div class="profile-menu">
                <img src="${pageContext.request.contextPath}/img/profile.jpg" class="profile-icon" alt="Profile">
                <div class="dropdown">
                    <div class="user-info">Welcome, <%= username %>!</div>
                    <a href="${pageContext.request.contextPath}/ShoppingCartServlet">My Cart</a>
                    <a href="${pageContext.request.contextPath}/CustLoginServlet?action=logout">Logout</a>
                </div>
            </div>
        </div>
    </header>
    
    <div class="checkout-container">
        <h1 class="page-title">Checkout</h1>
        
        <div class="checkout-content">
            <!-- Left Side: Order Summary -->
            <div class="order-summary-section">
                <h2>Order Summary</h2>
                
                <div class="checkout-items">
                    <%
                        if (cartItems != null && !cartItems.isEmpty()) {
                            for (Cart item : cartItems) {
                    %>
                    <div class="checkout-item">
                        <div class="item-details">
                            <h4><%= item.getBookName() %></h4>
                            <p>by <%= item.getBookAuthor() %></p>
                            <p>Quantity: <%= item.getQuantity() %></p>
                        </div>
                        <div class="item-price">
                            RM <%= String.format("%.2f", item.getSubtotal()) %>
                        </div>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
                
                <div class="order-totals">
                    <div class="total-row">
                        <span>Subtotal:</span>
                        <span>RM <%= String.format("%.2f", subtotal) %></span>
                    </div>
                    <div class="total-row">
                        <span>Shipping:</span>
                        <span>RM <%= String.format("%.2f", shipping) %></span>
                    </div>
                    <div class="total-row">
                        <span>Tax (6%):</span>
                        <span>RM <%= String.format("%.2f", tax) %></span>
                    </div>
                    <div class="total-row grand-total">
                        <span><strong>Total:</strong></span>
                        <span><strong>RM <%= String.format("%.2f", total) %></strong></span>
                    </div>
                </div>
            </div>
            
            <!-- Right Side: Payment Button -->
            <div class="payment-section">
                <h2>Ready to Complete Purchase?</h2>
                <p>Total Amount: <strong>RM <%= String.format("%.2f", total) %></strong></p>
                
                <form action="${pageContext.request.contextPath}/PaymentServlet" method="GET">
                    <input type="hidden" name="totalAmount" value="<%= total %>">
                    <button type="submit" class="proceed-payment-btn">Proceed to Payment</button>
                </form>
                
                <button class="back-cart-btn" onclick="location.href='${pageContext.request.contextPath}/ShoppingCartServlet'">
                    Back to Cart
                </button>
            </div>
        </div>
    </div>
</body>
</html>
