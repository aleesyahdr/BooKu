package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Book;
import util.DBConnection;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Paths;


@MultipartConfig(
    maxFileSize = 16177215,      // 15MB
    maxRequestSize = 20971520,   // 20MB
    fileSizeThreshold = 5242880  // 5MB
)
public class EmpAddBookServlet extends HttpServlet 
{
    private Connection getConnection() {
        return DBConnection.createConnection();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(request.getContextPath() + "/employees/addBook.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        // Set encoding for proper character handling
        request.setCharacterEncoding("UTF-8");
        
        // Get form parameters
        String bookName = request.getParameter("bookName");
        String bookAuthor = request.getParameter("bookAuthor");
        String bookDescription = request.getParameter("bookDescription");
        String bookPublishDateStr = request.getParameter("bookPublishDate");
        String bookPriceStr = request.getParameter("bookPrice");
        String bookCategory = request.getParameter("bookCategory");
        boolean availability = request.getParameter("availability").equals("1");
        
        // Get the uploaded image file
        Part filePart = request.getPart("bookImage");
        String bookImage = null;

        if (filePart != null && filePart.getSize() > 0) {

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
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // Validate required fields
            if (isNullOrEmpty(bookName) || isNullOrEmpty(bookAuthor) || 
                isNullOrEmpty(bookDescription) || isNullOrEmpty(bookPublishDateStr) ||
                isNullOrEmpty(bookPriceStr) || isNullOrEmpty(bookCategory)) {
                
                response.sendRedirect(request.getContextPath() + 
                    "/employees/addBook.jsp?status=error&message=All fields are required");
                return;
            }
            
            // Parse and validate price
            double bookPrice;
            try {
                bookPrice = Double.parseDouble(bookPriceStr);
                if (bookPrice < 0) {
                    throw new NumberFormatException("Price cannot be negative");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + 
                    "/employees/addBook.jsp?status=error&message=Invalid price format");
                return;
            }
            
            // Parse date
            Date bookPublishDate;
            try {
                bookPublishDate = Date.valueOf(bookPublishDateStr);
            } catch (IllegalArgumentException e) {
                response.sendRedirect(request.getContextPath() + 
                    "/employees/addBook.jsp?status=error&message=Invalid date format");
                return;
            }
            
            // Get database connection
            conn = getConnection();
            
            if (conn == null) {
                response.sendRedirect(request.getContextPath() + 
                    "/employees/addBook.jsp?status=error&message=Database connection failed");
                return;
            }
            
            // Prepare SQL statement
            String sql = "INSERT INTO BOOK (BOOK_NAME, BOOK_AUTHOR, BOOK_DESCRIPTION, " +
                        "BOOK_PUBLISHDATE, BOOK_PRICE, BOOK_CATEGORY, BOOK_IMG, BOOK_AVAILABLE) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, bookName.trim());
            pstmt.setString(2, bookAuthor.trim());
            pstmt.setString(3, bookDescription.trim());
            pstmt.setDate(4, bookPublishDate);
            pstmt.setDouble(5, bookPrice);
            pstmt.setString(6, bookCategory);
            
            // Set the image
            if (bookImage != null) {
                pstmt.setString(7, bookImage);
            } else {
                pstmt.setNull(7, java.sql.Types.VARCHAR);
            }

            String availParam = request.getParameter("availability");
            if (availParam != null && (availParam.equals("1") || availParam.equalsIgnoreCase("true"))) {
                availability = true;
            }

            pstmt.setBoolean(8, availability);
            
            // Execute the insert
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Success - redirect to manage books page
                response.sendRedirect(request.getContextPath() + 
                    "/employees/EmpBookServlet?status=success&message=Book added successfully");
            } else {
                response.sendRedirect(request.getContextPath() + 
                    "/employees/addBook.jsp?status=error&message=Failed to add book");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            String errorMsg = "Database error: " + e.getMessage();
            
            // Check for specific SQL errors
            if (e.getSQLState() != null) {
                if (e.getSQLState().startsWith("23")) {
                    errorMsg = "Database constraint violation. Please check your input.";
                }
            }
            
            response.sendRedirect(request.getContextPath() + 
                "/employees/addBook.jsp?status=error&message=" + 
                java.net.URLEncoder.encode(errorMsg, "UTF-8"));
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + 
                "/employees/addBook.jsp?status=error&message=" + 
                java.net.URLEncoder.encode("Error: " + e.getMessage(), "UTF-8"));
            
        } finally {
            // Close resources
            try {
                /*if (bookImageInputStream != null) {
                    bookImageInputStream.close();
                }*/
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for adding new books to the database";
    }// </editor-fold>

}
