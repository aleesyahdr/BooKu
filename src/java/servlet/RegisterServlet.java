package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import dao.CustomerDao;
import java.sql.Date;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String email = request.getParameter("email");
        String phoneNum = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postcode = request.getParameter("postcode");
        String dobStr = request.getParameter("birthday");
        
        System.out.println("RegisterServlet: Attempting to register user: " + username);
        
        try {
            // Convert date string to SQL Date
            Date dob = null;
            if (dobStr != null && !dobStr.isEmpty()) {
                dob = Date.valueOf(dobStr); // Expects format: yyyy-MM-dd
            }
            
            // Create Customer object
            Customer customer = new Customer();
            customer.setCust_username(username);
            customer.setCust_password(password);
            customer.setCust_firstName(firstName);
            customer.setCust_lastName(lastName);
            customer.setCust_email(email);
            customer.setCust_phoneNum(phoneNum);
            customer.setCust_address(address);
            customer.setCust_city(city);
            customer.setCust_state(state);
            customer.setCust_postcode(postcode);
            customer.setCust_dob(dob);
            
            // Save to database
            CustomerDao customerDao = new CustomerDao();
            boolean isRegistered = customerDao.registerCustomer(customer);
            
            if (isRegistered) {
                System.out.println("Registration successful for: " + username);
                
                // Set success message
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Registration successful! Please login.");
                
                // Redirect to login page
                response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            } else {
                System.out.println("Registration failed for: " + username);
                
                // Set error message
                request.setAttribute("errorMessage", "Registration failed. Username might already exist.");
                request.getRequestDispatcher("/customer/register.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("Error in RegisterServlet:");
            e.printStackTrace();
            
            request.setAttribute("errorMessage", "An error occurred during registration. Please try again.");
            request.getRequestDispatcher("/customer/register.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to register page
        response.sendRedirect(request.getContextPath() + "/customer/register.jsp");
    }
    
    @Override
    public String getServletInfo() {
        return "Customer Registration Servlet";
    }
}