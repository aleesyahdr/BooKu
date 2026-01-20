package servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Order;
import util.DBConnection;

@WebServlet(name = "OrderHistoryServlet", urlPatterns = {"/OrderHistoryServlet"})
public class OrderHistoryServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer custId = (Integer) session.getAttribute("custId");
        
        if (custId == null) {
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            return;
        }
        
        System.out.println("OrderHistoryServlet: Loading orders for customer ID: " + custId);
        
        List<Order> orders = getCustomerOrders(custId);
        Map<Integer, List<Map<String, Object>>> orderItemsMap = getOrderItemsMap(custId);
        
        request.setAttribute("orders", orders);
        request.setAttribute("orderItemsMap", orderItemsMap);
        
        System.out.println("OrderHistoryServlet: Found " + orders.size() + " orders");
        
        request.getRequestDispatcher("/customer/orderHistory.jsp").forward(request, response);
    }
    
    /**
     * Get all orders for a customer
     */
    private List<Order> getCustomerOrders(int custId) {
        List<Order> orders = new ArrayList<>();
        Connection conn = DBConnection.createConnection();
        
        if (conn != null) {
            try {
                String query = "SELECT ORDER_ID, ORDER_DATE, ORDER_TIME, ORDER_TOTAL, ORDER_STATUS, EMP_ID " +
                               "FROM ORDERS " +
                               "WHERE CUST_ID = ? " +
                               "ORDER BY ORDER_DATE DESC, ORDER_TIME DESC";
                
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, custId);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    Order order = new Order(
                        rs.getInt("ORDER_ID"),
                        rs.getDate("ORDER_DATE"),
                        rs.getTime("ORDER_TIME"),
                        rs.getDouble("ORDER_TOTAL"),
                        rs.getString("ORDER_STATUS"),
                        rs.getInt("EMP_ID"),
                        custId
                    );
                    orders.add(order);
                }
                
                rs.close();
                stmt.close();
                conn.close();
                
            } catch (SQLException e) {
                System.err.println("Error getting customer orders:");
                e.printStackTrace();
            }
        }
        
        return orders;
    }
    
    /**
     * Get all order items with book details
     */
    private Map<Integer, List<Map<String, Object>>> getOrderItemsMap(int custId) {
        Map<Integer, List<Map<String, Object>>> orderItemsMap = new HashMap<>();
        Connection conn = DBConnection.createConnection();
        
        if (conn != null) {
            try {
                String query = "SELECT o.ORDER_ID, od.BOOK_ID, od.ORDER_QUANTITY, " +
                               "b.BOOK_NAME, b.BOOK_IMG, b.BOOK_PRICE " +
                               "FROM ORDERS o " +
                               "JOIN ORDERDETAILS od ON o.ORDER_ID = od.ORDER_ID " +
                               "JOIN BOOK b ON od.BOOK_ID = b.BOOK_ID " +
                               "WHERE o.CUST_ID = ?";
                
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, custId);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    int orderId = rs.getInt("ORDER_ID");
                    
                    Map<String, Object> item = new HashMap<>();
                    item.put("bookId", rs.getInt("BOOK_ID"));
                    item.put("bookName", rs.getString("BOOK_NAME"));
                    item.put("bookImg", rs.getString("BOOK_IMG"));
                    item.put("bookPrice", rs.getDouble("BOOK_PRICE"));
                    item.put("quantity", rs.getInt("ORDER_QUANTITY"));
                    
                    if (!orderItemsMap.containsKey(orderId)) {
                        orderItemsMap.put(orderId, new ArrayList<>());
                    }
                    orderItemsMap.get(orderId).add(item);
                }
                
                rs.close();
                stmt.close();
                conn.close();
                
            } catch (SQLException e) {
                System.err.println("Error getting order items:");
                e.printStackTrace();
            }
        }
        
        return orderItemsMap;
    }
    
    @Override
    public String getServletInfo() {
        return "Order History Servlet";
    }
}