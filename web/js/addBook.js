/**
 * addBook.js - JavaScript for Add Book page
 * Handles image preview, form validation, and submission
 */

document.addEventListener('DOMContentLoaded', function() {
    // Setup image preview
    setupImagePreview();
    
    // Setup form validation
    setupFormValidation();
    
    // Check for status messages in URL
    checkStatusMessage();
});

/**
 * Setup image preview functionality
 */
function setupImagePreview() {
    const fileInput = document.getElementById('fileInput');
    const imagePreview = document.getElementById('imagePreview');
    const uploadPlaceholder = document.getElementById('uploadPlaceholder');
    
    if (fileInput) {
        fileInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            
            if (file) {
                // Validate file type
                if (!file.type.startsWith('image/')) {
                    alert('Please select a valid image file');
                    fileInput.value = '';
                    return;
                }
                
                // Validate file size (max 15MB)
                const maxSize = 15 * 1024 * 1024; // 15MB in bytes
                if (file.size > maxSize) {
                    alert('Image size must be less than 15MB');
                    fileInput.value = '';
                    return;
                }
                
                // Preview the image
                const reader = new FileReader();
                reader.onload = function(e) {
                    if (imagePreview && uploadPlaceholder) {
                        imagePreview.src = e.target.result;
                        imagePreview.classList.add('show');
                        uploadPlaceholder.style.display = 'none';
                    }
                };
                reader.readAsDataURL(file);
            }
        });
    }
}

/**
 * Setup form validation
 */
function setupFormValidation() {
    const form = document.getElementById('addBookForm');
    
    if (form) {
        form.addEventListener('submit', function(e) {
            if (!validateForm()) {
                e.preventDefault();
            }
        });
        
        // Real-time validation for price
        const priceInput = document.getElementById('bookPrice');
        if (priceInput) {
            priceInput.addEventListener('input', function() {
                validatePrice(this);
            });
        }
        
        // Real-time validation for date
        const dateInput = document.getElementById('bookPublishDate');
        if (dateInput) {
            dateInput.addEventListener('change', function() {
                validateDate(this);
            });
        }
    }
}

/**
 * Validate the entire form
 */
function validateForm() {
    let isValid = true;
    const errors = [];
    
    // Validate book name
    const bookName = document.getElementById('bookName');
    if (!bookName.value.trim()) {
        errors.push('Book name is required');
        isValid = false;
        bookName.classList.add('error');
    } else {
        bookName.classList.remove('error');
    }
    
    // Validate author
    const bookAuthor = document.getElementById('bookAuthor');
    if (!bookAuthor.value.trim()) {
        errors.push('Author name is required');
        isValid = false;
        bookAuthor.classList.add('error');
    } else {
        bookAuthor.classList.remove('error');
    }
    
    // Validate description
    const bookDescription = document.getElementById('bookDescription');
    if (!bookDescription.value.trim()) {
        errors.push('Description is required');
        isValid = false;
        bookDescription.classList.add('error');
    } else {
        bookDescription.classList.remove('error');
    }
    
    // Validate publish date
    const bookPublishDate = document.getElementById('bookPublishDate');
    if (!bookPublishDate.value) {
        errors.push('Publish date is required');
        isValid = false;
        bookPublishDate.classList.add('error');
    } else {
        bookPublishDate.classList.remove('error');
    }
    
    // Validate price
    const bookPrice = document.getElementById('bookPrice');
    if (!validatePrice(bookPrice)) {
        errors.push('Valid price is required');
        isValid = false;
    }
    
    // Validate category
    const bookCategory = document.getElementById('bookCategory');
    if (!bookCategory.value) {
        errors.push('Category is required');
        isValid = false;
        bookCategory.classList.add('error');
    } else {
        bookCategory.classList.remove('error');
    }
    
    // Validate availability
    const bookAvailable = document.getElementById('bookAvailable');
    if (!bookAvailable.value) {
        errors.push('Availability is required');
        isValid = false;
        bookAvailable.classList.add('error');
    } else {
        bookAvailable.classList.remove('error');
    }
    
    // Show errors if any
    if (!isValid) {
        alert('Please fill in all required fields:\n\n' + errors.join('\n'));
    }
    
    return isValid;
}

/**
 * Validate price input
 */
function validatePrice(input) {
    const value = input.value;
    
    // Check if value is a valid number
    if (!value || isNaN(value) || parseFloat(value) < 0) {
        input.classList.add('error');
        return false;
    } else {
        input.classList.remove('error');
        return true;
    }
}

/**
 * Validate date input
 */
function validateDate(input) {
    const value = input.value;
    
    if (!value) {
        input.classList.add('error');
        return false;
    }
    
    // Optional: Check if date is not in the future
    const selectedDate = new Date(value);
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    if (selectedDate > today) {
        if (confirm('The publish date is in the future. Is this correct?')) {
            input.classList.remove('error');
            return true;
        } else {
            input.classList.add('error');
            return false;
        }
    }
    
    input.classList.remove('error');
    return true;
}

/**
 * Check for status messages in URL
 */
function checkStatusMessage() {
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');
    const message = urlParams.get('message');
    
    if (status && message) {
        showMessage(status, decodeURIComponent(message));
        
        // Clean URL
        if (window.history && window.history.replaceState) {
            const cleanUrl = window.location.pathname;
            window.history.replaceState({}, document.title, cleanUrl);
        }
    }
}

/**
 * Show message dialog
 */
function showMessage(status, message) {
    const messageBox = document.getElementById('messageBox');
    const messageTitle = document.getElementById('messageTitle');
    const messageText = document.getElementById('messageText');
    const overlay = document.getElementById('overlay');
    
    if (messageBox && messageTitle && messageText && overlay) {
        messageBox.className = 'message-box show ' + status;
        messageTitle.textContent = status === 'success' ? 'Success!' : 'Error!';
        messageText.textContent = message;
        
        overlay.classList.add('show');
    } else {
        // Fallback to alert if elements don't exist
        alert(message);
    }
}

/**
 * Close message dialog
 */
function closeMessage() {
    const messageBox = document.getElementById('messageBox');
    const overlay = document.getElementById('overlay');
    
    if (messageBox && overlay) {
        messageBox.classList.remove('show');
        overlay.classList.remove('show');
        
        // Redirect to books page on success
        if (messageBox.classList.contains('success')) {
            const contextPath = getContextPath();
            window.location.href = contextPath + '/AdminBookServlet';
        }
    }
}

/**
 * Reset form
 */
function resetForm() {
    const form = document.getElementById('addBookForm');
    const imagePreview = document.getElementById('imagePreview');
    const uploadPlaceholder = document.getElementById('uploadPlaceholder');
    const fileInput = document.getElementById('fileInput');
    
    if (form) {
        form.reset();
    }
    
    if (imagePreview && uploadPlaceholder) {
        imagePreview.classList.remove('show');
        uploadPlaceholder.style.display = 'block';
    }
    
    if (fileInput) {
        fileInput.value = '';
    }
    
    // Remove all error classes
    const errorInputs = document.querySelectorAll('.error');
    errorInputs.forEach(input => input.classList.remove('error'));
}

// Add CSS for error states
const style = document.createElement('style');
style.textContent = `
    input.error,
    textarea.error,
    select.error {
        border-color: #f44336 !important;
        background-color: #ffebee !important;
    }
    
    input.error:focus,
    textarea.error:focus,
    select.error:focus {
        outline: 2px solid #f44336 !important;
    }
`;
document.head.appendChild(style);