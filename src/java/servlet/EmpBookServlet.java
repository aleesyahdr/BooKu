package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Book;
import util.DBConnection;

public class EmpBookServlet extends HttpServlet 
{
    private Connection getConnection() {
        return DBConnection.createConnection();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        String search = request.getParameter("search");
        
        List<Book> books = getAllBooks(category, search);
        List<String> categories = getAllCategories();
        
        // Debug output
        System.out.println("Books loaded: " + books.size());
        System.out.println("Categories found: " + categories.size());
        
        request.setAttribute("books", books);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/employees/books.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "add":
                    addBook(request);
                    request.setAttribute("message", "Book added successfully!");
                    break;
                    
                case "update":
                    updateBook(request);
                    request.setAttribute("message", "Book updated successfully!");
                    break;
                    
                case "delete":
                    deleteBook(request);
                    request.setAttribute("message", "Book deleted successfully!");
                    break;
                    
                default:
                    request.setAttribute("error", "Invalid action!");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Reload books and forward to JSP
        doGet(request, response);
    }
    
    // Get all distinct categories from database
    private List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT book_category FROM BOOK WHERE book_category IS NOT NULL ORDER BY book_category";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                
                while (rs.next()) {
                    String category = rs.getString("book_category");
                    if (category != null && !category.trim().isEmpty()) {
                        categories.add(category);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error loading categories: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return categories;
    }
    
    // Get all books from database with optional filtering
    private List<Book> getAllBooks(String category, String search) {
        List<Book> books = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM BOOK WHERE 1=1");
        
        // Add category filter
        if (category != null && !category.equals("all")) {
            sql.append(" AND book_category = ?");
        }
        
        // Add search filter
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (book_name LIKE ? OR book_author LIKE ? OR book_category LIKE ?)");
        }
        
        sql.append(" ORDER BY book_id DESC");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql.toString());
                
                int paramIndex = 1;
                
                // Set category parameter
                if (category != null && !category.equals("all")) {
                    pstmt.setString(paramIndex++, category);
                }
                
                // Set search parameters
                if (search != null && !search.trim().isEmpty()) {
                    String searchPattern = "%" + search + "%";
                    pstmt.setString(paramIndex++, searchPattern);
                    pstmt.setString(paramIndex++, searchPattern);
                    pstmt.setString(paramIndex++, searchPattern);
                }
                
                rs = pstmt.executeQuery();
                
                while (rs.next()) {
                    Book book = new Book(
                        rs.getInt("book_id"),
                        rs.getString("book_name"),
                        rs.getString("book_author"),
                        rs.getString("book_description"),
                        rs.getDate("book_publishDate"),
                        rs.getDouble("book_price"),
                        rs.getString("book_category"),
                        rs.getString("book_img"),
                        rs.getBoolean("book_available")
                    );
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error loading books: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return books;
    }
    
    // Add new book to database
    private void addBook(HttpServletRequest request) throws SQLException {
        String name = request.getParameter("book_name");
        String author = request.getParameter("book_author");
        String description = request.getParameter("book_description");
        Date publishDate = Date.valueOf(request.getParameter("book_publishDate"));
        double price = Double.parseDouble(request.getParameter("book_price"));
        String category = request.getParameter("book_category");
        String img = request.getParameter("book_img");
        
        String sql = "INSERT INTO BOOK (book_name, book_author, book_description, " +
                     "book_publishDate, book_price, book_category, book_img) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setString(2, author);
                pstmt.setString(3, description);
                pstmt.setDate(4, publishDate);
                pstmt.setDouble(5, price);
                pstmt.setString(6, category);
                pstmt.setString(7, img);
                
                pstmt.executeUpdate();
            }
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
    
    // Update existing book
    private void updateBook(HttpServletRequest request) throws SQLException {
        int bookId = Integer.parseInt(request.getParameter("book_id"));
        String name = request.getParameter("book_name");
        String author = request.getParameter("book_author");
        String description = request.getParameter("book_description");
        Date publishDate = Date.valueOf(request.getParameter("book_publishDate"));
        double price = Double.parseDouble(request.getParameter("book_price"));
        String category = request.getParameter("book_category");
        String img = request.getParameter("book_img");
        
        String sql = "UPDATE BOOK SET book_name = ?, book_author = ?, " +
                     "book_description = ?, book_publishDate = ?, book_price = ?, " +
                     "book_category = ?, book_img = ? WHERE book_id = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setString(2, author);
                pstmt.setString(3, description);
                pstmt.setDate(4, publishDate);
                pstmt.setDouble(5, price);
                pstmt.setString(6, category);
                pstmt.setString(7, img);
                pstmt.setInt(8, bookId);
                
                pstmt.executeUpdate();
            }
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
    
    // Delete book from database
    private void deleteBook(HttpServletRequest request) throws SQLException {
        int bookId = Integer.parseInt(request.getParameter("book_id"));
        
        String sql = "DELETE FROM BOOK WHERE book_id = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, bookId);
                pstmt.executeUpdate();
            }
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
}
