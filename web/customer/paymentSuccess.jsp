<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer orderId = (Integer) request.getAttribute("orderId");
    Double totalAmount = (Double) request.getAttribute("totalAmount");
    
    if (orderId == null) orderId = 0;
    if (totalAmount == null) totalAmount = 0.0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>BooKu - Payment Success</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .success-container {
            text-align: center;
            padding: 50px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }
        
        .success-box {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            max-width: 500px;
        }
        
        .success-icon {
            font-size: 60px;
            color: #4caf50;
            margin-bottom: 20px;
        }
        
        .success-box h1 {
            color: #004d40;
            margin-bottom: 10px;
        }
        
        .success-box p {
            color: #666;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        .success-btn {
            background-color: #004d40;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            margin: 5px;
        }
        
        .success-btn:hover {
            background-color: #00352d;
        }
        
        .order-details {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            text-align: left;
        }
        
        .order-details p {
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-box">
            <div class="success-icon">✓</div>
            <h1>Payment Successful!</h1>
            <p>Thank you for your purchase. Your order has been confirmed.</p>
            
            <div class="order-details">
                <p><strong>Order Confirmation:</strong></p>
                <p>Order ID: #<%= orderId %></p>
                <p>Date: <%= new java.util.Date() %></p>
                <p>Total Amount: RM <%= String.format("%.2f", totalAmount) %></p>
            </div>
           
            
            <a href="${pageContext.request.contextPath}/IndexServlet" class="success-btn">Back to Home</a>
            <a href="${pageContext.request.contextPath}/OrderHistoryServlet" class="success-btn">View Order History</a>
        </div>
    </div>
</body>
</html>
