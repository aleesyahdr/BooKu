package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DBConnection;


public class AnalyticsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.createConnection();
            
            // Get total revenue
            String sql1 = "SELECT SUM(ORDER_TOTAL) as TOTAL_REVENUE FROM ORDERS";
            pstmt = conn.prepareStatement(sql1);
            rs = pstmt.executeQuery();
            double totalRevenue = 0;
            if (rs.next()) {
                totalRevenue = rs.getDouble("TOTAL_REVENUE");
            }
            rs.close();
            pstmt.close();
            
            // Get total orders
            String sql2 = "SELECT COUNT(*) as TOTAL_ORDERS FROM ORDERS";
            pstmt = conn.prepareStatement(sql2);
            rs = pstmt.executeQuery();
            int totalOrders = 0;
            if (rs.next()) {
                totalOrders = rs.getInt("TOTAL_ORDERS");
            }
            rs.close();
            pstmt.close();
            
            // Get total books sold
            String sql3 = "SELECT SUM(ORDER_QUANTITY) as BOOKS_SOLD FROM ORDERDETAILS";
            pstmt = conn.prepareStatement(sql3);
            rs = pstmt.executeQuery();
            int booksSold = 0;
            if (rs.next()) {
                booksSold = rs.getInt("BOOKS_SOLD");
            }
            rs.close();
            pstmt.close();
            
            // Calculate average order value
            double avgOrderValue = totalOrders > 0 ? totalRevenue / totalOrders : 0;
            
            // Get top selling books
            String sql4 = "SELECT b.BOOK_NAME, b.BOOK_AUTHOR, " +
                         "SUM(od.ORDER_QUANTITY) as UNITS_SOLD, " +
                         "SUM(od.ORDER_QUANTITY * b.BOOK_PRICE) as REVENUE " +
                         "FROM ORDERDETAILS od " +
                         "JOIN BOOK b ON od.BOOK_ID = b.BOOK_ID " +
                         "GROUP BY b.BOOK_ID, b.BOOK_NAME, b.BOOK_AUTHOR " +
                         "ORDER BY UNITS_SOLD DESC " +
                         "FETCH FIRST 5 ROWS ONLY";
            
            pstmt = conn.prepareStatement(sql4);
            rs = pstmt.executeQuery();
            
            List<Map<String, Object>> topBooks = new ArrayList<>();
            int rank = 1;
            while (rs.next()) {
                Map<String, Object> book = new HashMap<>();
                book.put("rank", rank++);
                book.put("bookName", rs.getString("BOOK_NAME"));
                book.put("author", rs.getString("BOOK_AUTHOR"));
                book.put("unitsSold", rs.getInt("UNITS_SOLD"));
                book.put("revenue", rs.getDouble("REVENUE"));
                topBooks.add(book);
            }
            
            // Get monthly sales (simplified - just get total per month from available data)
            rs.close();
            pstmt.close();
            
            String sql5 = "SELECT MONTH(ORDER_DATE) as MONTH, " +
                         "SUM(ORDER_TOTAL) as MONTHLY_TOTAL " +
                         "FROM ORDERS " +
                         "WHERE YEAR(ORDER_DATE) = YEAR(CURRENT_DATE) " +
                         "GROUP BY MONTH(ORDER_DATE) " +
                         "ORDER BY MONTH(ORDER_DATE)";
            
            pstmt = conn.prepareStatement(sql5);
            rs = pstmt.executeQuery();
            
            Map<Integer, Double> monthlySales = new HashMap<>();
            while (rs.next()) {
                monthlySales.put(rs.getInt("MONTH"), rs.getDouble("MONTHLY_TOTAL"));
            }
            
            // Set attributes
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("booksSold", booksSold);
            request.setAttribute("avgOrderValue", avgOrderValue);
            request.setAttribute("topBooks", topBooks);
            request.setAttribute("monthlySales", monthlySales);
            
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
        
        request.getRequestDispatcher("employee/analytics.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}