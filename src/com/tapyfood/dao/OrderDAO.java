package com.tapyfood.dao;

import com.tapyfood.model.Order;
import com.tapyfood.model.OrderItem;
import java.util.List;

public interface OrderDAO {

    
    int placeOrder(Order order, List<OrderItem> items);

    List<Order> getOrdersByUserId(int userId);

    Order getOrderById(int orderId);

    boolean updateOrderStatus(int orderId, String status);
}