/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

// cart.js - Shopping Cart JavaScript Functions

/**
 * Update item quantity
 */
function updateQuantity(bookId, newQuantity) {
    if (newQuantity < 1) {
        // If quantity is less than 1, ask for confirmation to remove
        if (confirm('Remove this item from cart?')) {
            removeItem(bookId);
        }
        return;
    }
    
    // Create form and submit
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = getContextPath() + '/ShoppingCartServlet';
    
    // Add action parameter
    const actionInput = document.createElement('input');
    actionInput.type = 'hidden';
    actionInput.name = 'action';
    actionInput.value = 'update';
    form.appendChild(actionInput);
    
    // Add bookId parameter
    const bookIdInput = document.createElement('input');
    bookIdInput.type = 'hidden';
    bookIdInput.name = 'bookId';
    bookIdInput.value = bookId;
    form.appendChild(bookIdInput);
    
    // Add quantity parameter
    const quantityInput = document.createElement('input');
    quantityInput.type = 'hidden';
    quantityInput.name = 'quantity';
    quantityInput.value = newQuantity;
    form.appendChild(quantityInput);
    
    // Submit form
    document.body.appendChild(form);
    form.submit();
}

/**
 * Remove item from cart
 */
function removeItem(bookId) {
    if (!confirm('Are you sure you want to remove this item from your cart?')) {
        return;
    }
    
    // Create form and submit
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = getContextPath() + '/ShoppingCartServlet';
    
    // Add action parameter
    const actionInput = document.createElement('input');
    actionInput.type = 'hidden';
    actionInput.name = 'action';
    actionInput.value = 'remove';
    form.appendChild(actionInput);
    
    // Add bookId parameter
    const bookIdInput = document.createElement('input');
    bookIdInput.type = 'hidden';
    bookIdInput.name = 'bookId';
    bookIdInput.value = bookId;
    form.appendChild(bookIdInput);
    
    // Submit form
    document.body.appendChild(form);
    form.submit();
}

/**
 * Clear entire cart
 */
function clearCart() {
    if (!confirm('Are you sure you want to clear your entire cart?')) {
        return;
    }
    
    // Create form and submit
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = getContextPath() + '/ShoppingCartServlet';
    
    // Add action parameter
    const actionInput = document.createElement('input');
    actionInput.type = 'hidden';
    actionInput.name = 'action';
    actionInput.value = 'clear';
    form.appendChild(actionInput);
    
    // Submit form
    document.body.appendChild(form);
    form.submit();
}

/**
 * Helper function to get context path
 */
function getContextPath() {
    return window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
}

/**
 * Add to cart from book details or books page
 */
function addToCart(bookId, quantity) {
    if (!quantity || quantity < 1) {
        quantity = 1;
    }
    
    // Create form and submit
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = getContextPath() + '/ShoppingCartServlet';
    
    // Add action parameter
    const actionInput = document.createElement('input');
    actionInput.type = 'hidden';
    actionInput.name = 'action';
    actionInput.value = 'add';
    form.appendChild(actionInput);
    
    // Add bookId parameter
    const bookIdInput = document.createElement('input');
    bookIdInput.type = 'hidden';
    bookIdInput.name = 'bookId';
    bookIdInput.value = bookId;
    form.appendChild(bookIdInput);
    
    // Add quantity parameter
    const quantityInput = document.createElement('input');
    quantityInput.type = 'hidden';
    quantityInput.name = 'quantity';
    quantityInput.value = quantity;
    form.appendChild(quantityInput);
    
    // Submit form
    document.body.appendChild(form);
    form.submit();
}
