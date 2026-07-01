package com.tapyfood.model;

public class MenuItem {

    private int     id;
    private int     restaurantId;
    private String  name;
    private String  category;
    private double  price;
    private String  description;
    private String  imageUrl;
    private boolean isVeg;

    public MenuItem() {}

    public MenuItem(int id, int restaurantId, String name, String category,
                    double price, String description, String imageUrl, boolean isVeg) {
        this.id           = id;
        this.restaurantId = restaurantId;
        this.name         = name;
        this.category     = category;
        this.price        = price;
        this.description  = description;
        this.imageUrl     = imageUrl;
        this.isVeg        = isVeg;
    }

    public int    getId()           { return id; }
    public void   setId(int id)     { this.id = id; }

    public int    getRestaurantId()                    { return restaurantId; }
    public void   setRestaurantId(int restaurantId)    { this.restaurantId = restaurantId; }

    public String getName()              { return name; }
    public void   setName(String name)   { this.name = name; }

    public String getCategory()                  { return category; }
    public void   setCategory(String category)   { this.category = category; }

    public double getPrice()               { return price; }
    public void   setPrice(double price)   { this.price = price; }

    public String getDescription()                   { return description; }
    public void   setDescription(String description) { this.description = description; }

    public String getImageUrl()                  { return imageUrl; }
    public void   setImageUrl(String imageUrl)   { this.imageUrl = imageUrl; }

    public boolean isVeg()               { return isVeg; }
    public void    setVeg(boolean isVeg) { this.isVeg = isVeg; }

    @Override
    public String toString() {
        return "MenuItem{id=" + id + ", name='" + name + "', price=" + price + "}";
    }
}