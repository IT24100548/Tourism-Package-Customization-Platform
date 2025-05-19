package com.User.model;

import java.io.Serializable;

// Abstract class: Cannot be instantiated directly
public abstract class User implements Serializable {
    protected String username;
    protected String password;
    protected String email;

    public User(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.email = email;
    }

    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getEmail() { return email; }

    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setUsername(String username){this.username = username;}

    // Abstract method to be implemented by subclasses (polymorphism)
    public abstract String login();

    // Updated `toString()` to include user type dynamically
    @Override
    public String toString() {
        return this.getClass().getSimpleName() + "," + getUsername() + "," + getEmail() + "," + getPassword();
    }

    // Factory method to create users from string data
    public static User fromString(String userData) {
        String[] data = userData.split(",");
        if (data.length < 4) {
            throw new IllegalArgumentException("Invalid user data format.");
        }
        String userType = data[0];
        String username = data[1];
        String email = data[2];
        String password = data[3];

        switch (userType) {
            case "Traveler":
                return new Traveler(username, password, email);
            case "AdminUser":
                return new AdminUser(username, password, email);
            default:
                throw new IllegalArgumentException("Unknown user type: " + userType);
        }
    }
}
