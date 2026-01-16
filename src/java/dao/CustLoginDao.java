package dao;

import util.DBConnection;
import model.Customer;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet; 

public class CustLoginDao 
{  
    public String authenticateUser (Customer cust)
    {
        String username = cust.getCust_username();
        String password = cust.getCust_password();
        
        Connection con = null;
        Statement statement = null;
        ResultSet resultSet = null;
        String usernameDB = "";
        String passwordDB = "";
        
        try 
        {
            con = DBConnection.createConnection();
            statement = con.createStatement();
            resultSet = statement.executeQuery("select username,password from users");
            
            while (resultSet.next())
            {
                usernameDB = resultSet.getString ("username");
                passwordDB = resultSet.getString ("password");
                
                if (username.equals(usernameDB) && password.equals(passwordDB))
                {
                    return "SUCCESS";
                }
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        
        return "Invalid user credentials";
    }
}
