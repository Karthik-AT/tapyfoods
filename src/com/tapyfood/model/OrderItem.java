package com.tapyfood.model;

public class OrderItem {

    private int    id;
    private int    orderId;
    private int    menuId;
    private int    quantity;
    private double price;

    // Not a DB column — populated via JOIN for display purposes
    private String menuItemName;

    public OrderItem() {}

    public OrderItem(int id, int orderId, int menuId, int quantity, double price) {
        this.id       = id;
        this.orderId  = orderId;
        this.menuId   = menuId;
        this.quantity = quantity;
        this.price    = price;
    }

    public int    getId()           { return id; }
    public void   setId(int id)     { this.id = id; }

    public int    getOrderId()               { return orderId; }
    public void   setOrderId(int orderId)    { this.orderId = orderId; }

    public int    getMenuId()              { return menuId; }
    public void   setMenuId(int menuId)    { this.menuId = menuId; }

    public int    getQuantity()                { return quantity; }
    public void   setQuantity(int quantity)    { this.quantity = quantity; }

    public double getPrice()               { return price; }
    public void   setPrice(double price)   { this.price = price; }

    public String getMenuItemName()                      { return menuItemName; }
    public void   setMenuItemName(String menuItemName)   { this.menuItemName = menuItemName; }

    public double getSubtotal() { return quantity * price; }
}