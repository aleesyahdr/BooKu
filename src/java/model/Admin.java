package model;

import java.sql.Date;

public class Admin 
{
    private int admin_id;
    private String admin_username;
    private String admin_password;
    private String admin_firstName;
    private String admin_lastName;
    private String admin_phoneNum;
    private String admin_email;
    private Date admin_dob;
    private String admin_address;
    private String admin_city;
    private String admin_state;
    private String admin_postcode;

    public Admin ()
    {
        admin_id = 0;
        admin_username = "";
        admin_password = "";
        admin_firstName = "";
        admin_lastName = "";
        admin_phoneNum = "";
        admin_email = "";
        admin_dob = null;
        admin_address = "";
        admin_city = "";
        admin_state = "";
        admin_postcode = "";
    }
    
    public Admin(int admin_id, String admin_username, String admin_password, String admin_firstName, String admin_lastName, String admin_phoneNum, String admin_email, Date admin_dob, String admin_address, String admin_city, String admin_state, String admin_postcode) 
    {
        this.admin_id = admin_id;
        this.admin_username = admin_username;
        this.admin_password = admin_password;
        this.admin_firstName = admin_firstName;
        this.admin_lastName = admin_lastName;
        this.admin_phoneNum = admin_phoneNum;
        this.admin_email = admin_email;
        this.admin_dob = admin_dob;
        this.admin_address = admin_address;
        this.admin_city = admin_city;
        this.admin_state = admin_state;
        this.admin_postcode = admin_postcode;
    }

    public int getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(int admin_id) {
        this.admin_id = admin_id;
    }

    public String getAdmin_username() {
        return admin_username;
    }

    public void setAdmin_username(String admin_username) {
        this.admin_username = admin_username;
    }

    public String getAdmin_password() {
        return admin_password;
    }

    public void setAdmin_password(String admin_password) {
        this.admin_password = admin_password;
    }

    public String getAdmin_firstName() {
        return admin_firstName;
    }

    public void setAdmin_firstName(String admin_firstName) {
        this.admin_firstName = admin_firstName;
    }

    public String getAdmin_lastName() {
        return admin_lastName;
    }

    public void setAdmin_lastName(String admin_lastName) {
        this.admin_lastName = admin_lastName;
    }

    public String getAdmin_phoneNum() {
        return admin_phoneNum;
    }

    public void setAdmin_phoneNum(String admin_phoneNum) {
        this.admin_phoneNum = admin_phoneNum;
    }

    public String getAdmin_email() {
        return admin_email;
    }

    public void setAdmin_email(String admin_email) {
        this.admin_email = admin_email;
    }

    public Date getAdmin_dob() {
        return admin_dob;
    }

    public void setAdmin_dob(Date admin_dob) {
        this.admin_dob = admin_dob;
    }

    public String getAdmin_address() {
        return admin_address;
    }

    public void setAdmin_address(String admin_address) {
        this.admin_address = admin_address;
    }

    public String getAdmin_city() {
        return admin_city;
    }

    public void setAdmin_city(String admin_city) {
        this.admin_city = admin_city;
    }

    public String getAdmin_state() {
        return admin_state;
    }

    public void setAdmin_state(String admin_state) {
        this.admin_state = admin_state;
    }

    public String getAdmin_postcode() {
        return admin_postcode;
    }

    public void setAdmin_postcode(String admin_postcode) {
        this.admin_postcode = admin_postcode;
    }
}
