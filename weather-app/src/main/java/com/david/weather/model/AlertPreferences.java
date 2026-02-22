package com.david.weather.model;

public class AlertPreferences {
    private double tempThreshold;
    private boolean rainAlerts;
    private boolean airQualityAlerts;

    public AlertPreferences(double tempThreshold, boolean rainAlerts, boolean airQualityAlerts) {
        this.tempThreshold = tempThreshold;
        this.rainAlerts = rainAlerts;
        this.airQualityAlerts = airQualityAlerts;
    }

    public double getTempThreshold() { return tempThreshold; }
    public boolean isRainAlerts() { return rainAlerts; }
    public boolean isAirQualityAlerts() { return airQualityAlerts; }
}