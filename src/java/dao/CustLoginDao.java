package dao;

import util.DBConnection;
import model.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet; 

public class CustLoginDao {
    
    /**
     * Authenticates user and returns customer ID if valid, -1 if invalid
     */
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
    
    /**
     * Get full customer details by ID
     */
    public Customer getCustomerById(int custId) {
        Customer customer = null;
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            con = DBConnection.createConnection();
            String query = "SELECT * FROM CUSTOMER WHERE CUST_ID = ?";
            statement = con.prepareStatement(query);
            statement.setInt(1, custId);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                customer = new Customer();
                customer.setCust_id(resultSet.getInt("CUST_ID"));
                customer.setCust_username(resultSet.getString("CUST_USERNAME"));
                customer.setCust_firstName(resultSet.getString("CUST_FIRSTNAME"));
                customer.setCust_lastName(resultSet.getString("CUST_LASTNAME"));
                customer.setCust_phoneNum(resultSet.getString("CUST_PHONENUM"));
                customer.setCust_email(resultSet.getString("CUST_EMAIL"));
                customer.setCust_dob(resultSet.getDate("CUST_DOB"));
                customer.setCust_address(resultSet.getString("CUST_ADDRESS"));
                customer.setCust_city(resultSet.getString("CUST_CITY"));
                customer.setCust_state(resultSet.getString("CUST_STATE"));
                customer.setCust_postcode(resultSet.getString("CUST_POSTCODE"));
                // Don't set password for security
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
        
        return customer;
    }
    
    /**
     * Authenticate and get full customer details in one call
     */
    public Customer authenticateAndGetCustomer(Customer cust) {
        Customer customer = null;
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            con = DBConnection.createConnection();
            String query = "SELECT * FROM CUSTOMER WHERE CUST_USERNAME = ? AND CUST_PASSWORD = ?";
            statement = con.prepareStatement(query);
            statement.setString(1, cust.getCust_username());
            statement.setString(2, cust.getCust_password());
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                customer = new Customer();
                customer.setCust_id(resultSet.getInt("CUST_ID"));
                customer.setCust_username(resultSet.getString("CUST_USERNAME"));
                customer.setCust_firstName(resultSet.getString("CUST_FIRSTNAME"));
                customer.setCust_lastName(resultSet.getString("CUST_LASTNAME"));
                customer.setCust_phoneNum(resultSet.getString("CUST_PHONENUM"));
                customer.setCust_email(resultSet.getString("CUST_EMAIL"));
                customer.setCust_dob(resultSet.getDate("CUST_DOB"));
                customer.setCust_address(resultSet.getString("CUST_ADDRESS"));
                customer.setCust_city(resultSet.getString("CUST_CITY"));
                customer.setCust_state(resultSet.getString("CUST_STATE"));
                customer.setCust_postcode(resultSet.getString("CUST_POSTCODE"));
                // Don't set password for security
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
        
        return customer;
    }
}