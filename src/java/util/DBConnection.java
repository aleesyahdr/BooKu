package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection 
{
    private static final String URL = "jdbc:derby://localhost:1527/bookuDB";
    private static final String USER = "app";
    private static final String PASSWORD = "app";
    
    public static Connection createConnection ()
    {
        Connection connection = null;
        
        try
        {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println ("Connection established successfully.");
        }
        catch (ClassNotFoundException e)
        {
            System.err.println ("JDBC Driver not found.");
            e.printStackTrace();
        }
        catch (SQLException e)
        {
            System.err.println ("Failed to establish connection.");
            e.printStackTrace();
        }
        
        return connection;
    }
}

