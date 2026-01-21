package dao;

import util.DBConnection;
import model.Employee;
import java.sql.*;

public class EmpLoginDao {
    
    public int authenticateUserAndGetId(Employee emp) {
        String username = emp.getEmp_username();
        String password = emp.getEmp_password();
        
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            con = DBConnection.createConnection();
            // Matching your DB table name "EMPLOYEES"
            String query = "SELECT EMP_ID FROM EMPLOYEES WHERE EMP_USERNAME = ? AND EMP_PASSWORD = ?";
            statement = con.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("EMP_ID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (con != null) con.close();
            } catch (SQLException e) {}
        }
        return -1;
    }
}