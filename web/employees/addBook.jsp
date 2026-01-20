<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book – Booku</title>
    <link rel="stylesheet" href="../css/styleEmp.css">
</head>
<body>

    <!-- Toggle Button -->
    <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>Booku</h2>

        <div class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/employees/home.jsp">Dashboard</a>
            <a href="${pageContext.request.contextPath}/employees/EmpBookServlet" class="active">Manage Book</a>
            <a href="${pageContext.request.contextPath}/employees/orders.jsp">Manage Order</a>
            <a href="${pageContext.request.contextPath}/employees/analytics.jsp">Analytics</a>
        </div>

        <div class="sidebar-footer">
            <div class="profile-section" onclick="window.location.href='${pageContext.request.contextPath}/employees/profile.jsp'">
                <div class="profile-icon">👤</div>
                <div class="profile-info">
                    <div class="profile-name">Employee User</div>
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
            <p style="color: #666; margin: 10px 0 0 0;">Fill in the details to add a new book to the catalog</p>
        </div>

        <!-- Form with Two Column Layout -->
        <form id="addBookForm" action="${pageContext.request.contextPath}/employees/EmpAddBookServlet" method="post" enctype="multipart/form-data">
            <div class="add-book-container">
                
                <!-- LEFT SIDE: Book Cover Preview -->
                <div class="image-upload-section">
                    <div class="image-preview-container" id="imagePreviewContainer">
                        <img src="" alt="Book Cover Preview" class="image-preview" id="imagePreview">
                        <div class="upload-placeholder" id="uploadPlaceholder">
                            <div style="font-size: 48px;">📚</div>
                            <p>Book Cover Preview</p>
                            <p style="font-size: 12px; color: #777;">Upload an image to preview</p>
                        </div>
                    </div>
                    
                    <input type="file" class="file-input" id="fileInput" name="bookImage" accept="image/*" required>
                    <button type="button" class="upload-btn" onclick="document.getElementById('fileInput').click()">
                        Choose Image
                    </button>

                    <div class="upload-info">
                        <p>Image Guidelines:</p>
                        <ul>
                            <li>Max size: 15MB</li>
                            <li>Format: JPG, PNG, GIF</li>
                            <li>Recommended: 300x400px</li>
                        </ul>
                    </div>
                </div>

                <!-- RIGHT SIDE: Form Fields -->
                <div class="book-form-section">
                    <div class="form-group">
                        <label for="bookName">Book Name <span class="required">*</span></label>
                        <input type="text" id="bookName" name="bookName" placeholder="Enter book name" required>
                    </div>

                    <div class="form-group">
                        <label for="bookAuthor">Author <span class="required">*</span></label>
                        <input type="text" id="bookAuthor" name="bookAuthor" placeholder="Enter author name" required>
                    </div>

                    <div class="form-group">
                        <label for="bookDescription">Description <span class="required">*</span></label>
                        <textarea id="bookDescription" name="bookDescription" placeholder="Enter book description" required></textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="bookPrice">Price (RM) <span class="required">*</span></label>
                            <input type="number" id="bookPrice" name="bookPrice" placeholder="0.00" step="0.01" min="0" required>
                        </div>

                        <div class="form-group">
                            <label for="bookPublishDate">Publish Date <span class="required">*</span></label>
                            <input type="date" id="bookPublishDate" name="bookPublishDate" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="bookCategory">Category <span class="required">*</span></label>
                        <select id="bookCategory" name="bookCategory" required>
                            <option value="">Select category</option>
                            <option value="Fiction">Fiction</option>
                            <option value="Non-Fiction">Non-Fiction</option>
                            <option value="Science">Science</option>
                            <option value="Technology">Technology</option>
                            <option value="History">History</option>
                            <option value="Biography">Biography</option>
                            <option value="Self-Help">Self-Help</option>
                            <option value="Business">Business</option>
                            <option value="Children">Children</option>
                            <option value="Romance">Romance</option>
                            <option value="Mystery">Mystery</option>
                            <option value="Fantasy">Fantasy</option>
                            <option value="Horror">Horror</option>
                            <option value="Science Fiction">Science Fiction</option>
                            <option value="Classic">Classic</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="availability">Availability <span class="required">*</span></label>
                        <select id="availability" name="availability" required>
                            <option value="1">Available</option>
                            <option value="0">Not Available</option>
                        </select>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn-add" id="addBtn">Add Book</button>
                        <button type="button" class="btn-reset" onclick="resetForm()">Reset Form</button>
                        <button type="button" class="btn-cancel" onclick="window.location.href='${pageContext.request.contextPath}/EmpBookServlet'">Cancel</button>
                    </div>
                </div>
            </div>
        </form>

    </div>

    <!-- Overlay -->
    <div class="overlay" id="overlay"></div>

    <!-- Message Box -->
    <div class="message-box" id="messageBox">
        <h2 id="messageTitle">Success!</h2>
        <p id="messageText">Book added successfully!</p>
        <button onclick="closeMessage()">OK</button>
    </div>

    <!-- External JavaScript Files -->
    <script src="${pageContext.request.contextPath}/js/manageBook.js"></script>
    <script src="${pageContext.request.contextPath}/js/addBook.js"></script>

    <script>
        function toggleSidebar() {
            var sidebar = document.getElementById('sidebar');
            var mainContent = document.getElementById('mainContent');
            var toggleBtn = document.getElementById('toggleBtn');
            
            sidebar.classList.toggle('hidden');
            mainContent.classList.toggle('expanded');
            toggleBtn.classList.toggle('shifted');
        }

        function resetForm() {
            document.getElementById('addBookForm').reset();
            
            // Reset image preview
            var imagePreview = document.getElementById('imagePreview');
            var uploadPlaceholder = document.getElementById('uploadPlaceholder');
            var fileInput = document.getElementById('fileInput');
            
            if (imagePreview && uploadPlaceholder) {
                imagePreview.classList.remove('show');
                imagePreview.src = '';
                uploadPlaceholder.style.display = 'block';
            }
            
            if (fileInput) {
                fileInput.value = '';
            }
        }

        function getContextPath() {
            return '${pageContext.request.contextPath}';
        }

        function closeMessage() {
            const messageBox = document.getElementById('messageBox');
            const overlay = document.getElementById('overlay');
            
            if (messageBox && overlay) {
                messageBox.classList.remove('show');
                overlay.classList.remove('show');
                
                // Redirect to books page on success
                if (messageBox.classList.contains('success')) {
                    window.location.href = '${pageContext.request.contextPath}/employees/EmpBookServlet';
                }
            }
        }
    </script>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #ffffff;
        }

        /* Sidebar */
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

        /* Add Book Container - TWO COLUMN LAYOUT */
        .add-book-container {
            display: flex;
            gap: 30px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        /* LEFT SIDE - Image Upload Section */
        .image-upload-section {
            flex: 0 0 300px;
            display: flex;
            flex-direction: column;
            gap: 15px;
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
            font-size: 16px;
            font-weight: bold;
            transition: 0.2s;
        }

        .upload-btn:hover {
            background-color: #00352d;
        }

        .file-input {
            display: none;
        }

        .upload-info {
            background: #f5f5f5;
            padding: 15px;
            border-radius: 8px;
        }

        .upload-info p {
            margin: 0 0 10px 0;
            color: #004d40;
            font-weight: bold;
            font-size: 14px;
        }

        .upload-info ul {
            margin: 0;
            padding-left: 20px;
            color: #666;
            font-size: 13px;
        }

        .upload-info li {
            margin: 5px 0;
        }

        /* RIGHT SIDE - Form Section */
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
        .form-group input[type="number"],
        .form-group input[type="date"],
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
            font-family: Arial, sans-serif;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #004d40;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
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
            flex: 1;
            transition: 0.2s;
        }

        .btn-add:hover {
            background-color: #00352d;
        }

        .btn-add:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .btn-reset {
            background-color: #ff9800;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            flex: 1;
            transition: 0.2s;
        }

        .btn-reset:hover {
            background-color: #f57c00;
        }

        .btn-cancel {
            background-color: #999;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            flex: 1;
            transition: 0.2s;
        }

        .btn-cancel:hover {
            background-color: #777;
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
            min-width: 300px;
        }

        .message-box.show {
            display: block;
        }

        .message-box.success h2 {
            color: #4caf50;
        }

        .message-box.error h2 {
            color: #d32f2f;
        }

        .message-box h2 {
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

        .required {
            color: #d32f2f;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .add-book-container {
                flex-direction: column;
            }

            .image-upload-section {
                flex: 0 0 auto;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</body>
</html>