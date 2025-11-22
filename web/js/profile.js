function updateProfile() {
    // Show the success modal
    document.getElementById('success-modal').style.display = 'flex';
}

function closeModal() {
    // Hide the modal
    document.getElementById('success-modal').style.display = 'none';
}

function cancelUpdate() {
    // Reload the page to reset form values
    location.reload();
}

// Close modal when clicking outside of it
window.onclick = function(event) {
    const modal = document.getElementById('success-modal');
    if (event.target === modal) {
        modal.style.display = 'none';
    }
}

