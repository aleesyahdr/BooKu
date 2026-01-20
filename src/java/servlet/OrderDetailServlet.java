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

public class OrderDetailServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String orderId = request.getParameter("id");
        
        if (orderId == null || orderId.isEmpty()) {
            response.sendRedirect("EmpOrderServlet");
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.createConnection();
            
            // Get order and customer info
            String sql = "SELECT o.ORDER_ID, o.ORDER_DATE, o.ORDER_TIME, o.ORDER_TOTAL, " +
                        "c.CUST_FIRSTNAME, c.CUST_LASTNAME, c.CUST_EMAIL, c.CUST_PHONENUM, " +
                        "c.CUST_ADDRESS, c.CUST_CITY, c.CUST_STATE, c.CUST_POSTCODE " +
                        "FROM ORDERS o " +
                        "JOIN CUSTOMER c ON o.CUST_ID = c.CUST_ID " +
                        "WHERE o.ORDER_ID = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(orderId));
            rs = pstmt.executeQuery();
            
            Map<String, Object> orderInfo = new HashMap<>();
            if (rs.next()) {
                orderInfo.put("orderId", rs.getInt("ORDER_ID"));
                orderInfo.put("orderDate", rs.getDate("ORDER_DATE"));
                orderInfo.put("orderTime", rs.getTime("ORDER_TIME"));
                orderInfo.put("orderTotal", rs.getDouble("ORDER_TOTAL"));
                orderInfo.put("customerName", rs.getString("CUST_FIRSTNAME") + " " + rs.getString("CUST_LASTNAME"));
                orderInfo.put("customerEmail", rs.getString("CUST_EMAIL"));
                orderInfo.put("customerPhone", rs.getString("CUST_PHONENUM"));
                
                String address = rs.getString("CUST_ADDRESS") + ", " + 
                               rs.getString("CUST_CITY") + ", " + 
                               rs.getString("CUST_STATE") + " " + 
                               rs.getString("CUST_POSTCODE");
                orderInfo.put("customerAddress", address);
            } else {
                response.sendRedirect("EmpOrderServlet");
                return;
            }
            
            rs.close();
            pstmt.close();
            
            // Get order items
            String sql2 = "SELECT od.ORDER_QUANTITY, " +
                         "b.BOOK_NAME, b.BOOK_AUTHOR, b.BOOK_PRICE, b.BOOK_DESCRIPTION " +
                         "FROM ORDERDETAILS od " +
                         "JOIN BOOK b ON od.BOOK_ID = b.BOOK_ID " +
                         "WHERE od.ORDER_ID = ?";
            
            pstmt = conn.prepareStatement(sql2);
            pstmt.setInt(1, Integer.parseInt(orderId));
            rs = pstmt.executeQuery();
            
            List<Map<String, Object>> orderItems = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("bookName", rs.getString("BOOK_NAME"));
                item.put("bookAuthor", rs.getString("BOOK_AUTHOR"));
                item.put("bookPrice", rs.getDouble("BOOK_PRICE"));
                item.put("bookDescription", rs.getString("BOOK_DESCRIPTION"));
                item.put("quantity", rs.getInt("ORDER_QUANTITY"));
                item.put("subtotal", rs.getDouble("BOOK_PRICE") * rs.getInt("ORDER_QUANTITY"));
                orderItems.add(item);
            }
            
            request.setAttribute("orderInfo", orderInfo);
            request.setAttribute("orderItems", orderItems);
            
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
        
        request.getRequestDispatcher("employee/orderDetails.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String orderId = request.getParameter("orderId");
        String orderStatus = request.getParameter("orderStatus");
        
        // Note: You need to add ORDER_STATUS column to database to implement this
        // For now, just show success message
        
        session.setAttribute("message", "Order status updated to: " + orderStatus);
        session.setAttribute("messageType", "success");
        
        response.sendRedirect("EmpOrderServlet");
    }
}