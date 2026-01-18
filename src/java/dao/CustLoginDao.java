package dao;

import util.DBConnection;
import model.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet; 

public class CustLoginDao 
{  
    public int authenticateUserAndGetId(Customer cust) {
        String username = cust.getCust_username();
        String password = cust.getCust_password();

        Connection con = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            con = DBConnection.createConnection();

            String query = "SELECT CUST_ID FROM CUSTOMER WHERE CUST_USERNAME = ? AND CUST_PASSWORD = ?";
            statement = con.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);

            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("CUST_ID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return -1; // Return -1 if authentication fails
    }
}
