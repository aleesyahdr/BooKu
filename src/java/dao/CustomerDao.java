/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author user
 */
package dao;

import util.DBConnection;
import model.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class CustomerDao {
    
    /**
     * Register a new customer
     * Returns true if successful, false if failed
     */
    public boolean registerCustomer(Customer customer) {
        Connection con = null;
        PreparedStatement statement = null;
        
        try {
            con = DBConnection.createConnection();
            
            // Check if username already exists
            String checkQuery = "SELECT CUST_ID FROM CUSTOMER WHERE CUST_USERNAME = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setString(1, customer.getCust_username());
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                // Username already exists
                System.out.println("Username already exists: " + customer.getCust_username());
                rs.close();
                checkStmt.close();
                return false;
            }
            
            rs.close();
            checkStmt.close();
            
            // Insert new customer
            String insertQuery = "INSERT INTO CUSTOMER (CUST_USERNAME, CUST_PASSWORD, CUST_FIRSTNAME, CUST_LASTNAME, " +
                                "CUST_PHONENUM, CUST_EMAIL, CUST_DOB, CUST_ADDRESS, CUST_CITY, CUST_STATE, CUST_POSTCODE) " +
                                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            statement = con.prepareStatement(insertQuery);
            statement.setString(1, customer.getCust_username());
            statement.setString(2, customer.getCust_password());
            statement.setString(3, customer.getCust_firstName());
            statement.setString(4, customer.getCust_lastName());
            statement.setString(5, customer.getCust_phoneNum());
            statement.setString(6, customer.getCust_email());
            statement.setDate(7, customer.getCust_dob());
            statement.setString(8, customer.getCust_address());
            statement.setString(9, customer.getCust_city());
            statement.setString(10, customer.getCust_state());
            statement.setString(11, customer.getCust_postcode());
            
            int rowsInserted = statement.executeUpdate();
            
            if (rowsInserted > 0) {
                System.out.println("Customer registered successfully: " + customer.getCust_username());
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("Error registering customer:");
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return false;
    }
    
    /**
     * Check if username already exists
     */
    public boolean usernameExists(String username) {
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            con = DBConnection.createConnection();
            String query = "SELECT CUST_ID FROM CUSTOMER WHERE CUST_USERNAME = ?";
            statement = con.prepareStatement(query);
            statement.setString(1, username);
            resultSet = statement.executeQuery();
            
            return resultSet.next(); // Returns true if username exists
            
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
        
        return false;
    }
}