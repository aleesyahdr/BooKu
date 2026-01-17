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
    public String authenticateUser(Customer cust)
    {
        String username = cust.getCust_username();
        String password = cust.getCust_password();

        System.out.println("DEBUG - Attempting login with username: " + username);
        System.out.println("DEBUG - Password length: " + password.length());

        Connection con = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try 
        {
            con = DBConnection.createConnection();
            System.out.println("DEBUG - Database connection established");

            String query = "SELECT CUST_USERNAME, CUST_PASSWORD FROM CUSTOMER WHERE CUST_USERNAME = ? AND CUST_PASSWORD = ?";
            statement = con.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);

            resultSet = statement.executeQuery();

            if (resultSet.next())
            {
                System.out.println("DEBUG - Login SUCCESS!");
                return "SUCCESS";
            }
            else
            {
                System.out.println("DEBUG - No matching user found");
            }
        }
        catch (SQLException e)
        {
            System.out.println("DEBUG - SQL Exception occurred:");
            e.printStackTrace();
        }
        finally
        {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return "Invalid user credentials";
    }
}
