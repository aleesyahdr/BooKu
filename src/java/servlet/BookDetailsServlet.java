package servlet;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Book;
import util.DBConnection;

public class BookDetailsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookIdParam = request.getParameter("book_id");
        
        System.out.println("BookDetailsServlet: book_id parameter = " + bookIdParam);
        
        if (bookIdParam != null && !bookIdParam.isEmpty()) {
            try {
                int bookId = Integer.parseInt(bookIdParam);
                Book book = null;
                Connection conn = DBConnection.createConnection();
                
                if (conn != null) {
                    String query = "SELECT * FROM BOOK WHERE BOOK_ID = ?";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setInt(1, bookId);
                    ResultSet rs = stmt.executeQuery();
                    
                    if (rs.next()) {
                        book = new Book(
                            rs.getInt("BOOK_ID"),
                            rs.getString("BOOK_NAME"),
                            rs.getString("BOOK_AUTHOR"),
                            rs.getString("BOOK_DESCRIPTION"),
                            rs.getDate("BOOK_PUBLISHDATE"),
                            rs.getDouble("BOOK_PRICE"),
                            rs.getString("BOOK_CATEGORY"),
                            rs.getString("BOOK_IMG"),
                            rs.getBoolean("BOOK_AVAILABLE") 
                        );
                        System.out.println("Found book: " + book.getBook_name());
                    } else {
                        System.out.println("No book found with ID: " + bookId);
                    }
                    
                    rs.close();
                    stmt.close();
                    conn.close();
                }
                
                if (book != null) {
                    request.setAttribute("book", book);
                    System.out.println("Forwarding to bookDetails.jsp");
                    request.getRequestDispatcher("/customer/bookDetails.jsp").forward(request, response);
                } else {
                    System.out.println("Book is null, redirecting to BooksServlet");
                    response.sendRedirect(request.getContextPath() + "/BooksServlet");
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid book_id format: " + bookIdParam);
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/BooksServlet");
            } catch (SQLException e) {
                System.err.println("Database error in BookDetailsServlet:");
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/BooksServlet");
            }
        } else {
            System.out.println("book_id parameter is null or empty");
            response.sendRedirect(request.getContextPath() + "/BooksServlet");
        }
    }
}