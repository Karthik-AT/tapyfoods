package com.tapyfood.dao.impl;

import com.tapyfood.dao.MenuDAO;
import com.tapyfood.model.MenuItem;
import com.tapyfood.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {

    @Override
    public List<MenuItem> getMenuByRestaurantId(int restaurantId) {
        List<MenuItem> list = new ArrayList<>();
        String sql = "SELECT id, restaurant_id, name, category, price, " +
                     "description, image_url, is_veg " +
                     "FROM menu WHERE restaurant_id = ? " +
                     "ORDER BY FIELD(category,'Starters','Mains','Desserts','Drinks'), name";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, restaurantId);
            rs  = ps.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("[MenuDAO] getMenuByRestaurantId() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }

        return list;
    }

    @Override
    public MenuItem getMenuItemById(int menuItemId) {
        String sql = "SELECT id, restaurant_id, name, category, price, " +
                     "description, image_url, is_veg FROM menu WHERE id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        MenuItem item = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, menuItemId);
            rs  = ps.executeQuery();

            if (rs.next()) {
                item = mapRow(rs);
            }
        } catch (SQLException e) {
            System.err.println("[MenuDAO] getMenuItemById() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }

        return item;
    }

    private MenuItem mapRow(ResultSet rs) throws SQLException {
        return new MenuItem(
            rs.getInt("id"),
            rs.getInt("restaurant_id"),
            rs.getString("name"),
            rs.getString("category"),
            rs.getDouble("price"),
            rs.getString("description"),
            rs.getString("image_url"),
            rs.getBoolean("is_veg")
        );
    }

    private void close(ResultSet rs, Statement ps, Connection con) {
        try { if (rs  != null) rs.close();  } catch (SQLException ignored) {}
        try { if (ps  != null) ps.close();  } catch (SQLException ignored) {}
        try { if (con != null) con.close(); } catch (SQLException ignored) {}
    }

    @Override
    public boolean addMenuItem(MenuItem item) {
        String sql = "INSERT INTO menu (restaurant_id, name, category, price, description, image_url, is_veg) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, item.getRestaurantId());
            ps.setString(2, item.getName());
            ps.setString(3, item.getCategory());
            ps.setDouble(4, item.getPrice());
            ps.setString(5, item.getDescription());
            ps.setString(6, item.getImageUrl());
            ps.setBoolean(7, item.isVeg());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[MenuDAO] addMenuItem() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }

    @Override
    public boolean updateMenuItem(MenuItem item) {
        String sql = "UPDATE menu SET name = ?, category = ?, price = ?, description = ?, image_url = ?, is_veg = ? " +
                     "WHERE id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setString(1, item.getName());
            ps.setString(2, item.getCategory());
            ps.setDouble(3, item.getPrice());
            ps.setString(4, item.getDescription());
            ps.setString(5, item.getImageUrl());
            ps.setBoolean(6, item.isVeg());
            ps.setInt(7, item.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[MenuDAO] updateMenuItem() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }

    @Override
    public boolean deleteMenuItem(int id) {
        String sql = "DELETE FROM menu WHERE id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[MenuDAO] deleteMenuItem() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }
}