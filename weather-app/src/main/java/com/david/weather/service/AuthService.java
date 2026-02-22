package com.david.weather.service;

import com.david.weather.dao.UserDao;
import com.david.weather.model.User;

public class AuthService {

    public boolean register(String email, String password) {
        if (UserDao.exists(email)) return false;
        UserDao.save(new User(email, password));
        return true;
    }

    public User login(String email, String password) {
        User user = UserDao.find(email);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}