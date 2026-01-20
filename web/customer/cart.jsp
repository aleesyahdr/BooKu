<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    // Check if user is logged in
    Integer custId = (Integer) session.getAttribute("custId");
    String username = (String) session.getAttribute("username");
    
    if (custId == null || username == null) {
        // User is not logged in, redirect to login page
        // Store current page URL for redirect after login
        session.setAttribute("redirectAfterLogin", request.getRequestURI());
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return; // Stop processing the page
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>BooKu - Cart</title>
       <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    
    <body>
       <!-- Top Header -->
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
                        <c:choose>
                            <c:when test="${not empty sessionScope.username}">
                                <div class="user-info">Welcome, ${sessionScope.username}!</div>
                                <a href="${pageContext.request.contextPath}/ProfileServlet">Profile</a>
                                <a href="${pageContext.request.contextPath}/OrderHistoryServlet">Order History</a>
                                <a href="${pageContext.request.contextPath}/ShoppingCartServlet">My Cart</a>
                                <a href="${pageContext.request.contextPath}/CustLoginServlet?action=logout">Logout</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/customer/login.jsp">Login</a>
                                <a href="${pageContext.request.contextPath}/customer/register.jsp">Register</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </header>
<!-- Cart Container -->
        <div class="cart-container">
            <h1 class="page-title">Shopping Cart</h1>
            
            <c:choose>
                <c:when test="${empty cartItems}">
                    <div class="empty-cart">
                        <h2>Your cart is empty</h2>
                        <p>Add some books to get started!</p>
                        <button class="continue-shopping" onclick="location.href='${pageContext.request.contextPath}/BooksServlet'">Browse Books</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="cart-content">
                        
                        <!-- Cart Items Section -->
                        <div class="cart-items">
                            <c:set var="subtotal" value="0" />
                            <c:set var="itemCount" value="0" />
                            
                            <c:forEach var="item" items="${cartItems}">
                                <c:set var="subtotal" value="${subtotal + item.subtotal}" />
                                <c:set var="itemCount" value="${itemCount + item.quantity}" />
                                
                                <div class="cart-item">
                                    <img src="${pageContext.request.contextPath}/img/book${item.bookId}.jpg" alt="${item.bookName}" class="item-image" 
                                         onerror="this.src='${pageContext.request.contextPath}/img/default-book.jpg'">
                                    <div class="item-details">
                                        <h3>${item.bookName}</h3>
                                        <p class="item-author">by ${item.bookAuthor}</p>
                                        <p class="item-price">RM <fmt:formatNumber value="${item.bookPrice}" pattern="#,##0.00"/></p>
                                    </div>
                                    <div class="item-actions">
                                        <div class="quantity-control">
                                            <button class="qty-btn" onclick="updateQuantity(${item.bookId}, ${item.quantity - 1})">-</button>
                                            <span class="qty-display" id="qty-${item.bookId}">${item.quantity}</span>
                                            <button class="qty-btn" onclick="updateQuantity(${item.bookId}, ${item.quantity + 1})">+</button>
                                        </div>
                                        <button class="remove-btn" onclick="removeItem(${item.bookId})">Remove</button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>  
                        
                        <!-- Cart Summary Section -->
                        <div class="cart-summary">
                            <h2 class="summary-title">Order Summary</h2>
                        
                            <c:set var="shipping" value="10.00" />
                            <c:set var="taxRate" value="0.06" />
                            <c:set var="tax" value="${subtotal * taxRate}" />
                            <c:set var="total" value="${subtotal + shipping + tax}" />
                            
                            <div class="summary-row">
                                <span>Subtotal (${itemCount} items):</span>
                                <span id="subtotal">RM <fmt:formatNumber value="${subtotal}" pattern="#,##0.00"/></span>
                            </div>

                            <div class="summary-row">
                                <span>Shipping:</span>
                                <span id="shipping">RM <fmt:formatNumber value="${shipping}" pattern="#,##0.00"/></span>
                            </div>

                            <div class="summary-row">
                                <span>Tax (6%):</span>
                                <span id="tax">RM <fmt:formatNumber value="${tax}" pattern="#,##0.00"/></span>
                            </div>

                            <div class="summary-row total">
                                <span>Total:</span>
                                <span id="total">RM <fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
                            </div>

                            <button class="checkout-btn" onclick="location.href='${pageContext.request.contextPath}/CheckoutServlet'">Proceed to Checkout</button>
                            <button class="continue-shopping" onclick="location.href='${pageContext.request.contextPath}/BooksServlet'">Continue Shopping</button>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <script src="${pageContext.request.contextPath}/js/cart.js"></script>
    </body>
</html>





