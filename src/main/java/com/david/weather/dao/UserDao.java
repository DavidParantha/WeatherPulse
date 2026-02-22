package com.david.weather.dao;

import com.david.weather.model.User;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class UserDao {
    private static final Map<String, User> USERS = new ConcurrentHashMap<>();

    public static boolean exists(String email) {
        return USERS.containsKey(email);
    }

    public static void save(User user) {
        USERS.put(user.getEmail(), user);
    }

    public static User find(String email) {
        return USERS.get(email);
    }
}