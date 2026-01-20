package servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import util.DBConnection;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer custId = (Integer) session.getAttribute("custId");
        
        // Check if user is logged in
        if (custId == null) {
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            return;
        }
        
        System.out.println("CheckoutServlet: Processing checkout for customer ID: " + custId);
        
        // Get cart items and calculate total
        List<Cart> cartItems = getCartItems(custId);
        
        if (cartItems.isEmpty()) {
            // Empty cart - redirect back to cart page
            session.setAttribute("errorMessage", "Your cart is empty!");
            response.sendRedirect(request.getContextPath() + "/ShoppingCartServlet");
            return;
        }
        
        // Calculate totals
        double subtotal = 0.0;
        for (Cart item : cartItems) {
            subtotal += item.getSubtotal();
        }
        
        double shipping = 10.00; // Fixed shipping
        double tax = subtotal * 0.06; // 6% tax
        double total = subtotal + shipping + tax;
        
        System.out.println("Checkout Summary - Subtotal: " + subtotal + ", Tax: " + tax + ", Shipping: " + shipping + ", Total: " + total);
        
        // Set attributes for checkout page
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shipping", shipping);
        request.setAttribute("tax", tax);
        request.setAttribute("total", total);
        
        // Forward to checkout page
        request.getRequestDispatcher("/customer/checkout.jsp").forward(request, response);
    }
    
    /**
     * Get cart items for customer
     */
    private List<Cart> getCartItems(int custId) {
        List<Cart> cartItems = new ArrayList<>();
        Connection conn = DBConnection.createConnection();
        
        if (conn != null) {
            try {
                // Get cart ID
                int cartId = getCartId(custId, conn);
                
                if (cartId > 0) {
                    String query = "SELECT cb.BOOK_ID, cb.QUANTITY, b.BOOK_NAME, b.BOOK_AUTHOR, b.BOOK_PRICE " +
                                   "FROM CART_BOOK cb " +
                                   "JOIN BOOK b ON cb.BOOK_ID = b.BOOK_ID " +
                                   "WHERE cb.CART_ID = ?";
                    
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setInt(1, cartId);
                    ResultSet rs = stmt.executeQuery();
                    
                    while (rs.next()) {
                        Cart item = new Cart(
                            rs.getInt("BOOK_ID"),
                            rs.getString("BOOK_NAME"),
                            rs.getString("BOOK_AUTHOR"),
                            rs.getDouble("BOOK_PRICE"),
                            rs.getInt("QUANTITY")
                        );
                        cartItems.add(item);
                    }
                    
                    rs.close();
                    stmt.close();
                }
                
                conn.close();
                
            } catch (SQLException e) {
                System.err.println("Error getting cart items:");
                e.printStackTrace();
            }
        }
        
        return cartItems;
    }
    
    /**
     * Get cart ID for customer
     */
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
        return "Checkout Servlet";
    }
}