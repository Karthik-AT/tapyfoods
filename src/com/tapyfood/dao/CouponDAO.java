package com.tapyfood.dao;

import com.tapyfood.model.Coupon;
import java.util.List;

public interface CouponDAO {
    boolean addCoupon(Coupon c);
    boolean updateCoupon(Coupon c);
    boolean deleteCoupon(int id);
    Coupon getCouponById(int id);
    Coupon getCouponByCode(String code);
    List<Coupon> getAllCoupons();
    List<Coupon> getCouponsByRestaurantId(Integer restaurantId);
    List<Coupon> getAvailableCouponsForCart(int userId);
    int getCouponUsageCount(int userId, String couponCode);
}
