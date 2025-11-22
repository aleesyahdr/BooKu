/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
// Select form and cancel button
const paymentForm = document.getElementById('payment-form');
const cancelBtn = document.getElementById('cancel-btn');

// Submit Payment
paymentForm.addEventListener('submit', function(e) {
    e.preventDefault(); // Prevent actual form submission
    alert("Order successful! Thank you for your order.");
    window.location.href = "orderhistory.html"; // Redirect to order history
});

// Cancel Payment
cancelBtn.addEventListener('click', function() {
    alert("Payment cancelled");
    window.location.href = "../index.html"; // Redirect to home page
});


