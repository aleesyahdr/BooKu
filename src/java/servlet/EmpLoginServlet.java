package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Employee;
import dao.EmpLoginDao;

@WebServlet(name = "EmpLoginServlet", urlPatterns = {"/EmpLoginServlet"})
public class EmpLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Employee emp = new Employee();
        emp.setEmp_username(username);
        emp.setEmp_password(password);
        
        EmpLoginDao empLoginDao = new EmpLoginDao();
        int empId = empLoginDao.authenticateUserAndGetId(emp);
        
        if (empId != -1) {
            HttpSession session = request.getSession();
            session.setAttribute("empId", empId);
            session.setAttribute("empUsername", username);

            // CHANGED: Table name changed to EMPLOYEES to match your DAO
            try (java.sql.Connection conn = util.DBConnection.createConnection()) {
                String query = "SELECT EMP_FNAME FROM EMPLOYEES WHERE EMP_ID = ?"; 
                java.sql.PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, empId);
                java.sql.ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    // This sets the name that your sidebar is looking for
                    session.setAttribute("empFirstName", rs.getString("EMP_FNAME"));
                }
            } catch (java.sql.SQLException e) {
                e.printStackTrace();
            }

            response.sendRedirect(request.getContextPath() + "/EmpHomeServlet");
        

        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/employees/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate();
            response.sendRedirect(request.getContextPath() + "/employees/index.jsp");
        }
    }
}