/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
document.getElementById('updateBtn').addEventListener('click', function() {
    const bookName = document.getElementById('bookName').value;
    const bookDescription = document.getElementById('bookDescription').value;
    const bookPrice = document.getElementById('bookPrice').value;
    const bookAvailability = document.getElementById('bookAvailability').value;
    
    if (bookName && bookDescription && bookPrice) {
        showMessage('Success!', 'Book updated successfully!');
        
        setTimeout(function() {
            window.location.href = 'books.html';
        }, 2000);
    }
});

document.getElementById('deleteBtn').addEventListener('click', function() {
    if (confirm('Are you sure you want to delete this book?')) {
        showMessage('Deleted!', 'Book deleted successfully!');
        
        setTimeout(function() {
            window.location.href = 'books.html';
        }, 2000);
    }
});

function showMessage(title, text) {
    document.getElementById('messageTitle').textContent = title;
    document.getElementById('messageText').textContent = text;
    document.getElementById('overlay').classList.add('show');
    document.getElementById('messageBox').classList.add('show');
}

function closeMessage() {
    document.getElementById('overlay').classList.remove('show');
    document.getElementById('messageBox').classList.remove('show');
}

