package com.tapyfood.dao;

import com.tapyfood.model.Restaurant;
import java.util.List;

public interface RestaurantDAO {

    List<Restaurant> getAllRestaurants();

    Restaurant getRestaurantById(int id);
}