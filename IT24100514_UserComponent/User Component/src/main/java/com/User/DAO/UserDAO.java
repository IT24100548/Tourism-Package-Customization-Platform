package com.User.DAO;

import com.User.model.AdminUser;
import com.User.model.Traveler;
import com.User.model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final String FILE_PATH = "C:\\Users\\Owner\\IdeaProjects\\Tourism_Package_Customization_Platform\\src\\main\\resources\\users.txt";

    // Save user to file (Admins are not saved via registration)
    public static void saveUser(User user) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(user.toString());
            writer.newLine();
        }
    }

    // Read users from file
    public static List<User> getUsers() throws IOException {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = parseUser(line);
                if (user != null) {
                    users.add(user);
                }
            }
        }
        return users;
    }

    // Convert a line from users.txt into a User object
    private static User parseUser(String userData) {
        String[] data = userData.split(",");
        if (data.length == 4) {
            String role = data[0].trim();
            String username = data[1].trim();
            String email = data[3].trim();
            String password = data[2].trim();

            if ("ADMIN".equalsIgnoreCase(role)) {
                return new AdminUser(username, password, email);
            } else if ("TRAVELER".equalsIgnoreCase(role)) {
                return new Traveler(username, password, email);
            } else {
                System.out.println("Unknown role found in file: " + role);
            }
        } else {
            System.out.println("Invalid line format: " + userData);
        }
        return null; // Return null if format is incorrect
    }

    // Validate login
    public static User validateUser(String username, String password) throws IOException {
        for (User user : getUsers()) {
            if (user.getUsername().equalsIgnoreCase(username) && user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }


    // Update only email
    public boolean updateTravelerEmail(String username, String newEmail) {
        return updateTravelerField(username, "email", newEmail);
    }

    // Update only password
    public boolean updateTravelerPassword(String username, String newPassword) {
        return updateTravelerField(username, "password", newPassword);
    }

    // Update only username
    public boolean updateTravelerUsername(String currentUsername, String newUsername) {
        File inputFile = new File(FILE_PATH);
        File tempFile = new File(FILE_PATH + ".tmp");

        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");

                if (data.length >= 4 && data[0].equalsIgnoreCase("TRAVELER") && data[1].equalsIgnoreCase(currentUsername)) {
                    // Update the username
                    writer.write(data[0] + "," + newUsername + "," + data[2] + "," + data[3]);
                    updated = true;
                } else {
                    writer.write(line);
                }
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (updated) {
            if (!inputFile.delete()) {
                System.out.println("Could not delete old users.txt");
                return false;
            }
            if (!tempFile.renameTo(inputFile)) {
                System.out.println("Could not rename temp file to users.txt");
                return false;
            }
        } else {
            tempFile.delete();
        }

        return updated;
    }

    // Helper method to update email or password
    private boolean updateTravelerField(String username, String field, String newValue) {
        File inputFile = new File(FILE_PATH);
        File tempFile = new File(FILE_PATH + ".tmp");

        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");

                if (data.length >= 4 && data[0].equalsIgnoreCase("TRAVELER") && data[1].equalsIgnoreCase(username)) {
                    if (field.equals("email")) {
                        writer.write(data[0] + "," + data[1] + "," + data[2] + "," + newValue);
                    } else if (field.equals("password")) {
                        writer.write(data[0] + "," + data[1] + "," + newValue + "," + data[3]);
                    }
                    updated = true;
                } else {
                    writer.write(line);
                }
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (updated) {
            if (!inputFile.delete()) {
                System.out.println("Could not delete old users.txt");
                return false;
            }
            if (!tempFile.renameTo(inputFile)) {
                System.out.println("Could not rename temp file to users.txt");
                return false;
            }
        } else {
            tempFile.delete();
        }

        return updated;
    }

    // Delete traveler account
    public static boolean deleteTraveler(String username) throws IOException {
        List<User> users = getUsers();
        boolean deleted = false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (User user : users) {
                if (!user.getUsername().equalsIgnoreCase(username)) {
                    writer.write(user.toString());
                    writer.newLine();
                } else {
                    deleted = true;
                }
            }
        }
        return deleted;
    }

    // Get user by username
    public User getUserByUsername(String username) {
        List<User> users = readUsersFromFile();
        for (User user : users) {
            if (user.getUsername().equalsIgnoreCase(username.trim())) { // Case insensitive check
                return user;
            }
        }
        return null; // Return null if no user found
    }

    private List<User> readUsersFromFile() {
        List<User> users = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                User user = parseUser(line);
                if (user != null) {
                    users.add(user);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }
}
