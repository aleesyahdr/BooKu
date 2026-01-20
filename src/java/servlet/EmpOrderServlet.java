package servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import util.DBConnection;

public class EmpOrderServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("empUsername") == null) {
            response.sendRedirect(request.getContextPath() + "/employees/index.jsp");
            return;
        }
        
        List<Map<String, Object>> orderList = new ArrayList<>();
        
        // SIMPLEST QUERY FIRST - NO JOINS
        // This will tell us if the problem is the JOINs or something else
        String sql = "SELECT ORDER_ID, ORDER_TOTAL, ORDER_STATUS, CUST_ID " +
                     "FROM \"ORDERS\" " +
                     "WHERE IS_DELETED = 0 " +
                     "ORDER BY ORDER_DATE DESC";
        
        try (Connection conn = DBConnection.createConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            System.out.println("=== Executing simple query ===");
            int count = 0;
            
            while (rs.next()) {
                count++;
                Map<String, Object> order = new HashMap<>();
                int orderId = rs.getInt("ORDER_ID");
                int custId = rs.getInt("CUST_ID");
                
                order.put("orderId", orderId);
                order.put("customerName", "Loading..."); // We'll fix this next
                order.put("bookTitle", "Loading..."); // We'll fix this next
                order.put("orderTotal", rs.getDouble("ORDER_TOTAL"));
                order.put("status", rs.getString("ORDER_STATUS"));
                
                // Now get customer name separately
                try (PreparedStatement custStmt = conn.prepareStatement(
                        "SELECT CUST_FIRSTNAME, CUST_LASTNAME FROM CUSTOMER WHERE CUST_ID = ?")) {
                    custStmt.setInt(1, custId);
                    ResultSet custRs = custStmt.executeQuery();
                    if (custRs.next()) {
                        String firstName = custRs.getString("CUST_FIRSTNAME");
                        String lastName = custRs.getString("CUST_LASTNAME");
                        order.put("customerName", firstName + " " + lastName);
                    } else {
                        order.put("customerName", "Unknown Customer");
                    }
                }
                
                // Get first book from order
                try (PreparedStatement bookStmt = conn.prepareStatement(
                        "SELECT b.BOOK_NAME FROM ORDERDETAILS od " +
                        "JOIN BOOK b ON od.BOOK_ID = b.BOOK_ID " +
                        "WHERE od.ORDER_ID = ? " +
                        "FETCH FIRST 1 ROW ONLY")) {
                    bookStmt.setInt(1, orderId);
                    ResultSet bookRs = bookStmt.executeQuery();
                    if (bookRs.next()) {
                        order.put("bookTitle", bookRs.getString("BOOK_NAME"));
                    } else {
                        order.put("bookTitle", "No book found");
                    }
                }
                
                orderList.add(order);
                System.out.println("Added order: " + orderId);
            }
            
            System.out.println("Total orders found: " + count);
            request.setAttribute("orderList", orderList);
            
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/employees/orders.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String orderId = request.getParameter("orderId");
        
        if ("delete".equals(action) && orderId != null) {
            try (Connection conn = DBConnection.createConnection()) {
                String sql = "UPDATE \"ORDERS\" SET IS_DELETED = 1 WHERE ORDER_ID = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(orderId));
                ps.executeUpdate();
                
                request.getSession().setAttribute("message", "Order deleted successfully.");
                request.getSession().setAttribute("messageType", "success");
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("message", "Error deleting order.");
                request.getSession().setAttribute("messageType", "error");
            }
        }
        
        response.sendRedirect("EmpOrderServlet");
    }
}