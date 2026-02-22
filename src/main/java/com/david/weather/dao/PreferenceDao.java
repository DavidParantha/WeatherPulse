package com.david.weather.dao;

import com.david.weather.model.AlertPreferences;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class PreferenceDao {
    private static final Map<String, AlertPreferences> PREFS = new ConcurrentHashMap<>();

    public static AlertPreferences get(String email) {
        return PREFS.get(email);
    }

    public static void save(String email, AlertPreferences prefs) {
        PREFS.put(email, prefs);
    }
}