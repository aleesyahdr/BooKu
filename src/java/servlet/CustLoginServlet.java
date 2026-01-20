package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;  // ← ADD THIS IMPORT
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import dao.CustLoginDao;

@WebServlet(name = "CustLoginServlet", urlPatterns = {"/CustLoginServlet"})  // ← ADD THIS ANNOTATION
public class CustLoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        System.out.println("CustLoginServlet: Attempting login for username: " + username);
        
        Customer cust = new Customer();
        cust.setCust_username(username);
        cust.setCust_password(password);
        
        CustLoginDao custLoginDao = new CustLoginDao();
        
        // Get customer ID from DAO
        int custId = custLoginDao.authenticateUserAndGetId(cust);
        
        if (custId != -1) {  // Changed from > 0 to match your DAO's return value
            // Login successful
            System.out.println("Login successful for: " + username + " (ID: " + custId + ")");
            
            // Create session and store user info
            HttpSession session = request.getSession();
            session.setAttribute("custId", custId);
            session.setAttribute("username", username);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            System.out.println("Session created: custId=" + custId + ", username=" + username);
            
            // Check if there's a redirect URL stored
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            
            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                // Remove the redirect URL from session
                session.removeAttribute("redirectAfterLogin");
                System.out.println("Redirecting to original page: " + redirectUrl);
                response.sendRedirect(redirectUrl);
            } else {
                // No redirect URL, go to home page
                System.out.println("Redirecting to index page");
                response.sendRedirect(request.getContextPath() + "/IndexServlet");
            }
            
        } else {
            // Login failed
            System.out.println("Login failed: Invalid credentials for " + username);
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/customer/login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            // Logout
            HttpSession session = request.getSession(false);
            if (session != null) {
                String username = (String) session.getAttribute("username");
                System.out.println("Logging out user: " + username);
                session.invalidate(); // Destroy the session
            }
            
            System.out.println("Redirecting to login page after logout");
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        } else {
            // If no action, redirect to login page
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Customer Login Servlet";
    }
}