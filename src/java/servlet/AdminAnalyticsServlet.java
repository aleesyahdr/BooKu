package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DBConnection;

public class AdminAnalyticsServlet extends HttpServlet 
{
    private Connection getConnection() {
        return DBConnection.createConnection();
    }
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminAnalyticsServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAnalyticsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        Map<String, Object> stats = new HashMap<>();
        List<Map<String, Object>> topBooks = new ArrayList<>();

        // Using your DBConnection class
        try (Connection conn = DBConnection.createConnection()) {
            if (conn != null) {
                String statsQuery = "SELECT COALESCE(SUM(ORDER_TOTAL), 0), COUNT(ORDER_ID) FROM ORDERS";

                try (PreparedStatement ps1 = conn.prepareStatement(statsQuery);
                     ResultSet rs1 = ps1.executeQuery()) {
                    if (rs1.next()) {
                        double revenue = rs1.getDouble(1);
                        int orders = rs1.getInt(2);
                        stats.put("totalRevenue", revenue);
                        stats.put("totalOrders", orders);
                        stats.put("avgOrder", orders > 0 ? revenue / orders : 0);
                    }
                }

                //Fetch total books sold separately
                String booksSoldQuery = "SELECT COALESCE(SUM(QUANTITY), 0) FROM ORDERDETAILS";
                try (PreparedStatement psSold = conn.prepareStatement(booksSoldQuery);
                     ResultSet rsSold = psSold.executeQuery()) {
                    if (rsSold.next()) {
                        stats.put("booksSold", rsSold.getInt(1));
                    } else {
                        stats.put("booksSold", 0);
                    }
                }

                //Top Selling Books
                String topBooksQuery = "SELECT b.BOOK_NAME, b.BOOK_AUTHOR, SUM(od.QUANTITY) as total_sold, SUM(od.PRICE * od.QUANTITY) as total_rev " +
                                       "FROM BOOK b " +
                                       "JOIN ORDERDETAILS od ON b.BOOK_ID = od.BOOK_ID " +
                                       "GROUP BY b.BOOK_NAME, b.BOOK_AUTHOR " +
                                       "ORDER BY total_sold DESC " +
                                       "FETCH FIRST 5 ROWS ONLY";

                try (PreparedStatement ps2 = conn.prepareStatement(topBooksQuery);
                     ResultSet rs2 = ps2.executeQuery()) {
                    while (rs2.next()) {
                        Map<String, Object> book = new HashMap<>();
                        book.put("name", rs2.getString("BOOK_NAME"));
                        book.put("author", rs2.getString("BOOK_AUTHOR"));
                        book.put("sold", rs2.getInt("total_sold"));
                        book.put("revenue", rs2.getDouble("total_rev"));
                        topBooks.add(book);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("stats", stats);
        request.setAttribute("topBooks", topBooks);
        request.getRequestDispatcher("/admin/analytics.jsp").forward(request, response);
    }
    

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
