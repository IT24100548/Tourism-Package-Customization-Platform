package com.User.model;

public class AdminUser extends User {
    public AdminUser(String username, String password, String email) {
        super(username, password, email);
    }

    @Override
    public String login() {
        return "Admin " + username + " logged in.";
    }

    @Override
    public String toString() {
        return "ADMIN," + getUsername() + "," + getEmail() + "," + getPassword();
    }

    public static AdminUser fromString(String userData) {
        String[] data = userData.split(",");

        if (data.length == 4 && data[0].equals("ADMIN")) {
            return new AdminUser(data[1], data[3], data[2]); // Ensure correct order
        } else {
            System.err.println("Invalid admin data format: " + userData);
            return null; // Handle incorrect format gracefully
        }
    }
}
