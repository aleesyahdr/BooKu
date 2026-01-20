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

@WebServlet(name = "ShoppingCartServlet", urlPatterns = {"/ShoppingCartServlet"})
public class ShoppingCartServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer custId = (Integer) session.getAttribute("custId");
        
        // Check if user is logged in
        if (custId == null) {
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            return;
        }
        
        System.out.println("ShoppingCartServlet: Loading cart for customer ID: " + custId);
        
        // Get cart items from database
        List<Cart> cartItems = getCartItems(custId);
        
        // Set cart items as request attribute
        request.setAttribute("cartItems", cartItems);
        
        System.out.println("ShoppingCartServlet: Found " + cartItems.size() + " items in cart");
        
        // Forward to cart.jsp
        request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer custId = (Integer) session.getAttribute("custId");
        
        // Check if user is logged in
        if (custId == null) {
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "view";
        }
        
        System.out.println("ShoppingCartServlet POST: Action = " + action);
        
        switch (action) {
            case "add":
                addToCart(request, response, custId);
                break;
            case "update":
                updateCartItem(request, response, custId);
                break;
            case "remove":
                removeFromCart(request, response, custId);
                break;
            case "clear":
                clearCart(request, response, custId);
                break;
            default:
                doGet(request, response);
                break;
        }
    }
    
    private List<Cart> getCartItems(int custId) {
        List<Cart> cartItems = new ArrayList<>();
        Connection conn = DBConnection.createConnection();
        
        if (conn != null) {
            try {
                int cartId = getOrCreateCart(custId, conn);
                
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
                conn.close();
                
            } catch (SQLException e) {
                System.err.println("Error getting cart items:");
                e.printStackTrace();
            }
        }
        
        return cartItems;
    }
    
    private int getOrCreateCart(int custId, Connection conn) throws SQLException {
        String checkQuery = "SELECT CART_ID FROM CART WHERE CUST_ID = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
        checkStmt.setInt(1, custId);
        ResultSet rs = checkStmt.executeQuery();
        
        if (rs.next()) {
            int cartId = rs.getInt("CART_ID");
            rs.close();
            checkStmt.close();
            return cartId;
        }
        
        rs.close();
        checkStmt.close();
        
        String insertQuery = "INSERT INTO CART (CUST_ID) VALUES (?)";
        PreparedStatement insertStmt = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
        insertStmt.setInt(1, custId);
        insertStmt.executeUpdate();
        
        ResultSet generatedKeys = insertStmt.getGeneratedKeys();
        int cartId = 0;
        if (generatedKeys.next()) {
            cartId = generatedKeys.getInt(1);
        }
        
        generatedKeys.close();
        insertStmt.close();
        
        System.out.println("Created new cart with ID: " + cartId + " for customer: " + custId);
        return cartId;
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response, int custId)
            throws ServletException, IOException {
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = 1;
            
            if (request.getParameter("quantity") != null) {
                quantity = Integer.parseInt(request.getParameter("quantity"));
            }
            
            System.out.println("Adding to cart: BookID=" + bookId + ", Quantity=" + quantity);
            
            Connection conn = DBConnection.createConnection();
            
            if (conn != null) {
                int cartId = getOrCreateCart(custId, conn);
                
                String checkQuery = "SELECT QUANTITY FROM CART_BOOK WHERE CART_ID = ? AND BOOK_ID = ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                checkStmt.setInt(1, cartId);
                checkStmt.setInt(2, bookId);
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next()) {
                    int existingQty = rs.getInt("QUANTITY");
                    int newQty = existingQty + quantity;
                    
                    String updateQuery = "UPDATE CART_BOOK SET QUANTITY = ? WHERE CART_ID = ? AND BOOK_ID = ?";
                    PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                    updateStmt.setInt(1, newQty);
                    updateStmt.setInt(2, cartId);
                    updateStmt.setInt(3, bookId);
                    updateStmt.executeUpdate();
                    updateStmt.close();
                    
                    System.out.println("Updated quantity to: " + newQty);
                } else {
                    String insertQuery = "INSERT INTO CART_BOOK (CART_ID, BOOK_ID, QUANTITY) VALUES (?, ?, ?)";
                    PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                    insertStmt.setInt(1, cartId);
                    insertStmt.setInt(2, bookId);
                    insertStmt.setInt(3, quantity);
                    insertStmt.executeUpdate();
                    insertStmt.close();
                    
                    System.out.println("Added new item to cart");
                }
                
                rs.close();
                checkStmt.close();
                conn.close();
            }
            
            response.sendRedirect(request.getContextPath() + "/ShoppingCartServlet");
            
        } catch (NumberFormatException | SQLException e) {
            System.err.println("Error adding to cart:");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/BooksServlet");
        }
    }
    
    private void updateCartItem(HttpServletRequest request, HttpServletResponse response, int custId)
            throws ServletException, IOException {
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            System.out.println("Updating cart: BookID=" + bookId + ", New Quantity=" + quantity);
            
            Connection conn = DBConnection.createConnection();
            
            if (conn != null) {
                int cartId = getOrCreateCart(custId, conn);
                
                if (quantity > 0) {
                    String updateQuery = "UPDATE CART_BOOK SET QUANTITY = ? WHERE CART_ID = ? AND BOOK_ID = ?";
                    PreparedStatement stmt = conn.prepareStatement(updateQuery);
                    stmt.setInt(1, quantity);
                    stmt.setInt(2, cartId);
                    stmt.setInt(3, bookId);
                    stmt.executeUpdate();
                    stmt.close();
                } else {
                    String deleteQuery = "DELETE FROM CART_BOOK WHERE CART_ID = ? AND BOOK_ID = ?";
                    PreparedStatement stmt = conn.prepareStatement(deleteQuery);
                    stmt.setInt(1, cartId);
                    stmt.setInt(2, bookId);
                    stmt.executeUpdate();
                    stmt.close();
                }
                
                conn.close();
            }
            
            response.sendRedirect(request.getContextPath() + "/ShoppingCartServlet");
            
        } catch (NumberFormatException | SQLException e) {
            System.err.println("Error updating cart:");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ShoppingCartServlet");
        }
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, int custId)
            throws ServletException, IOException {
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            
            System.out.println("Removing from cart: BookID=" + bookId);
            
            Connection conn = DBConnection.createConnection();
            
            if (conn != null) {
                int cartId = getOrCreateCart(custId, conn);
                
                String deleteQuery = "DELETE FROM CART_BOOK WHERE CART_ID = ? AND BOOK_ID = ?";
                PreparedStatement stmt = conn.prepareStatement(deleteQuery);
                stmt.setInt(1, cartId);
                stmt.setInt(2, bookId);
                stmt.executeUpdate();
                stmt.close();
                conn.close();
            }
            
            response.sendRedirect(request.getContextPath() + "/ShoppingCartServlet");
            
        } catch (NumberFormatException | SQLException e) {
            System.err.println("Error removing from cart:");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ShoppingCartServlet");
        }
    }
    
    private void clearCart(HttpServletRequest request, HttpServletResponse response, int custId)
            throws ServletException, IOException {
        
        Connection conn = DBConnection.createConnection();
        
        if (conn != null) {
            try {
                int cartId = getOrCreateCart(custId, conn);
                
                String deleteQuery = "DELETE FROM CART_BOOK WHERE CART_ID = ?";
                PreparedStatement stmt = conn.prepareStatement(deleteQuery);
                stmt.setInt(1, cartId);
                stmt.executeUpdate();
                stmt.close();
                conn.close();
                
                System.out.println("Cleared cart for customer: " + custId);
                
            } catch (SQLException e) {
                System.err.println("Error clearing cart:");
                e.printStackTrace();
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/ShoppingCartServlet");
    }
    
    @Override
    public String getServletInfo() {
        return "Shopping Cart Management Servlet";
    }
}