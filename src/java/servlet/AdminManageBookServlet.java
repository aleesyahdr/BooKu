package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Book;
import util.DBConnection;

@MultipartConfig(
    maxFileSize = 16177215,      // 15MB
    maxRequestSize = 20971520,   // 20MB
    fileSizeThreshold = 5242880  // 5MB
)
public class AdminManageBookServlet extends HttpServlet 
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
            out.println("<title>Servlet AdminManageBookServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminManageBookServlet at " + request.getContextPath() + "</h1>");
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
        String bookIdParam = request.getParameter("id");
        
        if (bookIdParam == null || bookIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/AdminBookServlet");
            return;
        }
        
        try {
            int bookId = Integer.parseInt(bookIdParam);
            Book book = getBookById(bookId);
            
            if (book == null) {
                request.setAttribute("error", "Book not found!");
                response.sendRedirect(request.getContextPath() + "//AdminBookServlet");
                return;
            }
            
            request.setAttribute("book", book);
            request.getRequestDispatcher("/admin/manageBook.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "//AdminBookServlet");
        }
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
        
        try {
            if ("update".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("book_id"));
                updateBook(request);
                response.sendRedirect(request.getContextPath() + 
                    "/AdminManageBookServlet?id=" + bookId + "&message=Book updated successfully");
                
            } else if ("delete".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("book_id"));
                deleteBook(request);
                response.sendRedirect(request.getContextPath() + 
                        "/AdminBookServlet?id=" + bookId + "&message=Book deleted successfully");
                
            } else {
                response.sendRedirect(request.getContextPath() + "/AdminBookServlet");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            doGet(request, response);
        }
    }

    // Get single book by ID
    private Book getBookById(int bookId) {
        String sql = "SELECT * FROM BOOK WHERE book_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Book book = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, bookId);
                rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    book = new Book(
                        rs.getInt("book_id"),
                        rs.getString("book_name"),
                        rs.getString("book_author"),
                        rs.getString("book_description"),
                        rs.getDate("book_publishDate"),
                        rs.getDouble("book_price"),
                        rs.getString("book_category"),
                        rs.getString("book_img")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Error getting book: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return book;
    }
    
    // Update book
    private void updateBook(HttpServletRequest request) throws SQLException, IOException, ServletException {
        int bookId = Integer.parseInt(request.getParameter("book_id"));
        String name = request.getParameter("book_name");
        String author = request.getParameter("book_author");
        String description = request.getParameter("book_description");
        Date publishDate = Date.valueOf(request.getParameter("book_publishDate"));
        double price = Double.parseDouble(request.getParameter("book_price"));
        String category = request.getParameter("book_category");
        
        // Handle file upload for book image
        String bookImage = null;
        Part filePart = request.getPart("bookImage");
        
        if (filePart != null && filePart.getSize() > 0) {
            // New image uploaded
            String uploadPath = "C:\\Users\\USER\\OneDrive\\Documents\\NetBeansProjects\\BooKu\\web\\img\\books";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fileName = Paths.get(filePart.getSubmittedFileName())
                                   .getFileName().toString();

            File file = new File(uploadPath + File.separator + fileName);

            try (InputStream input = filePart.getInputStream();
                 FileOutputStream output = new FileOutputStream(file)) {

                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }

            bookImage = fileName;
        } else {
            // No new image uploaded, keep the existing one
            Book existingBook = getBookById(bookId);
            if (existingBook != null) {
                bookImage = existingBook.getBook_img();
            }
        }
        
        String sql = "UPDATE BOOK SET book_name = ?, book_author = ?, " +
                     "book_description = ?, book_publishDate = ?, book_price = ?, " +
                     "book_category = ?, book_img = ? WHERE book_id = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setString(2, author);
                pstmt.setString(3, description);
                pstmt.setDate(4, publishDate);
                pstmt.setDouble(5, price);
                pstmt.setString(6, category);
                
                // Set the image
                if (bookImage != null && !bookImage.trim().isEmpty()) {
                    pstmt.setString(7, bookImage);
                } else {
                    pstmt.setNull(7, java.sql.Types.VARCHAR);
                }
                
                pstmt.setInt(8, bookId);
                
                pstmt.executeUpdate();
            }
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
    
    // Delete book
    private void deleteBook(HttpServletRequest request) throws SQLException {
        int bookId = Integer.parseInt(request.getParameter("book_id"));
        
        String sql = "DELETE FROM BOOK WHERE book_id = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, bookId);
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
