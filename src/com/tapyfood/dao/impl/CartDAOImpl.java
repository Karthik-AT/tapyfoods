package com.tapyfood.dao.impl;

import com.tapyfood.dao.CartDAO;
import com.tapyfood.model.CartItem;
import com.tapyfood.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {

    @Override
    public boolean addToCart(int userId, int menuId, int quantity) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            int newRestaurantId = -1;
            String sqlNew = "SELECT restaurant_id FROM menu WHERE id = ?";
            ps = con.prepareStatement(sqlNew);
            ps.setInt(1, menuId);
            rs = ps.executeQuery();
            if (rs.next()) {
                newRestaurantId = rs.getInt("restaurant_id");
            }
            rs.close();
            ps.close();

            int existingRestaurantId = -1;
            String sqlExist = "SELECT DISTINCT m.restaurant_id FROM cart c " +
                              "JOIN menu m ON c.menu_id = m.id " +
                              "WHERE c.user_id = ? LIMIT 1";
            ps = con.prepareStatement(sqlExist);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                existingRestaurantId = rs.getInt("restaurant_id");
            }
            rs.close();
            ps.close();

            // 3. If they are different, clear the cart first!
            if (existingRestaurantId != -1 && existingRestaurantId != newRestaurantId) {
                String sqlClear = "DELETE FROM cart WHERE user_id = ?";
                ps = con.prepareStatement(sqlClear);
                ps.setInt(1, userId);
                ps.executeUpdate();
                ps.close();
            }

            // 4. Insert or update the new item
            String sql = "INSERT INTO cart (user_id, menu_id, quantity) VALUES (?, ?, ?) " +
                         "ON DUPLICATE KEY UPDATE quantity = quantity + ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, menuId);
            ps.setInt(3, quantity);
            ps.setInt(4, quantity);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[CartDAO] addToCart() failed: " + e.getMessage());
            return false;
        } finally {
            close(rs, ps, con);
        }
    }

    @Override
    public List<CartItem> getCartByUserId(int userId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT c.id, c.user_id, c.menu_id, c.quantity, " +
                     "m.name, m.price, m.image_url, m.is_veg " +
                     "FROM cart c JOIN menu m ON c.menu_id = m.id " +
                     "WHERE c.user_id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs  = ps.executeQuery();

            while (rs.next()) {
                list.add(new CartItem(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getInt("menu_id"),
                    rs.getInt("quantity"),
                    rs.getString("name"),
                    rs.getDouble("price"),
                    rs.getString("image_url"),
                    rs.getBoolean("is_veg")
                ));
            }
        } catch (SQLException e) {
            System.err.println("[CartDAO] getCartByUserId() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }

        return list;
    }

    @Override
    public boolean updateQuantity(int cartId, int quantity) {
        if (quantity <= 0) return removeItem(cartId);

        String sql = "UPDATE cart SET quantity = ? WHERE id = ?";
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CartDAO] updateQuantity() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }

    @Override
    public boolean removeItem(int cartId) {
        String sql = "DELETE FROM cart WHERE id = ?";
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, cartId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CartDAO] removeItem() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }

    @Override
    public boolean clearCart(int userId) {
        String sql = "DELETE FROM cart WHERE user_id = ?";
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("[CartDAO] clearCart() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }

    @Override
    public int getCartCount(int userId) {
        String sql = "SELECT COALESCE(SUM(quantity), 0) FROM cart WHERE user_id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs  = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("[CartDAO] getCartCount() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }
        return 0;
    }

    private void close(ResultSet rs, Statement ps, Connection con) {
        try { if (rs  != null) rs.close();  } catch (SQLException ignored) {}
        try { if (ps  != null) ps.close();  } catch (SQLException ignored) {}
        try { if (con != null) con.close(); } catch (SQLException ignored) {}
    }
}