package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Employee;
import util.DBConnection;

@WebServlet(name = "EmpProfileServlet", urlPatterns = {"/EmpProfileServlet"})
public class EmpProfileServlet extends HttpServlet {
    
   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    HttpSession session = request.getSession();
    Integer empId = (Integer) session.getAttribute("empId");
    
    if (empId == null) {
        response.sendRedirect(request.getContextPath() + "/employees/index.jsp");
        return;
    }
    
    Employee employee = null; // Initialize
    
    try (Connection conn = DBConnection.createConnection()) {
        // NOTE: Make sure this table name matches your DB (EMPLOYEES or EMPLOYEE)
        String query = "SELECT * FROM EMPLOYEES WHERE EMP_ID = ?"; 
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, empId);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            employee = new Employee(
                rs.getInt("EMP_ID"),
                rs.getString("EMP_USERNAME"),
                rs.getString("EMP_PASSWORD"),
                rs.getString("EMP_FNAME"),
                rs.getString("EMP_LNAME"),
                rs.getString("EMP_PHONENUM"),
                rs.getString("EMP_EMAIL"),
                rs.getString("EMP_ADDRESS"),
                rs.getString("EMP_CITY"),
                rs.getString("EMP_STATE"),
                rs.getString("EMP_POSTCODE"),
                rs.getDate("EMP_DOB")
            );
            session.setAttribute("empFirstName", rs.getString("EMP_FNAME"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // If for some reason DB failed, create an empty object to prevent the redirect loop
    if (employee == null) {
        employee = new Employee(); 
    }

    request.setAttribute("employee", employee);
    request.getRequestDispatcher("/employees/profile.jsp").forward(request, response);
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer empId = (Integer) session.getAttribute("empId");
        
        if (empId == null) {
            response.sendRedirect(request.getContextPath() + "/employees/index.jsp");
            return;
        }

        // Capture Form Data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNum = request.getParameter("phoneNum");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postcode = request.getParameter("postcode");
        String dob = request.getParameter("dob");
        
        try (Connection conn = DBConnection.createConnection()) {
            String query = "UPDATE EMPLOYEES SET EMP_FNAME=?, EMP_LNAME=?, EMP_PHONENUM=?, EMP_EMAIL=?, EMP_ADDRESS=?, EMP_CITY=?, EMP_STATE=?, EMP_POSTCODE=?, EMP_DOB=? WHERE EMP_ID=?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, phoneNum);
            pstmt.setString(4, email);
            pstmt.setString(5, address);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, postcode);
            pstmt.setDate(9, (dob != null && !dob.isEmpty()) ? Date.valueOf(dob) : null);
            pstmt.setInt(10, empId);
            
            if (pstmt.executeUpdate() > 0) {
                // IMPORTANT: We use the 'firstName' variable here, NOT 'rs'
                session.setAttribute("empFirstName", firstName); 
                request.setAttribute("successMessage", "Profile updated successfully!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
        }
        
        // Refresh the data after update
        doGet(request, response);
    }
}