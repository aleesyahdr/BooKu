<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Check if user is logged in
    Integer custId = (Integer) session.getAttribute("custId");
    if (custId == null) {
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
    
    Double totalAmount = (Double) request.getAttribute("totalAmount");
    if (totalAmount == null) {
        totalAmount = 0.0;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>BooKu - Payment</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .payment-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .payment-container h2 {
            color: #004d40;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #c62828;
        }
        
        .payment-summary {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .payment-summary h3 {
            color: #004d40;
            margin-bottom: 15px;
        }
        
        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            font-size: 18px;
            font-weight: bold;
            border-top: 2px solid #004d40;
            margin-top: 10px;
        }
        
        .qr-section {
            text-align: center;
            padding: 30px;
            background: #f9f9f9;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .qr-section h3 {
            color: #004d40;
            margin-bottom: 15px;
        }
        
        .qr-code {
            width: 250px;
            height: 250px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border: 2px solid #004d40;
            border-radius: 10px;
        }
        
        .qr-code img {
            width: 100%;
            height: 100%;
        }
        
        .bank-details {
            text-align: left;
            max-width: 400px;
            margin: 20px auto;
            padding: 15px;
            background: white;
            border-radius: 5px;
        }
        
        .bank-details p {
            margin: 8px 0;
            color: #333;
        }
        
        .payment-form {
            margin-top: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }
        
        .form-group input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 2px dashed #004d40;
            border-radius: 5px;
            background: #f9f9f9;
        }
        
        .upload-note {
            font-size: 14px;
            color: #666;
            margin-top: 5px;
        }
        
        .submit-btn, .cancel-btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin: 5px;
        }
        
        .submit-btn {
            background: #004d40;
            color: white;
        }
        
        .submit-btn:hover {
            background: #00352d;
        }
        
        .cancel-btn {
            background: #e0e0e0;
            color: #333;
        }
        
        .cancel-btn:hover {
            background: #d0d0d0;
        }
        
        .button-group {
            text-align: center;
            margin-top: 30px;
        }
    </style>
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
                <span>RM <%= String.format("%.2f", totalAmount) %></span>
            </div>
        </div>
        
        <!-- QR Code Section -->
        <div class="qr-section">
            <h3>Scan QR Code to Pay</h3>
            <div class="qr-code">
                <!-- Replace with your actual QR code image -->
                <img src="${pageContext.request.contextPath}/img/payment-qr.jpeg" 
                     alt="Payment QR Code"
                     onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22250%22 height=%22250%22%3E%3Crect fill=%22%23f0f0f0%22 width=%22250%22 height=%22250%22/%3E%3Ctext x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22 fill=%22%23999%22 font-size=%2216%22%3EQR Code%3C/text%3E%3C/svg%3E';">
            </div>
            
            <div class="bank-details">
                <p><strong>Bank:</strong> Maybank</p>
                <p><strong>Account Name:</strong> BooKu Bookstore</p>
                <p><strong>Account Number:</strong> 1234567890</p>
                <p><strong>Amount:</strong> RM <%= String.format("%.2f", totalAmount) %></p>
            </div>
            
            <p style="color: #d32f2f; font-weight: bold; margin-top: 15px;">
                Please upload your payment receipt below after making the payment
            </p>
        </div>
        
        <!-- Upload Proof of Payment Form -->
        <form method="POST" action="${pageContext.request.contextPath}/PaymentServlet" 
              enctype="multipart/form-data" class="payment-form">
            
            <input type="hidden" name="amount" value="<%= totalAmount %>">
            
            <div class="form-group">
                <label for="proofOfPayment">Upload Proof of Payment *</label>
                <input type="file" 
                       id="proofOfPayment" 
                       name="proofOfPayment" 
                       accept="image/*,.pdf" 
                       required>
                <p class="upload-note">Accepted formats: JPG, PNG, PDF (Max 5MB)</p>
            </div>
            
            <div class="form-group">
                <label for="paymentNote">Additional Notes (Optional)</label>
                <textarea id="paymentNote" 
                          name="paymentNote" 
                          rows="3" 
                          style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;"
                          placeholder="Reference number, transaction ID, etc."></textarea>
            </div>
            
            <div class="button-group">
                <button type="submit" class="submit-btn">Submit Payment</button>
                <button type="button" class="cancel-btn" 
                        onclick="window.location.href='${pageContext.request.contextPath}/ShoppingCartServlet'">
                    Cancel
                </button>
            </div>
        </form>
    </div>
</body>
</html>
