/**
 * manageBooks.js - JavaScript for Manage Books page
 * Handles filtering, searching, and book actions
 */

document.addEventListener('DOMContentLoaded', function() {
    // Check for status messages in URL
    checkStatusMessage();
    
    // Setup filter functionality
    setupFilters();
});

/**
 * Setup filter and search functionality
 */
function setupFilters() {
    const searchInput = document.getElementById('searchInput');
    const categoryFilter = document.getElementById('categoryFilter');
    const statusFilter = document.getElementById('statusFilter');
    
    if (searchInput) {
        searchInput.addEventListener('input', filterBooks);
    }
    
    if (categoryFilter) {
        categoryFilter.addEventListener('change', filterBooks);
    }
    
    if (statusFilter) {
        statusFilter.addEventListener('change', filterBooks);
    }
}

/**
 * Filter books based on search and filter criteria
 */
function filterBooks() {
    const searchInput = document.getElementById('searchInput');
    const categoryFilter = document.getElementById('categoryFilter');
    const statusFilter = document.getElementById('statusFilter');
    const table = document.getElementById('booksTable');
    
    if (!table) return;
    
    const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';
    const selectedCategory = categoryFilter ? categoryFilter.value.toLowerCase() : '';
    const selectedStatus = statusFilter ? statusFilter.value.toLowerCase() : '';
    
    const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
    let visibleCount = 0;
    
    for (let i = 0; i < rows.length; i++) {
        const cells = rows[i].getElementsByTagName('td');
        
        if (cells.length === 0) continue;
        
        const title = cells[2] ? cells[2].textContent.toLowerCase() : '';
        const author = cells[3] ? cells[3].textContent.toLowerCase() : '';
        const category = cells[4] ? cells[4].textContent.toLowerCase() : '';
        const status = cells[8] ? cells[8].textContent.toLowerCase() : '';
        
        const matchesSearch = searchTerm === '' || 
                            title.includes(searchTerm) || 
                            author.includes(searchTerm) || 
                            category.includes(searchTerm);
        
        const matchesCategory = selectedCategory === '' || 
                               category.includes(selectedCategory);
        
        const matchesStatus = selectedStatus === '' || 
                             status.includes(selectedStatus);
        
        if (matchesSearch && matchesCategory && matchesStatus) {
            rows[i].style.display = '';
            visibleCount++;
        } else {
            rows[i].style.display = 'none';
        }
    }
    
    // Show message if no books found
    updateNoResultsMessage(visibleCount);
}

/**
 * Update no results message
 */
function updateNoResultsMessage(count) {
    let noResultsRow = document.getElementById('noResultsRow');
    const tbody = document.querySelector('#booksTable tbody');
    
    if (!tbody) return;
    
    if (count === 0) {
        if (!noResultsRow) {
            noResultsRow = document.createElement('tr');
            noResultsRow.id = 'noResultsRow';
            noResultsRow.innerHTML = '<td colspan="10" style="text-align: center; padding: 40px; color: #666;">No books found matching your criteria.</td>';
            tbody.appendChild(noResultsRow);
        }
        noResultsRow.style.display = '';
    } else {
        if (noResultsRow) {
            noResultsRow.style.display = 'none';
        }
    }
}

/**
 * Edit book - redirect to edit page
 */
function editBook(bookId) {
    if (!bookId) {
        alert('Invalid book ID');
        return;
    }
    
    const contextPath = getContextPath();
    window.location.href = contextPath + '/admin/editBook.jsp?bookId=' + bookId;
}

/**
 * Delete book with confirmation
 */
function deleteBook(bookId, bookName) {
    if (!bookId) {
        alert('Invalid book ID');
        return;
    }
    
    const confirmMessage = bookName ? 
        `Are you sure you want to delete "${bookName}"?\n\nThis action cannot be undone.` :
        'Are you sure you want to delete this book?\n\nThis action cannot be undone.';
    
    if (confirm(confirmMessage)) {
        const contextPath = getContextPath();
        window.location.href = contextPath + '/deleteBookServlet?bookId=' + bookId;
    }
}

/**
 * View book details
 */
function viewBook(bookId) {
    if (!bookId) {
        alert('Invalid book ID');
        return;
    }
    
    const contextPath = getContextPath();
    window.location.href = contextPath + '/admin/viewBook.jsp?bookId=' + bookId;
}

/**
 * Check for status messages in URL
 */
function checkStatusMessage() {
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');
    const message = urlParams.get('message');
    
    if (status && message) {
        const decodedMessage = decodeURIComponent(message);
        showNotification(decodedMessage, status);
        
        // Clean URL
        if (window.history && window.history.replaceState) {
            const cleanUrl = window.location.pathname;
            window.history.replaceState({}, document.title, cleanUrl);
        }
    }
}

/**
 * Export books to CSV
 */
function exportToCSV() {
    const table = document.getElementById('booksTable');
    if (!table) return;
    
    const rows = table.querySelectorAll('tbody tr');
    const visibleRows = Array.from(rows).filter(row => row.style.display !== 'none');
    
    if (visibleRows.length === 0) {
        alert('No books to export');
        return;
    }
    
    let csv = 'ID,Title,Author,Category,Published,Price,Status\n';
    
    visibleRows.forEach(row => {
        const cells = row.getElementsByTagName('td');
        if (cells.length > 0) {
            const id = cells[0].textContent;
            const title = cells[2].textContent.replace(/,/g, ';');
            const author = cells[3].textContent.replace(/,/g, ';');
            const category = cells[4].textContent;
            const published = cells[6].textContent;
            const price = cells[7].textContent;
            const status = cells[8].textContent.trim();
            
            csv += `${id},"${title}","${author}",${category},${published},${price},${status}\n`;
        }
    });
    
    // Create download link
    const blob = new Blob([csv], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'books_' + new Date().toISOString().split('T')[0] + '.csv';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    window.URL.revokeObjectURL(url);
    
    showNotification('Books exported successfully', 'success');
}

/**
 * Print books list
 */
function printBooksList() {
    window.print();
}

/**
 * Refresh books list
 */
function refreshBooks() {
    const contextPath = getContextPath();
    window.location.href = contextPath + '/AdminBookServlet';
}

/**
 * Clear all filters
 */
function clearFilters() {
    const searchInput = document.getElementById('searchInput');
    const categoryFilter = document.getElementById('categoryFilter');
    const statusFilter = document.getElementById('statusFilter');
    
    if (searchInput) searchInput.value = '';
    if (categoryFilter) categoryFilter.value = '';
    if (statusFilter) statusFilter.value = '';
    
    filterBooks();
}

// Add print styles
const printStyle = document.createElement('style');
printStyle.textContent = `
    @media print {
        .sidebar,
        .toggle-btn,
        .btn-add-new,
        .search-bar,
        .action-buttons {
            display: none !important;
        }
        
        .main-content {
            margin-left: 0 !important;
        }
        
        table {
            border-collapse: collapse;
            width: 100%;
        }
        
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
    }
`;
document.head.appendChild(printStyle);