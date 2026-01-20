package servlet;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.DBConnection;

public class PaymentServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("cust_Id") == null) {
            System.out.println("PaymentServlet: User not logged in, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            return;
        }
        
        int customerId = (int) session.getAttribute("cust_Id");
        double totalAmount = 100.00; // Default amount - you can calculate from cart
        
        System.out.println("PaymentServlet GET: Customer ID = " + customerId);
        System.out.println("PaymentServlet GET: Total Amount = " + totalAmount);
        
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("/customer/payment.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("cust_Id") == null) {
            System.out.println("PaymentServlet POST: User not logged in");
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            return;
        }
        
        try {
            int customerId = (int) session.getAttribute("cust_Id");
            double amount = Double.parseDouble(request.getParameter("amount"));
            
            System.out.println("PaymentServlet POST: Processing payment");
            System.out.println("Customer ID: " + customerId);
            System.out.println("Amount: " + amount);
            
            Connection conn = DBConnection.createConnection();
            
            if (conn != null) {
                // Insert order
                String query = "INSERT INTO ORDERS (ORDER_DATE, ORDER_TIME, ORDER_TOTAL, CUST_ID) VALUES (CURRENT_DATE, CURRENT_TIME, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setDouble(1, amount);
                stmt.setInt(2, customerId);
                
                int result = stmt.executeUpdate();
                System.out.println("Order inserted: " + (result > 0 ? "SUCCESS" : "FAILED"));
                
                stmt.close();
                conn.close();
                
                if (result > 0) {
                    request.setAttribute("totalAmount", amount);
                    System.out.println("Forwarding to paymentSuccess.jsp");
                    request.getRequestDispatcher("/customer/paymentSuccess.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Payment failed. Please try again.");
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
}