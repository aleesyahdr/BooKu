<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html>
<html>
    <head>
        <title>BooKu - Cart</title>
        <link rel="stylesheet" href="../css/style.css">
    </head>
    
    <body>
       <!-- Top Header -->
        <header class="top-header">
        <div class="logo"><h1>BooKu</h1></div>

        <div class="header-right">
            <nav class="header-nav">
                <a href="../index.html">Home</a>
                <a href="books.html">Books</a>
                <a href="contact.html">Contact</a>
                <a href="about.html">About</a>
            </nav>

            <div class="profile-menu">
                <img src="../img/profile.jpg" class="profile-icon" alt="Profile">
                <div class="dropdown">
                    <a href="profile.html">Profile</a>
                    <a href="orderHistory.html">Order History</a>
                    <a href="login.html">Login</a>
                </div>
            </div>
        </div>
    </header>

        <!-- Cart Container -->
        <div class="cart-container">
            <h1 class="page-title">Shopping Cart</h1>
            
            <div class="cart-content">
                
                <!-- Cart Items Section -->
                <div class="cart-items">
                    
                    <!-- Item 1 -->
                    <div class="cart-item">
                        <img src="../img/book1.jpg" alt="Book 1" class="item-image">
                        <div class="item-details">
                            <h3>Book 1</h3>
                            <p class="item-author">by Author 1</p>
                            <p class="item-price">RM XX.XX</p>
                        </div>
                        <div class="item-actions">
                            <div class="quantity-control">
                                <button class="qty-btn" onclick="updateQuantity(1, -1)">-</button>
                                <span class="qty-display" id="qty-1">1</span>
                                <button class="qty-btn" onclick="updateQuantity(1, 1)">+</button>
                            </div>
                            <button class="remove-btn" onclick="removeItem(1)">Remove</button>
                        </div>
                    </div>
                    
                    <!-- Item 2 -->
                    <div class="cart-item">
                        <img src="../img/book2.jpg" alt="Book 2" class="item-image">
                        <div class="item-details">
                            <h3>Book 2</h3>
                            <p class="item-author">by Author 2</p>
                            <p class="item-price">RM XX.XX</p>
                        </div>
                        <div class="item-actions">
                            <div class="quantity-control">
                                <button class="qty-btn" onclick="updateQuantity(2, -1)">-</button>
                                <span class="qty-display" id="qty-1">2</span>
                                <button class="qty-btn" onclick="updateQuantity(2, 1)">+</button>
                            </div>
                            <button class="remove-btn" onclick="removeItem(2)">Remove</button>
                        </div>
                    </div>  
                </div>  
                
                <!-- Cart Summary Section -->
                <div class="cart-summary">
                    <h2 class="summary-title">Order Summary</h2>
                
                    <div class="summary-row">
                        <span>Subtotal (3 items):</span>
                        <span id="subtotal">RM 119.70</span>
                    </div>

                    <div class="summary-row">
                        <span>Shipping:</span>
                        <span id="shipping">RM 10.00</span>
                    </div>

                    <div class="summary-row">
                        <span>Tax (6%):</span>
                        <span id="tax">RM 7.18</span>
                    </div>

                    <div class="summary-row total">
                        <span>Total:</span>
                        <span id="total">RM 136.88</span>
                    </div>

                    <button class="checkout-btn" onclick="location.href='checkout.html'">Proceed to Checkout</button>
                    <button class="continue-shopping" onclick="location.href='books.html'">Continue Shopping</button>
                </div>
            </div>
        </div>
    </body>
</html>

