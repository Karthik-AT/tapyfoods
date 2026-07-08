package com.tapyfood.dao.impl;

import com.tapyfood.dao.CouponDAO;
import com.tapyfood.model.Coupon;
import com.tapyfood.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CouponDAOImpl implements CouponDAO {

    @Override
    public boolean addCoupon(Coupon c) {
        String sql = "INSERT INTO coupon (code, discount_type, discount_value, restaurant_id, start_time, end_time, min_order_amount, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setString(1, c.getCode());
            ps.setString(2, c.getDiscountType());
            ps.setDouble(3, c.getDiscountValue());
            if (c.getRestaurantId() != null) {
                ps.setInt(4, c.getRestaurantId());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            ps.setTimestamp(5, c.getStartTime());
            ps.setTimestamp(6, c.getEndTime());
            ps.setDouble(7, c.getMinOrderAmount());
            ps.setBoolean(8, c.isActive());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CouponDAO] addCoupon() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }

    @Override
    public boolean updateCoupon(Coupon c) {
        String sql = "UPDATE coupon SET code = ?, discount_type = ?, discount_value = ?, restaurant_id = ?, start_time = ?, end_time = ?, min_order_amount = ?, is_active = ? WHERE id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setString(1, c.getCode());
            ps.setString(2, c.getDiscountType());
            ps.setDouble(3, c.getDiscountValue());
            if (c.getRestaurantId() != null) {
                ps.setInt(4, c.getRestaurantId());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            ps.setTimestamp(5, c.getStartTime());
            ps.setTimestamp(6, c.getEndTime());
            ps.setDouble(7, c.getMinOrderAmount());
            ps.setBoolean(8, c.isActive());
            ps.setInt(9, c.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CouponDAO] updateCoupon() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }

    @Override
    public boolean deleteCoupon(int id) {
        String sql = "DELETE FROM coupon WHERE id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CouponDAO] deleteCoupon() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }

    @Override
    public Coupon getCouponById(int id) {
        String sql = "SELECT id, code, discount_type, discount_value, restaurant_id, start_time, end_time, min_order_amount, is_active FROM coupon WHERE id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs  = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            System.err.println("[CouponDAO] getCouponById() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }
        return null;
    }

    @Override
    public Coupon getCouponByCode(String code) {
        String sql = "SELECT id, code, discount_type, discount_value, restaurant_id, start_time, end_time, min_order_amount, is_active FROM coupon WHERE code = ?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setString(1, code);
            rs  = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            System.err.println("[CouponDAO] getCouponByCode() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }
        return null;
    }

    @Override
    public List<Coupon> getAllCoupons() {
        List<Coupon> list = new ArrayList<>();
        String sql = "SELECT id, code, discount_type, discount_value, restaurant_id, start_time, end_time, min_order_amount, is_active FROM coupon ORDER BY id DESC";
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
            System.err.println("[CouponDAO] getAllCoupons() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }
        return list;
    }

    @Override
    public List<Coupon> getCouponsByRestaurantId(Integer restaurantId) {
        List<Coupon> list = new ArrayList<>();
        String sql = restaurantId == null
            ? "SELECT id, code, discount_type, discount_value, restaurant_id, start_time, end_time, min_order_amount, is_active FROM coupon WHERE restaurant_id IS NULL ORDER BY id DESC"
            : "SELECT id, code, discount_type, discount_value, restaurant_id, start_time, end_time, min_order_amount, is_active FROM coupon WHERE restaurant_id = ? OR restaurant_id IS NULL ORDER BY id DESC";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            if (restaurantId != null) {
                ps.setInt(1, restaurantId);
            }
            rs  = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("[CouponDAO] getCouponsByRestaurantId() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }
        return list;
    }

    @Override
    public List<Coupon> getAvailableCouponsForCart(int userId) {
        List<Coupon> list = new ArrayList<>();
        String sql = "SELECT * FROM coupon WHERE is_active = 1 AND start_time <= NOW() AND end_time >= NOW() " +
                     "AND (restaurant_id IS NULL OR restaurant_id IN (" +
                     "SELECT DISTINCT m.restaurant_id FROM cart c JOIN menu m ON c.menu_id = m.id WHERE c.user_id = ?" +
                     "))";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs  = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("[CouponDAO] getAvailableCouponsForCart() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }
        return list;
    }

    @Override
    public int getCouponUsageCount(int userId, String couponCode) {
        String sql = "SELECT COUNT(*) FROM orders WHERE user_id = ? AND coupon_code = ?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, couponCode);
            rs  = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("[CouponDAO] getCouponUsageCount failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }
        return 0;
    }

    private Coupon mapRow(ResultSet rs) throws SQLException {
        int rIdVal = rs.getInt("restaurant_id");
        Integer restaurantId = rs.wasNull() ? null : rIdVal;
        return new Coupon(
            rs.getInt("id"),
            rs.getString("code"),
            rs.getString("discount_type"),
            rs.getDouble("discount_value"),
            restaurantId,
            rs.getTimestamp("start_time"),
            rs.getTimestamp("end_time"),
            rs.getDouble("min_order_amount"),
            rs.getBoolean("is_active")
        );
    }

    private void close(ResultSet rs, Statement ps, Connection con) {
        try { if (rs  != null) rs.close();  } catch (SQLException ignored) {}
        try { if (ps  != null) ps.close();  } catch (SQLException ignored) {}
        try { if (con != null) con.close(); } catch (SQLException ignored) {}
    }
}
