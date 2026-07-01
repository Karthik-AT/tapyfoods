package com.tapyfood.model;

public class Restaurant {

    private int    id;
    private String name;
    private String cuisineType;
    private double rating;
    private String deliveryTime;
    private String location;
    private String imageUrl;
    private String offerBadge;
    private String description;

    public Restaurant() {}

    public Restaurant(int id, String name, String cuisineType, double rating,
                      String deliveryTime, String location, String imageUrl,
                      String offerBadge, String description) {
        this.id          = id;
        this.name        = name;
        this.cuisineType = cuisineType;
        this.rating      = rating;
        this.deliveryTime = deliveryTime;
        this.location    = location;
        this.imageUrl    = imageUrl;
        this.offerBadge  = offerBadge;
        this.description = description;
    }

    public int    getId()           { return id; }
    public void   setId(int id)     { this.id = id; }

    public String getName()              { return name; }
    public void   setName(String name)   { this.name = name; }

    public String getCuisineType()                   { return cuisineType; }
    public void   setCuisineType(String cuisineType) { this.cuisineType = cuisineType; }

    public double getRating()              { return rating; }
    public void   setRating(double rating) { this.rating = rating; }

    public String getDeliveryTime()                    { return deliveryTime; }
    public void   setDeliveryTime(String deliveryTime) { this.deliveryTime = deliveryTime; }

    public String getLocation()                  { return location; }
    public void   setLocation(String location)   { this.location = location; }

    public String getImageUrl()                  { return imageUrl; }
    public void   setImageUrl(String imageUrl)   { this.imageUrl = imageUrl; }

    public String getOfferBadge()                    { return offerBadge; }
    public void   setOfferBadge(String offerBadge)   { this.offerBadge = offerBadge; }

    public String getDescription()                   { return description; }
    public void   setDescription(String description) { this.description = description; }

    @Override
    public String toString() {
        return "Restaurant{id=" + id + ", name='" + name + "', cuisine='" + cuisineType + "'}";
    }
}