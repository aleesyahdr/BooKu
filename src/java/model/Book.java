package model;

import java.sql.Date;

public class Book 
{
    private int book_id;
    private String book_name;
    private String book_author;
    private String book_description;
    private Date book_publishDate;
    private double book_price;
    private String book_category;
    private String book_img;  

    public Book(int book_id, String book_name, String book_author, String book_description, Date book_publishDate, double book_price,String book_category, String book_img) 
    {
        this.book_id = book_id;
        this.book_name = book_name;
        this.book_author = book_author;
        this.book_description = book_description;
        this.book_publishDate = book_publishDate;
        this.book_price = book_price;
        this.book_category = book_category;
        this.book_img = book_img;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public String getBook_name() {
        return book_name;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public String getBook_author() {
        return book_author;
    }

    public void setBook_author(String book_author) {
        this.book_author = book_author;
    }

    public String getBook_description() {
        return book_description;
    }

    public void setBook_description(String book_description) {
        this.book_description = book_description;
    }

    public Date getBook_publishDate() {
        return book_publishDate;
    }

    public void setBook_publishDate(Date book_publishDate) {
        this.book_publishDate = book_publishDate;
    }

    public double getBook_price() {
        return book_price;
    }

    public void setBook_price(double book_price) {
        this.book_price = book_price;
    } 
    
    public String getBook_category() {
        return book_category;
    }
    
    public void setBook_category(String book_category) {
        this.book_category = book_category;
    }
    
    public String getBook_img() {
        return book_img;
    }
    
    public void setBook_img(String book_img) {
        this.book_img = book_img;
    }
}
