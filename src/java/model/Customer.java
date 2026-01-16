package model;

import java.sql.Date;

public class Customer 
{
    private int cust_id;
    private String cust_username;
    private String cust_password;
    private String cust_firstName;
    private String cust_lastName;
    private String cust_phoneNum;
    private String cust_email;
    private Date cust_dob;
    private String cust_address;
    private String cust_city;
    private String cust_state;
    private String cust_postcode;

    public Customer ()
    {
        cust_id = 0;
        cust_username = "";
        cust_password = "";
        cust_firstName = "";
        cust_lastName = "";
        cust_phoneNum = "";
        cust_email = "";
        cust_dob = null;
        cust_address = "";
        cust_city = "";
        cust_state = "";
        cust_postcode = "";
    }
    
    public Customer(int cust_id, String cust_username, String cust_password, String cust_firstName, String cust_lastName, String cust_phoneNum, String cust_email, Date cust_dob, String cust_address, String cust_city, String cust_state, String cust_postcode) 
    {
        this.cust_id = cust_id;
        this.cust_username = cust_username;
        this.cust_password = cust_password;
        this.cust_firstName = cust_firstName;
        this.cust_lastName = cust_lastName;
        this.cust_phoneNum = cust_phoneNum;
        this.cust_email = cust_email;
        this.cust_dob = cust_dob;
        this.cust_address = cust_address;
        this.cust_city = cust_city;
        this.cust_state = cust_state;
        this.cust_postcode = cust_postcode;
    }

    public int getCust_id() {
        return cust_id;
    }

    public void setCust_id(int cust_id) {
        this.cust_id = cust_id;
    }

    public String getCust_username() {
        return cust_username;
    }

    public void setCust_username(String cust_username) {
        this.cust_username = cust_username;
    }

    public String getCust_password() {
        return cust_password;
    }

    public void setCust_password(String cust_password) {
        this.cust_password = cust_password;
    }

    public String getCust_firstName() {
        return cust_firstName;
    }

    public void setCust_firstName(String cust_firstName) {
        this.cust_firstName = cust_firstName;
    }

    public String getCust_lastName() {
        return cust_lastName;
    }

    public void setCust_lastName(String cust_lastName) {
        this.cust_lastName = cust_lastName;
    }

    public String getCust_phoneNum() {
        return cust_phoneNum;
    }

    public void setCust_phoneNum(String cust_phoneNum) {
        this.cust_phoneNum = cust_phoneNum;
    }

    public String getCust_email() {
        return cust_email;
    }

    public void setCust_email(String cust_email) {
        this.cust_email = cust_email;
    }

    public Date getCust_dob() {
        return cust_dob;
    }

    public void setCust_dob(Date cust_dob) {
        this.cust_dob = cust_dob;
    }

    public String getCust_address() {
        return cust_address;
    }

    public void setCust_address(String cust_address) {
        this.cust_address = cust_address;
    }

    public String getCust_city() {
        return cust_city;
    }

    public void setCust_city(String cust_city) {
        this.cust_city = cust_city;
    }

    public String getCust_state() {
        return cust_state;
    }

    public void setCust_state(String cust_state) {
        this.cust_state = cust_state;
    }

    public String getCust_postcode() {
        return cust_postcode;
    }

    public void setCust_postcode(String cust_postcode) {
        this.cust_postcode = cust_postcode;
    }
}
