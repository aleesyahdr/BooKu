/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
document.getElementById('fileInput').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(event) {
            document.getElementById('imagePreview').src = event.target.result;
            document.getElementById('imagePreview').classList.add('show');
            document.getElementById('uploadPlaceholder').style.display = 'none';
        };
        reader.readAsDataURL(file);
    }
});

document.getElementById('addBtn').addEventListener('click', function() {
    const bookName = document.getElementById('bookName').value;
    const bookDescription = document.getElementById('bookDescription').value;
    const bookPrice = document.getElementById('bookPrice').value;
    const bookAvailability = document.getElementById('bookAvailability').value;

    if (bookName && bookDescription && bookPrice && bookAvailability) {
        showMessage();
    } else {
        alert('Please fill in all fields');
    }
});

function showMessage() {
    document.getElementById('overlay').classList.add('show');
    document.getElementById('messageBox').classList.add('show');
}

