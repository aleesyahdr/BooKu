/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package filter;

/**
 *
 * @author user
 */
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        // Get the requested URI
        String requestURI = httpRequest.getRequestURI();
        
        // Check if user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("custId") != null);
        
        System.out.println("AuthFilter: Checking access to " + requestURI);
        System.out.println("AuthFilter: User logged in? " + isLoggedIn);
        
        if (!isLoggedIn) {
            // User is not logged in, redirect to login page
            System.out.println("AuthFilter: Redirecting to login page");
            
            // Store the original request URL so we can redirect back after login
            session = httpRequest.getSession(true); // Create session if doesn't exist
            session.setAttribute("redirectAfterLogin", requestURI);
            
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/customer/login.jsp");
        } else {
            // User is logged in, allow the request to proceed
            chain.doFilter(request, response);
        }
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
