package model;

import java.sql.Date;
import java.sql.Time;

public class Order 
{
    private int order_id;
    private Date order_date;
    private Time order_time;
    private double order_total;
    private String order_status;
    
    //fk
    private int emp_id;
    private int cust_id;

    public Order(int order_id, Date order_date, Time order_time, double order_total,String order_status, int emp_id, int cust_id) 
    {
        this.order_id = order_id;
        this.order_date = order_date;
        this.order_time = order_time;
        this.order_total = order_total;
        this.order_status = order_status;
        this.emp_id = emp_id;
        this.cust_id = cust_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public Time getOrder_time() {
        return order_time;
    }

    public void setOrder_time(Time order_time) {
        this.order_time = order_time;
    }

    public double getOrder_total() {
        return order_total;
    }

    public void setOrder_total(double order_total) {
        this.order_total = order_total;
    }

    public int getEmp_id() {
        return emp_id;
    }

    public void setEmp_id(int emp_id) {
        this.emp_id = emp_id;
    }

    public int getCust_id() {
        return cust_id;
    }

    public void setCust_id(int cust_id) {
        this.cust_id = cust_id;
    }
    
    public String getOrder_status() {
        return order_status;
    }
    public void setOrder_status(String order_status) {
        this.order_status = order_status;
    }
}
