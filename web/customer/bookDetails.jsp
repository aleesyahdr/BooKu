<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html>
<html>
<head>
    <title>BooKu - Book Details</title>
    <link rel="stylesheet" href="../css/style.css">
</head>

<body>

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

    <a href="books.html" class="back-btn">Back to Books</a>
    <div class="details-container">
        <!-- LEFT — book image -->
        <img src="../img/book1.jpg" alt="Book">

        <!-- RIGHT — book info -->
        <div class="details-info">
            <h1>Book Title 1</h1>
            <p class="price">RM29.90</p>

            <!-- New Info -->
            <p class="author"><strong>Author:</strong> John Doe</p>
            <p class="category"><strong>Category:</strong> Fiction</p>

            <p class="description">
                This is a sample description of the book.  
                You can write about the storyline, genre, summary, or author information.  
                Make it short and simple for now.
            </p>

            <div class="quantity-box">
                <label>Quantity: </label>
                <input type="number" value="1" min="1">
            </div>

            <button class="cart-btn" onclick="window.location.href='cart.html'">Add to Cart</button>
        </div>


    </div>

</body>
</html>


