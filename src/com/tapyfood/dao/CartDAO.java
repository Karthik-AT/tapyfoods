package com.tapyfood.dao;

import com.tapyfood.model.CartItem;
import java.util.List;

public interface CartDAO {

    /**
     * Adds a menu item to the cart, or increments quantity if already present.
     * Uses INSERT ... ON DUPLICATE KEY UPDATE for atomicity.
     */
    boolean addToCart(int userId, int menuId, int quantity);

    
    List<CartItem> getCartByUserId(int userId);

    boolean updateQuantity(int cartId, int quantity);

    boolean removeItem(int cartId);

    /**
     * Deletes all cart items for a user (called after successful order placement).
     */
    boolean clearCart(int userId);

    
    int getCartCount(int userId);
}