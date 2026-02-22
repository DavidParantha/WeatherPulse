package com.david.weather.service;

import com.david.weather.model.AlertPreferences;

import java.util.ArrayList;
import java.util.List;

public class AlertService {

    /**
     * Evaluate alert conditions based on user preferences and live weather data
     */
    public List<String> evaluate(AlertPreferences prefs, double temp, double rainMm, double pm25) {
        List<String> alerts = new ArrayList<>();

        // If user not logged in or no preferences saved, no alerts
        if (prefs == null) {
            return alerts;
        }

        // 🔥 Temperature alert
        if (temp >= prefs.getTempThreshold()) {
            alerts.add("🔥 High temperature alert! Temperature is " + temp + "°C. Stay hydrated.");
        }

        // 🌧 Heavy rain alert (>= 10 mm in next hour)
        if (prefs.isRainAlerts() && rainMm >= 10) {
            alerts.add("🌧 Heavy rain expected (" + rainMm + " mm). Carry an umbrella and avoid low areas.");
        }

        // 🫁 Air quality alert (PM2.5)
        if (prefs.isAirQualityAlerts() && pm25 >= 35) {
            alerts.add("🫁 Poor air quality (PM2.5 = " + pm25 + "). Consider wearing a mask outdoors.");
        }

        return alerts;
    }
}