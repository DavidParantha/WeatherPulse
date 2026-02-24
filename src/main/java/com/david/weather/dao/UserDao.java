package com.david.weather.dao;

import com.david.weather.model.User;

import java.sql.*;

public class UserDao {

    public static boolean exists(String email) {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void save(User user) {
        String sql = "INSERT INTO users (email, password) VALUES (?, ?)";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static User find(String email) {
        String sql = "SELECT email, password FROM users WHERE email = ?";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(rs.getString("email"), rs.getString("password"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}