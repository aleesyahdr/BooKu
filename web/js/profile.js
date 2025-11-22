/* 
 * Profile page JavaScript
 */

// Update Profile Button
document.getElementById('updateBtn').addEventListener('click', function() {
    document.getElementById('success-modal').style.display = 'flex';
});

// Modal OK Button - redirect to dashboard
document.getElementById('modalOkBtn').addEventListener('click', function() {
    window.location.href = 'home.html';
});

// Cancel Button - redirect to dashboard
document.getElementById('cancelBtn').addEventListener('click', function() {
    window.location.href = 'home.html';
});

// Logout Button - show confirmation then redirect to index.html
document.getElementById('logoutBtn').addEventListener('click', function() {
    if (confirm('Are you sure you want to logout?')) {
        window.location.href = 'index.html';  // Same folder
    }

});
// Close modal when clicking outside of it
window.onclick = function(event) {
    const modal = document.getElementById('success-modal');
    if (event.target === modal) {
        modal.style.display = 'none';
    }
}

// Change Picture Buttond
document.getElementById('changePictureBtn').adEventListener('click', function() {
    const fileInput = document.createElement('input');
    fileInput.type = 'file';
    fileInput.accept = 'image/*';
    
    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                document.getElementById('profilePicture').src = event.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
    
    fileInput.click();
});