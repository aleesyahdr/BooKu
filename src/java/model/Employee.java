package model;

import java.sql.Date;

public class Employee 
{
    private int emp_id;
    private String emp_username;
    private String emp_password;
    private String emp_firstName;
    private String emp_lastName;
    private String emp_phoneNum;
    private String emp_email;
    private String emp_address;
    private String emp_city;
    private String emp_state;
    private String emp_postcode;
    private Date emp_dob;
    
    public Employee ()
    {
        emp_id = 0;
        emp_username = "";
        emp_password = "";
        emp_firstName = "";
        emp_lastName = "";
        emp_phoneNum = "";
        emp_email = "";
        emp_address = "";
        emp_city = "";
        emp_state = "";
        emp_postcode = "";
        emp_dob = null;
    }

    public Employee(int emp_id, String emp_username, String emp_password, String emp_firstName, String emp_lastName, String emp_phoneNum, String emp_email, String emp_address, String emp_city, String emp_state, String emp_postcode, Date emp_dob) 
    {
        this.emp_id = emp_id;
        this.emp_username = emp_username;
        this.emp_password = emp_password;
        this.emp_firstName = emp_firstName;
        this.emp_lastName = emp_lastName;
        this.emp_phoneNum = emp_phoneNum;
        this.emp_email = emp_email;
        this.emp_address = emp_address;
        this.emp_city = emp_city;
        this.emp_state = emp_state;
        this.emp_postcode = emp_postcode;
        this.emp_dob = emp_dob;
    }

    public int getEmp_id() {
        return emp_id;
    }

    public void setEmp_id(int emp_id) {
        this.emp_id = emp_id;
    }

    public String getEmp_username() {
        return emp_username;
    }

    public void setEmp_username(String emp_username) {
        this.emp_username = emp_username;
    }

    public String getEmp_password() {
        return emp_password;
    }

    public void setEmp_password(String emp_password) {
        this.emp_password = emp_password;
    }

    public String getEmp_firstName() {
        return emp_firstName;
    }

    public void setEmp_firstName(String emp_firstName) {
        this.emp_firstName = emp_firstName;
    }

    public String getEmp_lastName() {
        return emp_lastName;
    }

    public void setEmp_lastName(String emp_lastName) {
        this.emp_lastName = emp_lastName;
    }

    public String getEmp_phoneNum() {
        return emp_phoneNum;
    }

    public void setEmp_phoneNum(String emp_phoneNum) {
        this.emp_phoneNum = emp_phoneNum;
    }

    public String getEmp_email() {
        return emp_email;
    }

    public void setEmp_email(String emp_email) {
        this.emp_email = emp_email;
    }

    public String getEmp_address() {
        return emp_address;
    }

    public void setEmp_address(String emp_address) {
        this.emp_address = emp_address;
    }

    public String getEmp_city() {
        return emp_city;
    }

    public void setEmp_city(String emp_city) {
        this.emp_city = emp_city;
    }

    public String getEmp_state() {
        return emp_state;
    }

    public void setEmp_state(String emp_state) {
        this.emp_state = emp_state;
    }

    public String getEmp_postcode() {
        return emp_postcode;
    }

    public void setEmp_postcode(String emp_postcode) {
        this.emp_postcode = emp_postcode;
    }
    
    public Date getEmp_dob ()
    {
        return emp_dob;
    }
    
    public void setEmp_dob (Date emp_dob)
    {
        this.emp_dob = emp_dob;
    }
}
