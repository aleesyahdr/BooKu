<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile – Booku</title>
<link rel="stylesheet" href="../css/styleEmp.css">

</head>
<body>

    <!-- Toggle Button -->
    <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</button>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>Booku</h2>
        
        <div class="sidebar-nav">
            <a href="home.html">Dashboard</a>
            <a href="books.html">Manage Book</a>
            <a href="orders.html">Manage Order</a>
            <a href="analytics.html">Analytics</a>
        </div>
        
        <div class="sidebar-footer">
            <div class="profile-section" onclick="window.location.href='profile.html'">
                <div class="profile-icon-sidebar">👤</div>
                <div class="profile-info">
                    <div class="profile-name">User</div>
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
            <h1>My Profile</h1>
        </div>

        <div class="profile-container">
            <!-- Profile Picture Section -->
            <div class="profile-picture-section">
                <img src="../img/profile.jpg" alt="Profile Picture" class="profile-picture" id="profilePicture">
                <button class="change-picture-btn" id="changePictureBtn">Change Picture</button>
            </div>

            <!-- Profile Form -->
            <div class="profile-form-section">
                <form id="profile-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">First Name</label>
                            <input type="text" id="firstname" value="Ahmad" class="form-input">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Last Name</label>
                            <input type="text" id="lastname" value="Bin Abu" class="form-input">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Username</label>
                        <input type="text" id="username" value="ahmad.abu" class="form-input">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" id="password" value="12345@abcd" class="form-input">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" id="email" value="ahmad.abu@example.com" class="form-input">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" id="phone" value="+60123456789" class="form-input">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Date of Birth</label>
                        <input type="date" id="dob" value="1995-06-15" class="form-input">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Address</label>
                        <textarea id="address" rows="3" class="form-input">No. 123, Jalan Makmur, Taman Sejahtera, 47000 Petaling Jaya, Selangor</textarea>
                    </div>

                    <div class="form-group">
                        <label class="form-label">City</label>
                        <input type="text" id="city" value="Petaling Jaya" class="form-input">
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">State</label>
                            <select id="state" class="form-input">
                                <option value="Johor">Johor</option>
                                <option value="Kedah">Kedah</option>
                                <option value="Kelantan">Kelantan</option>
                                <option value="Melaka">Melaka</option>
                                <option value="Negeri Sembilan">Negeri Sembilan</option>
                                <option value="Pahang">Pahang</option>
                                <option value="Penang">Penang</option>
                                <option value="Perak">Perak</option>
                                <option value="Perlis">Perlis</option>
                                <option value="Sabah">Sabah</option>
                                <option value="Sarawak">Sarawak</option>
                                <option value="Selangor" selected>Selangor</option>
                                <option value="Terengganu">Terengganu</option>
                                <option value="Kuala Lumpur">Kuala Lumpur</option>
                                <option value="Labuan">Labuan</option>
                                <option value="Putrajaya">Putrajaya</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Postcode</label>
                            <input type="text" id="postcode" value="47000" class="form-input">
                        </div>
                    </div>

                    <div class="profile-actions">
                        <button type="button" class="update-btn" id="updateBtn">Update Profile</button>
                        <button type="button" class="cancel-btn" id="cancelBtn">Cancel</button>
                    </div>
                </form>
            </div>
        </div>

    </div>

    <!-- Success Modal -->
    <div id="success-modal" class="modal">
        <div class="modal-content">
            <div class="modal-icon success-icon">✓</div>
            <h2 class="modal-title">Success!</h2>
            <p class="modal-message">Profile updated successfully!</p>
            <button class="modal-btn" id="modalOkBtn">OK</button>
        </div>
    </div>

    <!-- External JS -->
    <script src="../js/main.js"></script>
    <script src="../js/profile.js"></script>

</body>
</html>