package servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DBConnection;

public class CheckBookServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<html><body>");
        out.println("<h1>Database Test</h1>");
        
        Connection conn = DBConnection.createConnection();
        
        if (conn != null) {
            out.println("<p style='color: green;'><b>✓ Connection successful!</b></p>");
            
            try {
                String query = "SELECT COUNT(*) as count FROM BOOK";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                
                if (rs.next()) {
                    int count = rs.getInt("count");
                    out.println("<p>Total books in database: <b>" + count + "</b></p>");
                    
                    if (count > 0) {
                        out.println("<p style='color: green;'><b>✓ Books exist!</b></p>");
                        out.println("<h3>First 5 books:</h3>");
                        out.println("<ul>");
                        
                        String query2 = "SELECT BOOK_ID, BOOK_NAME, BOOK_PRICE FROM BOOK LIMIT 5";
                        Statement stmt2 = conn.createStatement();
                        ResultSet rs2 = stmt2.executeQuery(query2);
                        
                        while (rs2.next()) {
                            out.println("<li>ID: " + rs2.getInt("BOOK_ID") + " | Name: " + rs2.getString("BOOK_NAME") + " | Price: RM" + rs2.getDouble("BOOK_PRICE") + "</li>");
                        }
                        
                        out.println("</ul>");
                        rs2.close();
                        stmt2.close();
                    } else {
                        out.println("<p style='color: red;'><b>✗ No books in database!</b></p>");
                        out.println("<p>You need to insert book data into the BOOK table.</p>");
                    }
                }
                
                rs.close();
                stmt.close();
                conn.close();
                
            } catch (SQLException e) {
                out.println("<p style='color: red;'><b>✗ SQL Error:</b></p>");
                out.println("<pre>" + e.getMessage() + "</pre>");
                e.printStackTrace(out);
            }
        } else {
            out.println("<p style='color: red;'><b>✗ Connection failed!</b></p>");
            out.println("<p>Check if Java DB server is running.</p>");
        }
        
        out.println("<hr>");
        out.println("<p><a href='" + request.getContextPath() + "/IndexServlet'>Go to Index</a></p>");
        out.println("</body></html>");
        out.close();
    }
}