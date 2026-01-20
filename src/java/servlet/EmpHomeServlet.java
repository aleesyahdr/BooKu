package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import util.DBConnection;

@WebServlet(name = "EmpHomeServlet", urlPatterns = {"/EmpHomeServlet"})
public class EmpHomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("empUsername") == null) {
            response.sendRedirect(request.getContextPath() + "/employees/index.jsp");
            return;
        }

        // Initialize variables
        int totalBooks = 0;
        double totalSales = 0.0;
        int newOrders = 0;

        try (Connection con = DBConnection.createConnection()) {
    if (con != null) {
        // 1. Total Books - Derby is usually case-sensitive if quotes are used, 
        // but by default, it expects UPPERCASE.
        try (Statement st1 = con.createStatement();
             ResultSet rs1 = st1.executeQuery("SELECT COUNT(*) FROM BOOK")) {
            if (rs1.next()) totalBooks = rs1.getInt(1);
        }

        // 2. Total Sales - Derby Reserved Word fix: Use "ORDERS" in quotes 
        // and ensure the column name is exactly as created (usually ORDER_TOTAL)
        try (Statement st2 = con.createStatement();
             ResultSet rs2 = st2.executeQuery("SELECT SUM(ORDER_TOTAL) FROM \"ORDERS\"")) {
            if (rs2.next()) totalSales = rs2.getDouble(1);
        }

        // 3. Pending Orders
        try (Statement st3 = con.createStatement();
             ResultSet rs3 = st3.executeQuery("SELECT COUNT(*) FROM \"ORDERS\" WHERE ORDER_STATUS = 'Pending'")) {
            if (rs3.next()) newOrders = rs3.getInt(1);
        }
    }
} catch (SQLException e) {
    // This will print the exact Derby error to your GlassFish console
    System.out.println("Derby SQL Error: " + e.getMessage());
    e.printStackTrace();
}

        // Pass data to JSP
        request.setAttribute("totalBooks", totalBooks);
        request.setAttribute("totalSales", totalSales);
        request.setAttribute("newOrders", newOrders);

        request.getRequestDispatcher("/employees/home.jsp").forward(request, response);
    }
}