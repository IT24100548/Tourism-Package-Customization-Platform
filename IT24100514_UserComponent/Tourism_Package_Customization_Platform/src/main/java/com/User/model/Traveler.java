package com.User.model;

public class Traveler extends User {
    public Traveler(String username, String password, String email) {
        super(username, password, email);
    }

    @Override
    public String login() {
        return "Traveler " + username + " logged in.";
    }

    @Override
    public String toString() {
        return "TRAVELER," + getUsername() + "," + getEmail() + "," + getPassword();
    }

    public static Traveler fromString(String userData) {
        String[] data = userData.split(",");

        if (data.length == 4 && data[0].equals("TRAVELER")) {
            return new Traveler(data[1], data[3], data[2]); // Ensure correct order
        } else {
            System.err.println("Invalid traveler data format: " + userData);
            return null; // Handle incorrect format gracefully
        }
    }
}
