package com.david.weather.dao;

import com.david.weather.model.AlertPreferences;

import java.sql.*;

public class PreferenceDao {

    public static AlertPreferences get(String email) {
        String sql = "SELECT temp_threshold, rain_alerts, air_alerts FROM alert_preferences WHERE email = ?";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new AlertPreferences(
                            rs.getDouble("temp_threshold"),
                            rs.getBoolean("rain_alerts"),
                            rs.getBoolean("air_alerts"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void save(String email, AlertPreferences prefs) {
        String sql = "INSERT INTO alert_preferences (email, temp_threshold, rain_alerts, air_alerts) " +
                "VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE temp_threshold = ?, rain_alerts = ?, air_alerts = ?";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setDouble(2, prefs.getTempThreshold());
            ps.setBoolean(3, prefs.isRainAlerts());
            ps.setBoolean(4, prefs.isAirQualityAlerts());
            ps.setDouble(5, prefs.getTempThreshold());
            ps.setBoolean(6, prefs.isRainAlerts());
            ps.setBoolean(7, prefs.isAirQualityAlerts());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}