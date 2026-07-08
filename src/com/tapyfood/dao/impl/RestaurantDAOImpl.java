package com.tapyfood.dao.impl;

import com.tapyfood.dao.RestaurantDAO;
import com.tapyfood.model.Restaurant;
import com.tapyfood.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> list = new ArrayList<>();
        String sql = "SELECT id, name, cuisine_type, rating, delivery_time, " +
                     "location, image_url, offer_badge, description, owner_id, is_active " +
                     "FROM restaurant ORDER BY rating DESC";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            rs  = ps.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("[RestaurantDAO] getAllRestaurants() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }

        return list;
    }

    @Override
    public Restaurant getRestaurantById(int id) {
        String sql = "SELECT id, name, cuisine_type, rating, delivery_time, " +
                     "location, image_url, offer_badge, description, owner_id, is_active " +
                     "FROM restaurant WHERE id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Restaurant restaurant = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs  = ps.executeQuery();

            if (rs.next()) {
                restaurant = mapRow(rs);
            }
        } catch (SQLException e) {
            System.err.println("[RestaurantDAO] getRestaurantById() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }

        return restaurant;
    }

    private Restaurant mapRow(ResultSet rs) throws SQLException {
        int ownerIdVal = rs.getInt("owner_id");
        Integer ownerId = rs.wasNull() ? null : ownerIdVal;
        return new Restaurant(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("cuisine_type"),
            rs.getDouble("rating"),
            rs.getString("delivery_time"),
            rs.getString("location"),
            rs.getString("image_url"),
            rs.getString("offer_badge"),
            rs.getString("description"),
            ownerId,
            rs.getBoolean("is_active")
        );
    }

    private void close(ResultSet rs, Statement ps, Connection con) {
        try { if (rs  != null) rs.close();  } catch (SQLException ignored) {}
        try { if (ps  != null) ps.close();  } catch (SQLException ignored) {}
        try { if (con != null) con.close(); } catch (SQLException ignored) {}
    }

    @Override
    public Restaurant getRestaurantByOwnerId(int ownerId) {
        String sql = "SELECT id, name, cuisine_type, rating, delivery_time, " +
                     "location, image_url, offer_badge, description, owner_id, is_active " +
                     "FROM restaurant WHERE owner_id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Restaurant restaurant = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, ownerId);
            rs  = ps.executeQuery();
            if (rs.next()) {
                restaurant = mapRow(rs);
            }
        } catch (SQLException e) {
            System.err.println("[RestaurantDAO] getRestaurantByOwnerId() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }
        return restaurant;
    }

    @Override
    public boolean addRestaurant(Restaurant r) {
        String sql = "INSERT INTO restaurant (name, cuisine_type, rating, delivery_time, location, image_url, offer_badge, description, owner_id, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setString(1, r.getName());
            ps.setString(2, r.getCuisineType());
            ps.setDouble(3, r.getRating());
            ps.setString(4, r.getDeliveryTime());
            ps.setString(5, r.getLocation());
            ps.setString(6, r.getImageUrl());
            ps.setString(7, r.getOfferBadge());
            ps.setString(8, r.getDescription());
            if (r.getOwnerId() != null) {
                ps.setInt(9, r.getOwnerId());
            } else {
                ps.setNull(9, java.sql.Types.INTEGER);
            }
            ps.setBoolean(10, r.isActive());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[RestaurantDAO] addRestaurant() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }

    @Override
    public boolean updateRestaurant(Restaurant r) {
        String sql = "UPDATE restaurant SET name = ?, cuisine_type = ?, rating = ?, delivery_time = ?, location = ?, image_url = ?, offer_badge = ?, description = ?, owner_id = ?, is_active = ? " +
                     "WHERE id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setString(1, r.getName());
            ps.setString(2, r.getCuisineType());
            ps.setDouble(3, r.getRating());
            ps.setString(4, r.getDeliveryTime());
            ps.setString(5, r.getLocation());
            ps.setString(6, r.getImageUrl());
            ps.setString(7, r.getOfferBadge());
            ps.setString(8, r.getDescription());
            if (r.getOwnerId() != null) {
                ps.setInt(9, r.getOwnerId());
            } else {
                ps.setNull(9, java.sql.Types.INTEGER);
            }
            ps.setBoolean(10, r.isActive());
            ps.setInt(11, r.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[RestaurantDAO] updateRestaurant() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }

    @Override
    public boolean deleteRestaurant(int id) {
        String sql = "DELETE FROM restaurant WHERE id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[RestaurantDAO] deleteRestaurant() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }
}