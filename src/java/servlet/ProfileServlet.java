package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import util.DBConnection;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/ProfileServlet"})
public class ProfileServlet extends HttpServlet {
    
    // GET - Load customer profile
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer custId = (Integer) session.getAttribute("custId");
        
        if (custId == null) {
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            return;
        }
        
        Connection conn = DBConnection.createConnection();
        
        if (conn != null) {
            try {
                String query = "SELECT * FROM CUSTOMER WHERE CUST_ID = ?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, custId);
                ResultSet rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    Customer customer = new Customer(
                        rs.getInt("CUST_ID"),
                        rs.getString("CUST_USERNAME"),
                        rs.getString("CUST_PASSWORD"),
                        rs.getString("CUST_FIRSTNAME"),
                        rs.getString("CUST_LASTNAME"),
                        rs.getString("CUST_PHONENUM"),
                        rs.getString("CUST_EMAIL"),
                        rs.getDate("CUST_DOB"),
                        rs.getString("CUST_ADDRESS"),
                        rs.getString("CUST_CITY"),
                        rs.getString("CUST_STATE"),
                        rs.getString("CUST_POSTCODE")
                    );
                    request.setAttribute("customer", customer);
                }
                
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
    }
    
    // POST - Update customer profile
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer custId = (Integer) session.getAttribute("custId");
        
        if (custId == null) {
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            return;
        }
        
        // Get form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNum = request.getParameter("phoneNum");
        String email = request.getParameter("email");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postcode = request.getParameter("postcode");
        
        Connection conn = DBConnection.createConnection();
        
        if (conn != null) {
            try {
                String query = "UPDATE CUSTOMER SET CUST_FIRSTNAME = ?, CUST_LASTNAME = ?, " +
                               "CUST_PHONENUM = ?, CUST_EMAIL = ?, CUST_DOB = ?, " +
                               "CUST_ADDRESS = ?, CUST_CITY = ?, CUST_STATE = ?, CUST_POSTCODE = ? " +
                               "WHERE CUST_ID = ?";
                
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, firstName);
                pstmt.setString(2, lastName);
                pstmt.setString(3, phoneNum);
                pstmt.setString(4, email);
                pstmt.setDate(5, dob != null && !dob.isEmpty() ? Date.valueOf(dob) : null);
                pstmt.setString(6, address);
                pstmt.setString(7, city);
                pstmt.setString(8, state);
                pstmt.setString(9, postcode);
                pstmt.setInt(10, custId);
                
                int rowsUpdated = pstmt.executeUpdate();
                
                if (rowsUpdated > 0) {
                    // Update session attributes
                    session.setAttribute("firstName", firstName);
                    session.setAttribute("lastName", lastName);
                    request.setAttribute("successMessage", "Profile updated successfully!");
                } else {
                    request.setAttribute("errorMessage", "Failed to update profile.");
                }
                
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            }
        }
        
        // Reload profile page with updated data
        doGet(request, response);
    }
}