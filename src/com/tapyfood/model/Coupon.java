package com.tapyfood.model;

import java.sql.Timestamp;

public class Coupon {
    private int id;
    private String code;
    private String discountType; // "percentage" or "flat"
    private double discountValue;
    private Integer restaurantId; // null for global
    private Timestamp startTime;
    private Timestamp endTime;
    private double minOrderAmount;
    private boolean active;

    public Coupon() {}

    public Coupon(int id, String code, String discountType, double discountValue,
                  Integer restaurantId, Timestamp startTime, Timestamp endTime,
                  double minOrderAmount, boolean active) {
        this.id = id;
        this.code = code;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.restaurantId = restaurantId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.minOrderAmount = minOrderAmount;
        this.active = active;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }

    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }

    public Integer getRestaurantId() { return restaurantId; }
    public void setRestaurantId(Integer restaurantId) { this.restaurantId = restaurantId; }

    public Timestamp getStartTime() { return startTime; }
    public void setStartTime(Timestamp startTime) { this.startTime = startTime; }

    public Timestamp getEndTime() { return endTime; }
    public void setEndTime(Timestamp endTime) { this.endTime = endTime; }

    public double getMinOrderAmount() { return minOrderAmount; }
    public void setMinOrderAmount(double minOrderAmount) { this.minOrderAmount = minOrderAmount; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    @Override
    public String toString() {
        return "Coupon{id=" + id + ", code='" + code + "', type='" + discountType + "', value=" + discountValue + "}";
    }
}
