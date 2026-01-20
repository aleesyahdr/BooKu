package servlet;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Book;
import util.DBConnection;

@WebServlet(name = "BooksServlet", urlPatterns = {"/BooksServlet"})
public class BooksServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get parameters
        String categoryFilter = request.getParameter("category");
        String searchQuery = request.getParameter("search");
        
        List<Book> books = new ArrayList<>();
        Connection conn = DBConnection.createConnection();
        
        System.out.println("BooksServlet: Getting books from database...");
        if (categoryFilter != null && !categoryFilter.equals("All")) {
            System.out.println("Filter by category: " + categoryFilter);
        }
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            System.out.println("Search query: " + searchQuery);
        }
        
        if (conn != null) {
            try {
                String query;
                PreparedStatement pstmt;
                
                // Build query based on filters
                if (searchQuery != null && !searchQuery.trim().isEmpty() && categoryFilter != null && !categoryFilter.equals("All")) {
                    // Both search and category filter
                    query = "SELECT * FROM BOOK WHERE BOOK_CATEGORY = ? AND (UPPER(BOOK_NAME) LIKE ? OR UPPER(BOOK_AUTHOR) LIKE ?)";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, categoryFilter);
                    pstmt.setString(2, "%" + searchQuery.toUpperCase() + "%");
                    pstmt.setString(3, "%" + searchQuery.toUpperCase() + "%");
                } else if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    // Only search query
                    query = "SELECT * FROM BOOK WHERE UPPER(BOOK_NAME) LIKE ? OR UPPER(BOOK_AUTHOR) LIKE ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, "%" + searchQuery.toUpperCase() + "%");
                    pstmt.setString(2, "%" + searchQuery.toUpperCase() + "%");
                } else if (categoryFilter != null && !categoryFilter.equals("All")) {
                    // Only category filter
                    query = "SELECT * FROM BOOK WHERE BOOK_CATEGORY = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, categoryFilter);
                } else {
                    // No filters - show all books
                    query = "SELECT * FROM BOOK";
                    pstmt = conn.prepareStatement(query);
                }
                
                ResultSet rs = pstmt.executeQuery();
                
                while (rs.next()) {
                    Book book = new Book(
                        rs.getInt("BOOK_ID"),
                        rs.getString("BOOK_NAME"),
                        rs.getString("BOOK_AUTHOR"),
                        rs.getString("BOOK_DESCRIPTION"),
                        rs.getDate("BOOK_PUBLISHDATE"),
                        rs.getDouble("BOOK_PRICE"),
                        rs.getString("BOOK_CATEGORY"),
                        rs.getString("BOOK_IMG"),
                        rs.getBoolean("BOOK_AVAILABLE")  // ADD THIS LINE!
                    );
                    books.add(book);
                }
                
                System.out.println("Total books found: " + books.size());
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                System.err.println("Database error in BooksServlet:");
                e.printStackTrace();
            }
        } else {
            System.err.println("Failed to get database connection in BooksServlet");
        }
        
        request.setAttribute("books", books);
        request.setAttribute("selectedCategory", categoryFilter != null ? categoryFilter : "All");
        request.setAttribute("searchQuery", searchQuery != null ? searchQuery : "");
        System.out.println("Forwarding to books.jsp with " + books.size() + " books");
        request.getRequestDispatcher("/customer/books.jsp").forward(request, response);
    }
}