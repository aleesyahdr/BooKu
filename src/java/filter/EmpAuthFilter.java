/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author user
 */
package filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/employees/*"})
public class EmpAuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI();
        
        // Let them through if they are at the LOGIN PAGE or the LOGIN SERVLET
        boolean isLoginPage = path.endsWith("index.jsp");
        boolean isLoginServlet = path.contains("EmpLoginServlet");
        boolean isLoggedIn = (session != null && session.getAttribute("empUsername") != null);

        if (isLoggedIn || isLoginPage || isLoginServlet) {
            chain.doFilter(request, response);
        } else {
            // Kick back to login
            res.sendRedirect(req.getContextPath() + "/employees/index.jsp");
        }
    }

    public void init(FilterConfig f) {}
    public void destroy() {}
}