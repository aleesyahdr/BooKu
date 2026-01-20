package servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import util.DBConnection;

public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== OrderDetailServlet.doGet() CALLED ===");
        
        String orderId = request.getParameter("id");
        System.out.println("Order ID parameter: " + orderId);
        
        if (orderId == null) {
            System.out.println("⚠️ Order ID is NULL - Redirecting to EmpOrderServlet");
            response.sendRedirect("EmpOrderServlet");
            return;
        }

        try (Connection conn = DBConnection.createConnection()) {
            System.out.println("✓ Database connection established");
            

            // Removed double quotes and ensured table names are correct
             String sql = "SELECT o.*,o.ORDER_RECEIPT, c.CUST_FIRSTNAME, c.CUST_LASTNAME, c.CUST_EMAIL, c.CUST_PHONENUM, " +
             "c.CUST_ADDRESS, c.CUST_CITY, c.CUST_STATE, c.CUST_POSTCODE, e.EMP_FNAME, e.EMP_LNAME " +
             "FROM ORDERS o " + 
             "JOIN CUSTOMER c ON o.CUST_ID = c.CUST_ID " +
             "LEFT JOIN EMPLOYEES e ON o.EMP_ID = e.EMP_ID " +
             "WHERE o.ORDER_ID = ?";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(orderId));
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                System.out.println("✓ Order found in database");
                Map<String, Object> orderInfo = new HashMap<>();
                orderInfo.put("orderId", rs.getInt("ORDER_ID"));
                orderInfo.put("paymentProof", rs.getString("ORDER_RECEIPT"));
                orderInfo.put("orderDate", rs.getDate("ORDER_DATE"));
                orderInfo.put("orderTime", rs.getTime("ORDER_TIME"));
                orderInfo.put("orderTotal", rs.getDouble("ORDER_TOTAL"));
                orderInfo.put("orderStatus", rs.getString("ORDER_STATUS"));
                orderInfo.put("customerName", rs.getString("CUST_FIRSTNAME") + " " + rs.getString("CUST_LASTNAME"));
                orderInfo.put("customerEmail", rs.getString("CUST_EMAIL"));
                orderInfo.put("customerPhone", rs.getString("CUST_PHONENUM"));
                
                // Get employee name who last updated (if exists)
                String empFirstName = rs.getString("EMP_FNAME");
                String empLastName = rs.getString("EMP_LNAME");
                if (empFirstName != null && empLastName != null) {
                    orderInfo.put("lastUpdatedBy", empFirstName + " " + empLastName);
                    System.out.println("✓ Last updated by: " + empFirstName + " " + empLastName);
                } else {
                    orderInfo.put("lastUpdatedBy", null);
                    System.out.println("ℹ️ No employee has updated this order yet");
                }
                
                String address = rs.getString("CUST_ADDRESS") + ", " + rs.getString("CUST_CITY");
                orderInfo.put("customerAddress", address);
                request.setAttribute("orderInfo", orderInfo);
                System.out.println("✓ Order info set in request");
            } else {
                System.out.println("⚠️ No order found with ID: " + orderId);
            }

            // Get the books in this order
            String sql2 = "SELECT od.ORDER_QUANTITY, b.BOOK_NAME, b.BOOK_PRICE, b.BOOK_AUTHOR, b.BOOK_DESCRIPTION " +
                          "FROM ORDERDETAILS od JOIN BOOK b ON od.BOOK_ID = b.BOOK_ID " +
                          "WHERE od.ORDER_ID = ?";
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setInt(1, Integer.parseInt(orderId));
            ResultSet rs2 = pstmt2.executeQuery();
            
            List<Map<String, Object>> orderItems = new ArrayList<>();
            while (rs2.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("bookName", rs2.getString("BOOK_NAME"));
                item.put("bookAuthor", rs2.getString("BOOK_AUTHOR"));
                item.put("bookDescription", rs2.getString("BOOK_DESCRIPTION"));
                item.put("bookPrice", rs2.getDouble("BOOK_PRICE"));
                item.put("quantity", rs2.getInt("ORDER_QUANTITY"));
                item.put("subtotal", rs2.getDouble("BOOK_PRICE") * rs2.getInt("ORDER_QUANTITY"));
                orderItems.add(item);
            }
            request.setAttribute("orderItems", orderItems);
            System.out.println("✓ Found " + orderItems.size() + " books in order");

        } catch (Exception e) { 
            System.err.println("❌ ERROR in OrderDetailServlet:");
            e.printStackTrace(); 
            request.setAttribute("errorMessage", "Error loading order details: " + e.getMessage());
        }
        
        System.out.println("✓ Forwarding to /employees/orderDetails.jsp");
        request.getRequestDispatcher("/employees/orderDetails.jsp").forward(request, response);
        System.out.println("✓ Forward complete");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== OrderDetailServlet.doPost() CALLED ===");
        
        HttpSession session = request.getSession();
        String orderId = request.getParameter("orderId");
        String orderStatus = request.getParameter("orderStatus");
        
        System.out.println("Order ID: " + orderId);
        System.out.println("New Status: " + orderStatus);
        
        // GET THE EMPLOYEE ID FROM SESSION
        Integer empId = (Integer) session.getAttribute("empId");
        System.out.println("Employee ID from session: " + empId);

        if (empId == null) {
            System.out.println("⚠️ Employee ID is NULL");
            session.setAttribute("message", "Error: Employee not logged in properly.");
            session.setAttribute("messageType", "error");
            response.sendRedirect("EmpOrderServlet");
            return;
        }

        try (Connection conn = DBConnection.createConnection()) {
            // UPDATE Status AND EMP_ID (auto-insert the employee who updated)
            String sql = "UPDATE \"ORDERS\" SET ORDER_STATUS = ?, EMP_ID = ? WHERE ORDER_ID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, orderStatus);
            ps.setInt(2, empId);
            ps.setInt(3, Integer.parseInt(orderId));
            
            int updated = ps.executeUpdate();
            System.out.println("✓ Rows updated: " + updated);
            
            if (updated > 0) {
                session.setAttribute("message", "Order status updated successfully!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Failed to update order status.");
                session.setAttribute("messageType", "error");
            }
            
        } catch (Exception e) { 
            System.err.println("❌ ERROR updating order:");
            e.printStackTrace(); 
            session.setAttribute("message", "Error updating order: " + e.getMessage());
            session.setAttribute("messageType", "error");
        }

        System.out.println("✓ Redirecting to EmpOrderServlet");
        response.sendRedirect("EmpOrderServlet");
    }
}