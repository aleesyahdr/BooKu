package servlet;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Book;
import util.DBConnection;

public class IndexServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Book> books = new ArrayList<>();
        Connection conn = DBConnection.createConnection();
        
        System.out.println("IndexServlet: Getting all books from database...");
        
        if (conn != null) {
            try {
                String query = "SELECT * FROM BOOK FETCH FIRST 8 ROWS ONLY";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                
                while (rs.next()) {
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
                    books.add(book);
                    System.out.println("Added book: " + book.getBook_name());
                }
                
                System.out.println("Total books found: " + books.size());
                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                System.err.println("Database error in IndexServlet:");
                e.printStackTrace();
            }
        } else {
            System.err.println("Failed to get database connection in IndexServlet");
        }
        
        request.setAttribute("books", books);
        System.out.println("Forwarding to index.jsp with " + books.size() + " books");
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}