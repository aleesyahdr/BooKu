<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%-- 
    Document   : paymentSuccess
    Created on : Jan 20, 2026, 2:07:07 AM
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>BooKu - Payment</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="payment-container">
        <h2>Payment</h2>
        
        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>
        
        <div class="payment-summary">
            <h3>Order Summary</h3>
            <div class="summary-item">
                <span>Total Amount:</span>
                <span>RM ${totalAmount}</span>
            </div>
        </div>
        
        <form method="POST" action="PaymentServlet" class="payment-form">
            <div class="form-group">
                <label>Amount (RM)</label>
                <input type="number" name="amount" step="0.01" value="${totalAmount}" readonly>
            </div>
            
            <div class="form-group">
                <label>Payment Method</label>
                <select name="payment_method" required>
                    <option value="">-- Select Payment Method --</option>
                    <option value="credit_card">Credit Card</option>
                    <option value="debit_card">Debit Card</option>
                    <option value="online_banking">Online Banking</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Card Number</label>
                <input type="text" name="card_number" placeholder="1234 5678 9012 3456" required>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Expiry Date</label>
                    <input type="text" name="expiry" placeholder="MM/YY" required>
                </div>
                
                <div class="form-group">
                    <label>CVV</label>
                    <input type="text" name="cvv" placeholder="123" required>
                </div>
            </div>
            
            <button type="submit" class="submit-btn">Pay Now</button>
            <button type="button" class="cancel-btn" onclick="window.location.href='cart.jsp'">Back to Cart</button>
        </form>
    </div>
</body>
</html>


