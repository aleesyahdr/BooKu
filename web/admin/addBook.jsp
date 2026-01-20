<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book – Booku</title>

    <style>
        body {
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #ffffff;
    }

    /* Sidebar same theme */
    .sidebar {
        width: 250px;
        background-color: black;
        color: #ffffff;
        padding: 20px 20px 0 20px;
        position: fixed;
        height: 100vh;
        top: 0;
        left: 0;
        transition: transform 0.3s ease;
        z-index: 1000;
        display: flex;
        flex-direction: column;
        overflow: hidden;
    }

    .sidebar.hidden {
        transform: translateX(-100%);
    }

    .sidebar h2 {
        margin-bottom: 30px;
        color:#4caf50;
    }

    /* Sidebar Navigation */
    .sidebar-nav {
        flex: 1;
        overflow-y: auto;
        margin-bottom: 15px;
    }

    .sidebar-nav::-webkit-scrollbar {
        width: 5px;
    }

    .sidebar-nav::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.3);
        border-radius: 10px;
    }

    .sidebar a {
        color: white;
        text-decoration: none;
        padding: 12px;
        display: block;
        border-radius: 5px;
        margin-bottom: 10px;
        font-weight: bold;
    }

    .sidebar a:hover,
    .sidebar a.active {
        background-color: #004d40;
    }

    /* Sidebar Footer */
    .sidebar-footer {
        padding: 15px 0 15px 0;
        border-top: 1px solid rgba(255, 255, 255, 0.2);
    }

    .profile-section {
        display: flex;
        align-items: center;
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .profile-section:hover {
        background-color: rgba(0, 0, 0, 0.3);
    }

    .profile-icon {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        background-color: #ffffff;
        color: #004d40;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        font-weight: bold;
        margin-right: 12px;
    }

    .profile-info {
        flex: 1;
    }

    .profile-name {
        font-size: 14px;
        font-weight: bold;
    }

    .logout-btn {
        background-color: #d32f2f;
        color: white;
        border: none;
        padding: 10px;
        width: 100%;
        border-radius: 5px;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        margin-bottom: 20px;
    }

    .logout-btn:hover {
        background-color: #b71c1c;
    }

    /* Main Content */
    .main-content {
        margin-left: 290px;
        padding: 30px 40px;
        flex: 1;
        transition: margin-left 0.3s ease;
    }

    .main-content.expanded {
        margin-left: 80px;
    }

    /* Toggle Button */
    .toggle-btn {
        position: fixed;
        top: 20px;
        left: 270px;
        background-color: black;
        color: white;
        border: none;
        padding: 10px 15px;
        font-size: 22px;
        cursor: pointer;
        border-radius: 5px;
        z-index: 2001;
        transition: left 0.3s ease;
    }

    .toggle-btn.shifted {
        left: 20px;
    }

    /* Page Header */
    .header {
        background: white;
        padding: 20px 30px;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        margin-bottom: 25px;
    }

    .header h1 {
        color: #004d40;
        margin: 0;
        font-size: 28px;
    }

        /* Add Book Container */
        .add-book-container {
            display: flex;
            gap: 30px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .image-upload-section {
            flex: 0 0 300px;
        }

        .image-preview-container {
            width: 100%;
            height: 400px;
            border: 2px dashed #004d40;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f5f5f5;
            position: relative;
            overflow: hidden;
        }

        .image-preview {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }

        .image-preview.show {
            display: block;
        }

        .upload-placeholder {
            text-align: center;
            color: #004d40;
        }

        .upload-placeholder i {
            font-size: 48px;
            margin-bottom: 10px;
        }

        .upload-btn {
            background-color: #004d40;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
            width: 100%;
            font-size: 16px;
        }

        .upload-btn:hover {
            background-color: #00352d;
        }

        .file-input {
            display: none;
        }

        .book-form-section {
            flex: 1;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #004d40;
        }

        .form-group input[type="text"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #999;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #004d40;
        }

        .btn-add {
            background-color: #004d40;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
            margin-top: 30px;
            transition: 0.2s;
        }

        .btn-add:hover {
            background-color: #00352d;
        }

        /* Message Box */
        .message-box {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            z-index: 3000;
            text-align: center;
        }

        .message-box.show {
            display: block;
        }

        .message-box h2 {
            color: #004d40;
            margin-bottom: 15px;
        }

        .message-box p {
            color: #555;
            margin-bottom: 20px;
        }

        .message-box button {
            background-color: #004d40;
            color: white;
            border: none;
            padding: 10px 30px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .message-box button:hover {
            background-color: #00352d;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 2500;
        }

        .overlay.show {
            display: block;
        }
    </style>
</head>
<body>

    <!-- Toggle Button -->
<button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>Booku</h2>

        <div class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/home.jsp">Dashboard</a>
            <a href="${pageContext.request.contextPath}/manageUserServlet">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/books.jsp" class="active">Manage Book</a>
            <a href="${pageContext.request.contextPath}/admin/orders.jsp">Manage Order</a>
            <a href="${pageContext.request.contextPath}/admin/analytics.jsp">Analytics</a>
        </div>

        <div class="sidebar-footer">
            <div class="profile-section" onclick="window.location.href='${pageContext.request.contextPath}/admin/profile.jsp'">
                <div class="profile-icon">👤</div>
                <div class="profile-info">
                    <div class="profile-name">Admin User</div>
                </div>
            </div>

            <button class="logout-btn" id="logoutBtn">
                <span>Logout</span>
            </button>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content" id="mainContent">

        <div class="header">
            <h1>Add New Book</h1>
        </div>

        <div class="add-book-container">
            <div class="image-upload-section">
                <div class="image-preview-container" id="imagePreviewContainer">
                    <img src="" alt="Book Cover Preview" class="image-preview" id="imagePreview">
                    <div class="upload-placeholder" id="uploadPlaceholder">
                        <div style="font-size: 48px;">📚</div>
                        <p>Upload Book Cover</p>
                    </div>
                </div>
                <input type="file" class="file-input" id="fileInput" accept="image/*">
                <button type="button" class="upload-btn" onclick="document.getElementById('fileInput').click()">Choose Image</button>
            </div>

            <div class="book-form-section">
                <form id="addBookForm">
                    <div class="form-group">
                        <label for="bookName">Book Name</label>
                        <input type="text" id="bookName" placeholder="Enter book name" required>
                    </div>

                    <div class="form-group">
                        <label for="bookDescription">Description</label>
                        <textarea id="bookDescription" placeholder="Enter book description" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="bookPrice">Price (RM)</label>
                        <input type="text" id="bookPrice" placeholder="Enter price" required>
                    </div>

                    <div class="form-group">
                        <label for="bookAvailability">Availability</label>
                        <select id="bookAvailability" required>
                            <option value="">Select availability</option>
                            <option value="in-stock">In Stock</option>
                            <option value="out-of-stock">Out of Stock</option>
                            <option value="pre-order">Pre-Order</option>
                        </select>
                    </div>

                    <button type="button" class="btn-add" id="addBtn">Add Book</button>
                </form>
            </div>
        </div>

    </div>

    <!-- Overlay -->
    <div class="overlay" id="overlay"></div>

    <!-- Message Box -->
    <div class="message-box" id="messageBox">
        <h2>Success!</h2>
        <p>Book added successfully!</p>
        <button onclick="window.location.href='books.html'">OK</button>
    </div>

    <!-- External JS -->
    <script src="../js/main.js"></script>
    <script src="../js/addBook.js"></script>

</body>
</html>