package com.david.weather.model;

public class User {
    private String email;
    private String password; // plain for now (we’ll hash later)

    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public String getEmail() { return email; }
    public String getPassword() { return password; }
}