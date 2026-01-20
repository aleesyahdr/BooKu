package servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Employee;
import model.Customer;
import util.DBConnection;

public class manageUserServlet extends HttpServlet 
{
    private Connection getConnection() {
        return DBConnection.createConnection();
    }
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet manageUserServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet manageUserServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        // Load all users for display
        List<Employee> employees = getAllEmployees();
        List<Customer> customers = getAllCustomers();

        // Debug output - check your server console/logs
        System.out.println("=== DEBUG INFO ===");
        System.out.println("Employees loaded: " + employees.size());
        System.out.println("Customers loaded: " + customers.size());
        if (employees.size() > 0) {
            System.out.println("First employee: " + employees.get(0).getEmp_username());
        }
        System.out.println("==================");

        request.setAttribute("employees", employees);
        request.setAttribute("customers", customers);

        request.getRequestDispatcher("/admin/manageUser.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        String action = request.getParameter("action");
        String userType = request.getParameter("userType");
        
        try {
            switch (action) {
                case "add":
                    addUser(request, userType);
                    request.setAttribute("message", "User added successfully!");
                    break;
                    
                case "edit":
                    updateUser(request, userType);
                    request.setAttribute("message", "User updated successfully!");
                    break;
                    
                case "delete":
                    deleteUser(request, userType);
                    request.setAttribute("message", "User deleted successfully!");
                    break;
                    
                default:
                    request.setAttribute("error", "Invalid action!");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Reload data and forward back to JSP
        doGet(request, response);
    }
    
    private List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<Employee>();
        String sql = "SELECT * FROM EMPLOYEES WHERE IS_DELETED = 0 ORDER BY EMP_ID"; 
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            if (conn != null) {
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    Employee emp = new Employee(
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
                    employees.add(emp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return employees;
    }
    
    // Get all customers from database
    private List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<Customer>();
        String sql = "SELECT * FROM customer WHERE is_deleted = 0 ORDER BY cust_id";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);
                
                while (rs.next()) {
                    Customer cust = new Customer(
                        rs.getInt("cust_id"),
                        rs.getString("cust_username"),
                        rs.getString("cust_password"),
                        rs.getString("cust_firstName"),
                        rs.getString("cust_lastName"),
                        rs.getString("cust_phoneNum"),
                        rs.getString("cust_email"),
                        rs.getDate("cust_dob"),
                        rs.getString("cust_address"),
                        rs.getString("cust_city"),
                        rs.getString("cust_state"),
                        rs.getString("cust_postcode")
                    );
                    customers.add(cust);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return customers;
    }
    
    // Add new user to database
    private void addUser(HttpServletRequest request, String userType) throws SQLException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNum = request.getParameter("phoneNum");
        String email = request.getParameter("email");
        Date dob = Date.valueOf(request.getParameter("dob"));
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postcode = request.getParameter("postcode");
        
        String sql;
        if ("employee".equals(userType)) {
            sql = "INSERT INTO EMPLOYEES (EMP_USERNAME, EMP_PASSWORD, EMP_FNAME, " +
                  "EMP_LNAME, EMP_PHONENUM, EMP_EMAIL, EMP_DOB, EMP_ADDRESS, " +
                  "EMP_CITY, EMP_STATE, EMP_POSTCODE, IS_DELETED) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
        } else {
            sql = "INSERT INTO customer (cust_username, cust_password, cust_firstName, " +
                  "cust_lastName, cust_phoneNum, cust_email, cust_dob, cust_address, " +
                  "cust_city, cust_state, cust_postcode, is_deleted) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                pstmt.setString(3, firstName);
                pstmt.setString(4, lastName);
                pstmt.setString(5, phoneNum);
                pstmt.setString(6, email);
                pstmt.setDate(7, dob);
                pstmt.setString(8, address);
                pstmt.setString(9, city);
                pstmt.setString(10, state);
                pstmt.setString(11, postcode);
                
                pstmt.executeUpdate();
            }
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
    
    // Update existing user in database
    private void updateUser(HttpServletRequest request, String userType) throws SQLException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNum = request.getParameter("phoneNum");
        String email = request.getParameter("email");
        Date dob = Date.valueOf(request.getParameter("dob"));
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postcode = request.getParameter("postcode");
        
        String sql;
        if ("employee".equals(userType)) {
            sql = "UPDATE employees SET emp_username = ?, emp_password = ?, " +
                  "emp_fName = ?, emp_lName = ?, emp_phoneNum = ?, emp_email = ?, " +
                  "emp_dob = ?, emp_address = ?, emp_city = ?, emp_state = ?, " +
                  "emp_postcode = ? WHERE emp_id = ?";
        } else {
            sql = "UPDATE customer SET cust_username = ?, cust_password = ?, " +
                  "cust_firstName = ?, cust_lastName = ?, cust_phoneNum = ?, cust_email = ?, " +
                  "cust_dob = ?, cust_address = ?, cust_city = ?, cust_state = ?, " +
                  "cust_postcode = ? WHERE cust_id = ?";
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                pstmt.setString(3, firstName);
                pstmt.setString(4, lastName);
                pstmt.setString(5, phoneNum);
                pstmt.setString(6, email);
                pstmt.setDate(7, dob);
                pstmt.setString(8, address);
                pstmt.setString(9, city);
                pstmt.setString(10, state);
                pstmt.setString(11, postcode);
                pstmt.setInt(12, userId);
                
                pstmt.executeUpdate();
            }
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
    
    // Delete user from database
    private void deleteUser(HttpServletRequest request, String userType) throws SQLException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        
        String sql;
        if ("employee".equals(userType)) {
            // Set IS_DELETED = 1 and DELETED_DATE = current timestamp
            sql = "UPDATE EMPLOYEES SET IS_DELETED = 1, DELETED_DATE = CURRENT_TIMESTAMP WHERE EMP_ID = ?";
        } else {
            sql = "UPDATE customer SET is_deleted = 1, deleted_date = CURRENT_TIMESTAMP WHERE cust_id = ?";
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, userId);
                pstmt.executeUpdate();
            }
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
    
    

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
