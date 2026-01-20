// Sidebar toggle functionality
function toggleSidebar() {
    var sidebar = document.getElementById('sidebar');
    var mainContent = document.getElementById('mainContent');
    var toggleBtn = document.getElementById('toggleBtn');
    
    sidebar.classList.toggle('hidden');
    mainContent.classList.toggle('expanded');
    toggleBtn.classList.toggle('shifted');
}

// Tab switching functionality
function openTab(evt, tabName) {
    var i, tabcontent, tablinks;
    
    tabcontent = document.getElementsByClassName("tab-content");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].classList.remove("active");
    }
    
    tablinks = document.getElementsByClassName("tab");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].classList.remove("active");
    }
    
    document.getElementById(tabName).classList.add("active");
    evt.currentTarget.classList.add("active");
}

// Open modal for adding new user
function openAddModal(userType) {
    document.getElementById('modalTitle').textContent = 'Add ' + 
        (userType === 'employee' ? 'Employee' : 'Customer');
    document.getElementById('formAction').value = 'add';
    document.getElementById('userType').value = userType;
    document.getElementById('userForm').reset();
    document.getElementById('userId').value = '';
    document.getElementById('userModal').style.display = 'block';
}

// Open modal for editing employee
function editEmployee(id, username, password, firstName, lastName, phoneNum, email, address, city, state, postcode,dob) {
    document.getElementById('modalTitle').textContent = 'Edit Employee';
    document.getElementById('formAction').value = 'edit';
    document.getElementById('userType').value = 'employee';
    document.getElementById('userId').value = id;
    document.getElementById('username').value = username;
    document.getElementById('password').value = password;
    document.getElementById('firstName').value = firstName;
    document.getElementById('lastName').value = lastName;
    document.getElementById('phoneNum').value = phoneNum;
    document.getElementById('email').value = email;
    document.getElementById('address').value = address;
    document.getElementById('city').value = city;
    document.getElementById('state').value = state;
    document.getElementById('postcode').value = postcode;
    document.getElementById('dob').value = dob;
    document.getElementById('userModal').style.display = 'block';
}

// Open modal for editing customer
function editCustomer(id, username, password, firstName, lastName, phoneNum, email, dob, address, city, state, postcode) {
    document.getElementById('modalTitle').textContent = 'Edit Customer';
    document.getElementById('formAction').value = 'edit';
    document.getElementById('userType').value = 'customer';
    document.getElementById('userId').value = id;
    document.getElementById('username').value = username;
    document.getElementById('password').value = password;
    document.getElementById('firstName').value = firstName;
    document.getElementById('lastName').value = lastName;
    document.getElementById('phoneNum').value = phoneNum;
    document.getElementById('email').value = email;
    document.getElementById('dob').value = dob;
    document.getElementById('address').value = address;
    document.getElementById('city').value = city;
    document.getElementById('state').value = state;
    document.getElementById('postcode').value = postcode;
    document.getElementById('userModal').style.display = 'block';
}

// Close modal
function closeModal() {
    document.getElementById('userModal').style.display = 'none';
}

// Delete user with confirmation
function deleteUser(userType, userId) {
    if (confirm('Are you sure you want to delete this user?')) {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = 'manageUserServlet';
        
        form.innerHTML = '<input type="hidden" name="action" value="delete">' +
                        '<input type="hidden" name="userType" value="' + userType + '">' +
                        '<input type="hidden" name="userId" value="' + userId + '">';
        
        document.body.appendChild(form);
        form.submit();
    }
}

// Search table functionality
function searchTable(tableId, searchId) {
    var input = document.getElementById(searchId);
    var filter = input.value.toUpperCase();
    var table = document.getElementById(tableId);
    var tr = table.getElementsByTagName("tr");
    
    for (var i = 1; i < tr.length; i++) {
        var visible = false;
        var td = tr[i].getElementsByTagName("td");
        
        for (var j = 0; j < td.length - 1; j++) {
            if (td[j]) {
                var txtValue = td[j].textContent || td[j].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    visible = true;
                    break;
                }
            }
        }
        
        tr[i].style.display = visible ? "" : "none";
    }
}

// Close modal when clicking outside
window.onclick = function(event) {
    var modal = document.getElementById('userModal');
    if (event.target == modal) {
        closeModal();
    }
}