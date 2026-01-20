package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import util.DBConnection;

public class EmpAddBookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("employee/addBook.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String bookName = request.getParameter("bookName");
        String bookAuthor = request.getParameter("bookAuthor");
        String bookDescription = request.getParameter("bookDescription");
        String bookCategory = request.getParameter("bookCategory");
        String bookPublishDate = request.getParameter("bookPublishDate");
        String bookImg = request.getParameter("bookImg");
        double bookPrice = Double.parseDouble(request.getParameter("bookPrice"));
        String availability = request.getParameter("bookAvailability");

        int quantity = 0;
        if ("in-stock".equals(availability)) quantity = 10;
        else if ("pre-order".equals(availability)) quantity = -1;

        try (Connection conn = DBConnection.createConnection()) {

            String sql = "INSERT INTO BOOK (BOOK_NAME, BOOK_AUTHOR, BOOK_DESCRIPTION, " +
                         "BOOK_PUBLISHDATE, BOOK_PRICE, BOOK_QUANTITY, BOOK_CATEGORY, BOOK_IMG) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, bookName);
            ps.setString(2, bookAuthor);
            ps.setString(3, bookDescription);
            ps.setDate(4, Date.valueOf(bookPublishDate));
            ps.setDouble(5, bookPrice);
            ps.setInt(6, quantity);
            ps.setString(7, bookCategory);
            ps.setString(8, bookImg);

            ps.executeUpdate();

            session.setAttribute("message", "Book added successfully!");
            session.setAttribute("messageType", "success");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Error: " + e.getMessage());
            session.setAttribute("messageType", "error");
        }

        response.sendRedirect("EmpBookServlet");
    }
}
