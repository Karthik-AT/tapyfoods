package com.tapyfood.dao.impl;

import com.tapyfood.dao.OrderDAO;
import com.tapyfood.model.Order;
import com.tapyfood.model.OrderItem;
import com.tapyfood.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Uses a DB transaction (setAutoCommit false) to ensure both
 * the order header and all order items are inserted atomically.
 */
public class OrderDAOImpl implements OrderDAO {

    @Override
    public int placeOrder(Order order, List<OrderItem> items) {
        String orderSql = "INSERT INTO orders (user_id, total_amount, status, delivery_address) " +
                          "VALUES (?, ?, ?, ?)";
        String itemSql  = "INSERT INTO order_items (order_id, menu_id, quantity, price) " +
                          "VALUES (?, ?, ?, ?)";

        Connection con = null;
        PreparedStatement orderPs = null;
        PreparedStatement itemPs  = null;
        int generatedOrderId = -1;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            orderPs = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderPs.setInt(1, order.getUserId());
            orderPs.setDouble(2, order.getTotalAmount());
            orderPs.setString(3, "Placed");
            orderPs.setString(4, order.getDeliveryAddress());
            orderPs.executeUpdate();

            ResultSet keys = orderPs.getGeneratedKeys();
            if (keys.next()) {
                generatedOrderId = keys.getInt(1);
            }
            keys.close();

            itemPs = con.prepareStatement(itemSql);
            for (OrderItem item : items) {
                itemPs.setInt(1, generatedOrderId);
                itemPs.setInt(2, item.getMenuId());
                itemPs.setInt(3, item.getQuantity());
                itemPs.setDouble(4, item.getPrice());
                itemPs.addBatch();
            }
            itemPs.executeBatch();

            con.commit();
            return generatedOrderId;

        } catch (SQLException e) {
            System.err.println("[OrderDAO] placeOrder() failed: " + e.getMessage());
            try { if (con != null) con.rollback(); } catch (SQLException ignored) {}
            return -1;
        } finally {
            try { if (orderPs != null) orderPs.close(); } catch (SQLException ignored) {}
            try { if (itemPs  != null) itemPs.close();  } catch (SQLException ignored) {}
            try { if (con     != null) { con.setAutoCommit(true); con.close(); } } catch (SQLException ignored) {}
        }
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT id, user_id, total_amount, status, delivery_address, created_at " +
                     "FROM orders WHERE user_id = ? ORDER BY created_at DESC";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs  = ps.executeQuery();

            while (rs.next()) {
                Order o = mapOrderRow(rs);
                o.setItems(getItemsForOrder(con, o.getId()));
                orders.add(o);
            }
        } catch (SQLException e) {
            System.err.println("[OrderDAO] getOrdersByUserId() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }

        return orders;
    }

    @Override
    public Order getOrderById(int orderId) {
        String sql = "SELECT id, user_id, total_amount, status, delivery_address, created_at " +
                     "FROM orders WHERE id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Order order = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs  = ps.executeQuery();

            if (rs.next()) {
                order = mapOrderRow(rs);
                order.setItems(getItemsForOrder(con, orderId));
            }
        } catch (SQLException e) {
            System.err.println("[OrderDAO] getOrderById() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }

        return order;
    }

    // Reuses the same connection to avoid opening a second one per order
    private List<OrderItem> getItemsForOrder(Connection con, int orderId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.id, oi.order_id, oi.menu_id, oi.quantity, oi.price, m.name " +
                     "FROM order_items oi " +
                     "JOIN menu m ON oi.menu_id = m.id " +
                     "WHERE oi.order_id = ?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, orderId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            OrderItem item = new OrderItem(
                rs.getInt("id"),
                rs.getInt("order_id"),
                rs.getInt("menu_id"),
                rs.getInt("quantity"),
                rs.getDouble("price")
            );
            item.setMenuItemName(rs.getString("name"));
            items.add(item);
        }

        rs.close();
        ps.close();
        return items;
    }

    private Order mapOrderRow(ResultSet rs) throws SQLException {
        return new Order(
            rs.getInt("id"),
            rs.getInt("user_id"),
            rs.getDouble("total_amount"),
            rs.getString("status"),
            rs.getString("delivery_address"),
            rs.getTimestamp("created_at")
        );
    }

    private void close(ResultSet rs, Statement ps, Connection con) {
        try { if (rs  != null) rs.close();  } catch (SQLException ignored) {}
        try { if (ps  != null) ps.close();  } catch (SQLException ignored) {}
        try { if (con != null) con.close(); } catch (SQLException ignored) {}
    }

    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[OrderDAO] updateOrderStatus() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }
}