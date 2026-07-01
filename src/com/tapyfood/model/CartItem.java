package com.tapyfood.model;

public class CartItem {

    private int    id;
    private int    userId;
    private int    menuId;
    private int    quantity;

    // Joined from menu table (for display)
    private String name;
    private double price;
    private String imageUrl;
    private boolean isVeg;

    public CartItem() {}

    public CartItem(int id, int userId, int menuId, int quantity,
                    String name, double price, String imageUrl, boolean isVeg) {
        this.id       = id;
        this.userId   = userId;
        this.menuId   = menuId;
        this.quantity = quantity;
        this.name     = name;
        this.price    = price;
        this.imageUrl = imageUrl;
        this.isVeg    = isVeg;
    }

    public int    getId()           { return id; }
    public void   setId(int id)     { this.id = id; }

    public int    getUserId()              { return userId; }
    public void   setUserId(int userId)    { this.userId = userId; }

    public int    getMenuId()              { return menuId; }
    public void   setMenuId(int menuId)    { this.menuId = menuId; }

    public int    getQuantity()                { return quantity; }
    public void   setQuantity(int quantity)    { this.quantity = quantity; }

    public String getName()              { return name; }
    public void   setName(String name)   { this.name = name; }

    public double getPrice()               { return price; }
    public void   setPrice(double price)   { this.price = price; }

    public String getImageUrl()                  { return imageUrl; }
    public void   setImageUrl(String imageUrl)   { this.imageUrl = imageUrl; }

    public boolean isVeg()               { return isVeg; }
    public void    setVeg(boolean isVeg) { this.isVeg = isVeg; }

    public double getSubtotal() { return quantity * price; }
}