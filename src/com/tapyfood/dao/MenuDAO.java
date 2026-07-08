package com.tapyfood.dao;

import com.tapyfood.model.MenuItem;
import java.util.List;

public interface MenuDAO {

    List<MenuItem> getMenuByRestaurantId(int restaurantId);

    MenuItem getMenuItemById(int menuItemId);

    boolean addMenuItem(MenuItem item);

    boolean updateMenuItem(MenuItem item);

    boolean deleteMenuItem(int id);
}