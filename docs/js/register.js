function registerAccount() {
    // Show the success modal
    document.getElementById('success-modal').style.display = 'flex';
}

function redirectToLogin() {
    // Redirect to login page
    window.location.href = 'login.html';
}

// Close modal when clicking outside of it
window.onclick = function(event) {
    const modal = document.getElementById('success-modal');
    if (event.target === modal) {
        modal.style.display = 'none';
    }
}


