package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import util.DBConnection;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/PaymentServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 5,         // 5MB
    maxRequestSize = 1024 * 1024 * 10      // 10MB
)
public class PaymentServlet extends HttpServlet {
    
    private static final String UPLOAD_DIR = "payment-receipts";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer custId = (Integer) session.getAttribute("custId");
        
        if (custId == null) {
            System.out.println("PaymentServlet: User not logged in, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            return;
        }
        
        String totalAmountStr = request.getParameter("totalAmount");
        double totalAmount = 0.0;
        
        if (totalAmountStr != null && !totalAmountStr.isEmpty()) {
            try {
                totalAmount = Double.parseDouble(totalAmountStr);
            } catch (NumberFormatException e) {
                totalAmount = 0.0;
            }
        }
        
        System.out.println("PaymentServlet GET: Customer ID = " + custId);
        System.out.println("PaymentServlet GET: Total Amount = " + totalAmount);
        
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("/customer/payment.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer custId = (Integer) session.getAttribute("custId");
        
        if (custId == null) {
            System.out.println("PaymentServlet POST: User not logged in");
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            return;
        }
        
        try {
            double amount = Double.parseDouble(request.getParameter("amount"));
            String paymentNote = request.getParameter("paymentNote");
            
            // Handle file upload (proof of payment)
            Part filePart = request.getPart("proofOfPayment");
            String fileName = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                String filePath = uploadPath + File.separator + uniqueFileName;
                
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                }
                
                fileName = uniqueFileName;
                System.out.println("Proof of payment uploaded: " + fileName);
            }
            
            System.out.println("PaymentServlet POST: Processing payment");
            System.out.println("Customer ID: " + custId);
            System.out.println("Amount: " + amount);
            
            Connection conn = DBConnection.createConnection();
            
            if (conn != null) {
                int cartId = getCartId(custId, conn);
                
                if (cartId == 0) {
                    request.setAttribute("error", "Cart not found!");
                    request.setAttribute("totalAmount", amount);
                    request.getRequestDispatcher("/customer/payment.jsp").forward(request, response);
                    return;
                }
                
                // Insert order with STATUS = "Pending"
                // Employee will later update to "In Progress" → "Completed"
                String orderQuery = "INSERT INTO ORDERS (ORDER_DATE, ORDER_TIME, ORDER_TOTAL, ORDER_STATUS, CUST_ID) VALUES (CURRENT_DATE, CURRENT_TIME, ?, 'Pending', ?)";
                PreparedStatement orderStmt = conn.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
                orderStmt.setDouble(1, amount);
                orderStmt.setInt(2, custId);
                
                int orderResult = orderStmt.executeUpdate();
                System.out.println("Order inserted with STATUS = 'Pending': " + (orderResult > 0 ? "SUCCESS" : "FAILED"));
                
                int orderId = 0;
                ResultSet generatedKeys = orderStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    orderId = generatedKeys.getInt(1);
                    System.out.println("Generated Order ID: " + orderId);
                }
                generatedKeys.close();
                orderStmt.close();
                
                if (orderId > 0) {
                    // Copy cart items to order details (3 columns only)
                    String orderDetailsQuery = "INSERT INTO ORDERDETAILS (ORDER_ID, BOOK_ID, ORDER_QUANTITY) " +
                                               "SELECT ?, cb.BOOK_ID, cb.QUANTITY " +
                                               "FROM CART_BOOK cb " +
                                               "WHERE cb.CART_ID = ?";
                    
                    PreparedStatement detailsStmt = conn.prepareStatement(orderDetailsQuery);
                    detailsStmt.setInt(1, orderId);
                    detailsStmt.setInt(2, cartId);
                    int detailsResult = detailsStmt.executeUpdate();
                    System.out.println("Order details inserted: " + detailsResult + " items");
                    detailsStmt.close();
                    
                    // Clear cart
                    String clearCartQuery = "DELETE FROM CART_BOOK WHERE CART_ID = ?";
                    PreparedStatement clearStmt = conn.prepareStatement(clearCartQuery);
                    clearStmt.setInt(1, cartId);
                    clearStmt.executeUpdate();
                    clearStmt.close();
                    System.out.println("Cart cleared");
                    
                    conn.close();
                    
                    // Set attributes for success page
                    request.setAttribute("orderId", orderId);
                    request.setAttribute("totalAmount", amount);
                    request.setAttribute("receiptFileName", fileName);
                    request.setAttribute("orderStatus", "Pending");
                    System.out.println("Forwarding to paymentSuccess.jsp");
                    request.getRequestDispatcher("/customer/paymentSuccess.jsp").forward(request, response);
                    
                } else {
                    conn.close();
                    request.setAttribute("error", "Failed to create order. Please try again.");
                    request.setAttribute("totalAmount", amount);
                    request.getRequestDispatcher("/customer/payment.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PaymentServlet POST:");
            e.printStackTrace();
            request.setAttribute("error", "Error processing payment: " + e.getMessage());
            request.getRequestDispatcher("/customer/payment.jsp").forward(request, response);
        }
    }
    
    private int getCartId(int custId, Connection conn) throws SQLException {
        String query = "SELECT CART_ID FROM CART WHERE CUST_ID = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, custId);
        ResultSet rs = stmt.executeQuery();
        
        int cartId = 0;
        if (rs.next()) {
            cartId = rs.getInt("CART_ID");
        }
        
        rs.close();
        stmt.close();
        
        return cartId;
    }
    
    @Override
    public String getServletInfo() {
        return "Payment Processing Servlet - Creates orders with Pending status";
    }
}