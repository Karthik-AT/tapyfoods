package com.tapyfood.dao;

import com.tapyfood.model.Restaurant;
import java.util.List;

public interface RestaurantDAO {

    List<Restaurant> getAllRestaurants();

    Restaurant getRestaurantById(int id);

    Restaurant getRestaurantByOwnerId(int ownerId);

    boolean addRestaurant(Restaurant r);

    boolean updateRestaurant(Restaurant r);

    boolean deleteRestaurant(int id);
}