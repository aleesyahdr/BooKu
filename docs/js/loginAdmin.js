/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

document.addEventListener("DOMContentLoaded", function() {
    const loginForm = document.querySelector(".login-form");

    loginForm.addEventListener("submit", function(e) {
        e.preventDefault(); // prevent actual form submission
        // Here you can add validation if needed

        // Redirect to index.html
        window.location.href = "../admin/home.html"; // adjust path if needed
    });
});