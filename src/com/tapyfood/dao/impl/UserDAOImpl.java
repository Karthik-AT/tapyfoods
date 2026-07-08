package com.tapyfood.dao.impl;

import com.tapyfood.dao.UserDAO;
import com.tapyfood.model.User;
import com.tapyfood.util.DBConnection;

import java.sql.*;

/**
 * NOTE: Passwords stored as plain text for demo purposes.
 *       In production, use BCrypt (add bcrypt.jar to WEB-INF/lib/).
 */
public class UserDAOImpl implements UserDAO {

    @Override
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (name, email, password, phone, address, role) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());   // hash in production!
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole() != null ? user.getRole() : "customer");

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLIntegrityConstraintViolationException e) {
            // email UNIQUE constraint violated — email already registered
            System.err.println("[UserDAO] Email already exists: " + user.getEmail());
            return false;
        } catch (SQLException e) {
            System.err.println("[UserDAO] registerUser() failed: " + e.getMessage());
            return false;
        } finally {
            close(null, ps, con);
        }
    }

    @Override
    public User validateLogin(String email, String password) {
        String sql = "SELECT id, name, email, password, phone, address, role " +
                     "FROM users WHERE email = ? AND password = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            rs  = ps.executeQuery();

            if (rs.next()) {
                user = mapRow(rs);
            }
        } catch (SQLException e) {
            System.err.println("[UserDAO] validateLogin() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }

        return user;
    }

    @Override
    public User getUserByEmail(String email) {
        String sql = "SELECT id, name, email, password, phone, address, role " +
                     "FROM users WHERE email = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            ps.setString(1, email);
            rs  = ps.executeQuery();

            if (rs.next()) {
                user = mapRow(rs);
            }
        } catch (SQLException e) {
            System.err.println("[UserDAO] getUserByEmail() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }

        return user;
    }

    private User mapRow(ResultSet rs) throws SQLException {
        return new User(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("email"),
            rs.getString("password"),
            rs.getString("phone"),
            rs.getString("address"),
            rs.getString("role")
        );
    }

    private void close(ResultSet rs, Statement ps, Connection con) {
        try { if (rs  != null) rs.close();  } catch (SQLException ignored) {}
        try { if (ps  != null) ps.close();  } catch (SQLException ignored) {}
        try { if (con != null) con.close(); } catch (SQLException ignored) {}
    }

    @Override
    public java.util.List<User> getUnassignedOwners() {
        java.util.List<User> owners = new java.util.ArrayList<>();
        String sql = "SELECT u.id, u.name, u.email, u.password, u.phone, u.address, u.role " +
                     "FROM users u " +
                     "LEFT JOIN restaurant r ON u.id = r.owner_id " +
                     "WHERE u.role = 'restaurant_owner' AND r.id IS NULL";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps  = con.prepareStatement(sql);
            rs  = ps.executeQuery();
            while (rs.next()) {
                owners.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("[UserDAO] getUnassignedOwners() failed: " + e.getMessage());
        } finally {
            close(rs, ps, con);
        }
        return owners;
    }
}