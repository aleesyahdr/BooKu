package servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.Book;
import util.DBConnection;

public class EmpBookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Book> bookList = new ArrayList<>();

        try (Connection conn = DBConnection.createConnection()) {

            String sql = "SELECT * FROM BOOK ORDER BY BOOK_ID DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bookList.add(new Book(
                    rs.getInt("BOOK_ID"),
                    rs.getString("BOOK_NAME"),
                    rs.getString("BOOK_AUTHOR"),
                    rs.getString("BOOK_DESCRIPTION"),
                    rs.getDate("BOOK_PUBLISHDATE"),
                    rs.getDouble("BOOK_PRICE"),
                    rs.getString("BOOK_CATEGORY"),
                    rs.getString("BOOK_IMG")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("bookList", bookList);
        request.getRequestDispatcher("employee/books.jsp")
               .forward(request, response);
    }
}
