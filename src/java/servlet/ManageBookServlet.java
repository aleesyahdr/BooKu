package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.DBConnection;
import model.Book;


public class ManageBookServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookId = request.getParameter("id");
        
        if (bookId == null || bookId.isEmpty()) {
            response.sendRedirect("EmpBookServlet");
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.createConnection();
            
            String sql = "SELECT * FROM BOOK WHERE BOOK_ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(bookId));
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Book book = new Book(
                    rs.getInt("BOOK_ID"),
                    rs.getString("BOOK_NAME"),
                    rs.getString("BOOK_AUTHOR"),
                    rs.getString("BOOK_DESCRIPTION"),
                    rs.getDate("BOOK_PUBLISHDATE"),
                    rs.getDouble("BOOK_PRICE"),
                    rs.getString("BOOK_CATEGORY"),
                    rs.getString("BOOK_IMG")
                );
                
                // Determine availability based on quantity
                int quantity = rs.getInt("BOOK_QUANTITY");
                String availability;
                if (quantity > 0) {
                    availability = "in-stock";
                } else if (quantity == 0) {
                    availability = "out-of-stock";
                } else {
                    availability = "pre-order";
                }
                
                request.setAttribute("book", book);
                request.setAttribute("availability", availability);
                request.setAttribute("quantity", quantity);
            } else {
                response.sendRedirect("EmpBookServlet");
                return;
            }
            
        } catch (SQLException e) {
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
        
        request.getRequestDispatcher("employee/manageBook.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String bookId = request.getParameter("bookId");
        
        if ("delete".equals(action)) {
            deleteBook(bookId, session);
        } else if ("update".equals(action)) {
            updateBook(request, session);
        }
        
        response.sendRedirect("EmpBookServlet");
    }
    
    private void deleteBook(String bookId, HttpSession session) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.createConnection();
            String sql = "DELETE FROM BOOK WHERE BOOK_ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(bookId));
            
            int rowsDeleted = pstmt.executeUpdate();
            
            if (rowsDeleted > 0) {
                session.setAttribute("message", "Book deleted successfully!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Failed to delete book!");
                session.setAttribute("messageType", "error");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("message", "Database error: " + e.getMessage());
            session.setAttribute("messageType", "error");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    private void updateBook(HttpServletRequest request, HttpSession session) {
        String bookId = request.getParameter("bookId");
        String bookName = request.getParameter("bookName");
        String bookAuthor = request.getParameter("bookAuthor");
        String bookDescription = request.getParameter("bookDescription");
        String bookPrice = request.getParameter("bookPrice");
        String bookCategory = request.getParameter("bookCategory");
        String bookPublishDate = request.getParameter("bookPublishDate");
        String availability = request.getParameter("bookAvailability");
        String bookImg = request.getParameter("bookImg");
        
        // Set quantity based on availability
        int quantity = 0;
        if ("in-stock".equals(availability)) {
            quantity = 10;
        } else if ("out-of-stock".equals(availability)) {
            quantity = 0;
        } else if ("pre-order".equals(availability)) {
            quantity = -1;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.createConnection();
            
            String sql = "UPDATE BOOK SET BOOK_NAME = ?, BOOK_AUTHOR = ?, BOOK_DESCRIPTION = ?, " +
                        "BOOK_PUBLISHDATE = ?, BOOK_PRICE = ?, BOOK_QUANTITY = ?, " +
                        "BOOK_CATEGORY = ?, BOOK_IMG = ? WHERE BOOK_ID = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, bookName);
            pstmt.setString(2, bookAuthor);
            pstmt.setString(3, bookDescription);
            pstmt.setDate(4, Date.valueOf(bookPublishDate));
            pstmt.setDouble(5, Double.parseDouble(bookPrice));
            pstmt.setInt(6, quantity);
            pstmt.setString(7, bookCategory);
            pstmt.setString(8, bookImg);
            pstmt.setInt(9, Integer.parseInt(bookId));
            
            int rowsUpdated = pstmt.executeUpdate();
            
            if (rowsUpdated > 0) {
                session.setAttribute("message", "Book updated successfully!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Failed to update book!");
                session.setAttribute("messageType", "error");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("message", "Database error: " + e.getMessage());
            session.setAttribute("messageType", "error");
        } catch (NumberFormatException e) {
            session.setAttribute("message", "Invalid price format!");
            session.setAttribute("messageType", "error");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}