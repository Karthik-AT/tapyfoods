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
                     "location, image_url, offer_badge, description " +
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
                     "location, image_url, offer_badge, description " +
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
        return new Restaurant(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("cuisine_type"),
            rs.getDouble("rating"),
            rs.getString("delivery_time"),
            rs.getString("location"),
            rs.getString("image_url"),
            rs.getString("offer_badge"),
            rs.getString("description")
        );
    }

    private void close(ResultSet rs, Statement ps, Connection con) {
        try { if (rs  != null) rs.close();  } catch (SQLException ignored) {}
        try { if (ps  != null) ps.close();  } catch (SQLException ignored) {}
        try { if (con != null) con.close(); } catch (SQLException ignored) {}
    }
}