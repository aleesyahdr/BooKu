<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>BooKu - Register</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <style>
            .error-message {
                color: #d32f2f;
                background-color: #ffebee;
                padding: 12px;
                border-radius: 5px;
                margin-bottom: 15px;
                border-left: 4px solid #d32f2f;
                font-size: 14px;
            }
        </style>
    </head>
    
    <body>
        <!-- Register Container -->
        <div class="register-container">
            <div class="register-box">
                <h1 class="register-title">Create Your BooKu Account</h1>
                <p class="register-subtitle">Join us and start your reading journey today!</p>

                <!-- Display error message if any -->
                <c:if test="${not empty errorMessage}">
                    <p class="error-message">${errorMessage}</p>
                </c:if>

                <form action="${pageContext.request.contextPath}/RegisterServlet" method="POST">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">First Name</label>
                            <input type="text" name="firstname" required class="form-input" placeholder="Enter your first name">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Last Name</label>
                            <input type="text" name="lastname" required class="form-input" placeholder="Enter your last name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" required class="form-input" placeholder="Choose a username">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" required class="form-input" placeholder="Enter your email">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" id="password" required class="form-input" placeholder="Create a password" minlength="6">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Confirm Password</label>
                        <input type="password" id="confirm-password" required class="form-input" placeholder="Confirm your password" minlength="6">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" name="phone" required class="form-input" placeholder="+60123456789">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Address</label>
                        <textarea name="address" rows="3" required class="form-input" placeholder="Enter your address"></textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">City</label>
                            <input type="text" name="city" required class="form-input" placeholder="City">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Postcode</label>
                            <input type="text" name="postcode" required class="form-input" placeholder="Postcode">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">State</label>
                        <select name="state" required class="form-input">
                            <option value="">Select State</option>
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
                            <option value="Selangor">Selangor</option>
                            <option value="Terengganu">Terengganu</option>
                            <option value="Kuala Lumpur">Kuala Lumpur</option>
                            <option value="Labuan">Labuan</option>
                            <option value="Putrajaya">Putrajaya</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Date of Birth</label>
                        <input type="date" name="birthday" required class="form-input">
                    </div>

                    <button type="submit" class="register-btn">Create Account</button>

                    <div class="login-link">
                        <p>Already have an account? <a href="login.jsp">Login here</a></p>
                    </div>
                </form>
            </div>
        </div>

        <script>
            // Client-side password validation
            document.querySelector('form').addEventListener('submit', function(e) {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirm-password').value;
                
                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('Passwords do not match!');
                    return false;
                }
                
                if (password.length < 6) {
                    e.preventDefault();
                    alert('Password must be at least 6 characters long!');
                    return false;
                }
            });
        </script>
    </body>
</html>
