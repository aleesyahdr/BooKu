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
import javax.servlet.http.HttpSession;
import util.DBConnection;


public class EmpOrderServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<Map<String, Object>> orderList = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.createConnection();
            
            // Join ORDERS with CUSTOMER and ORDERDETAILS to get complete info
            String sql = "SELECT o.ORDER_ID, o.ORDER_DATE, o.ORDER_TIME, o.ORDER_TOTAL, " +
                        "c.CUST_FIRSTNAME, c.CUST_LASTNAME, " +
                        "COUNT(od.BOOK_ID) as TOTAL_BOOKS " +
                        "FROM ORDERS o " +
                        "JOIN CUSTOMER c ON o.CUST_ID = c.CUST_ID " +
                        "LEFT JOIN ORDERDETAILS od ON o.ORDER_ID = od.ORDER_ID " +
                        "GROUP BY o.ORDER_ID, o.ORDER_DATE, o.ORDER_TIME, o.ORDER_TOTAL, " +
                        "c.CUST_FIRSTNAME, c.CUST_LASTNAME " +
                        "ORDER BY o.ORDER_DATE DESC, o.ORDER_TIME DESC";
            
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("orderId", rs.getInt("ORDER_ID"));
                order.put("orderDate", rs.getDate("ORDER_DATE"));
                order.put("orderTime", rs.getTime("ORDER_TIME"));
                order.put("orderTotal", rs.getDouble("ORDER_TOTAL"));
                order.put("customerName", rs.getString("CUST_FIRSTNAME") + " " + rs.getString("CUST_LASTNAME"));
                order.put("totalBooks", rs.getInt("TOTAL_BOOKS"));
                // Status default - you can add ORDER_STATUS column to database later
                order.put("status", "Pending");
                
                orderList.add(order);
            }
            
            request.setAttribute("orderList", orderList);
            
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("message", "Error loading orders: " + e.getMessage());
            session.setAttribute("messageType", "error");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        request.getRequestDispatcher("employee/orders.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String orderId = request.getParameter("orderId");
        
        if ("delete".equals(action)) {
            deleteOrder(orderId, session);
        }
        
        response.sendRedirect("EmpOrderServlet");
    }
    
    private void deleteOrder(String orderId, HttpSession session) {
        Connection conn = null;
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;
        
        try {
            conn = DBConnection.createConnection();
            conn.setAutoCommit(false);
            
            // First delete order details
            String sql1 = "DELETE FROM ORDERDETAILS WHERE ORDER_ID = ?";
            pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setInt(1, Integer.parseInt(orderId));
            pstmt1.executeUpdate();
            
            // Then delete order
            String sql2 = "DELETE FROM ORDERS WHERE ORDER_ID = ?";
            pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setInt(1, Integer.parseInt(orderId));
            int rowsDeleted = pstmt2.executeUpdate();
            
            conn.commit();
            
            if (rowsDeleted > 0) {
                session.setAttribute("message", "Order deleted successfully!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Failed to delete order!");
                session.setAttribute("messageType", "error");
            }
            
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            session.setAttribute("message", "Database error: " + e.getMessage());
            session.setAttribute("messageType", "error");
        } finally {
            try {
                if (pstmt1 != null) pstmt1.close();
                if (pstmt2 != null) pstmt2.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}