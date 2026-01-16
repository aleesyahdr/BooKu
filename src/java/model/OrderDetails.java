package model;

public class OrderDetails 
{
    private int order_id;
    private int book_id;
    private int od_quantity;

    public OrderDetails(int order_id, int book_id, int od_quantity) 
    {
        this.order_id = order_id;
        this.book_id = book_id;
        this.od_quantity = od_quantity;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public int getOd_quantity() {
        return od_quantity;
    }

    public void setOd_quantity(int od_quantity) {
        this.od_quantity = od_quantity;
    }
}
