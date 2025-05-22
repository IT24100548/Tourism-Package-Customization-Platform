package com.Admin.DAO;

import com.Admin.model.AdminUser;
import java.io.*;


import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    private static final String FILE_PATH = "C:\\Users\\DELL\\Desktop\\Tourism_Package_Customization_Platform_continue\\src\\main\\resources\\admins.txt";

    // Save new admin
    public static void saveAdmin(AdminUser admin) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(admin.toString());
            writer.newLine();
        }
    }

    // Read admins from file
    public static List<AdminUser> getAdmins() throws IOException {
        List<AdminUser> admins = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                AdminUser admin = parseAdmin(line);
                if (admin != null) {
                    admins.add(admin);
                }
            }
        }
        return admins;
    }

    // Parse admin from line
    private static AdminUser parseAdmin(String dataLine) {
        String[] data = dataLine.split(",");
        if (data.length == 4 && data[0].equalsIgnoreCase("ADMIN")) {
            return new AdminUser(data[1].trim(), data[2].trim(), data[3].trim());
        }
        return null;
    }

    // Validate admin login
    public static AdminUser validateAdmin(String username, String password) throws IOException {
        List<AdminUser> admins = getAdmins();
        for (AdminUser admin : admins) {

            if (admin.getUsername().equalsIgnoreCase(username) && admin.getPassword().equals(password)) {
                return admin;
            }
        }
        return null;
    }

    // Update admin email
    public static boolean updateAdminEmail(String username, String newEmail) {
        return updateAdminField(username, "email", newEmail);
    }

    // Update admin password
    public static boolean updateAdminPassword(String username, String newPassword) {
        return updateAdminField(username, "password", newPassword);
    }

    // Generic field updater (email or password)
    private static boolean updateAdminField(String username, String field, String newValue) {
        File inputFile = new File(FILE_PATH);
        File tempFile = new File(FILE_PATH + ".tmp");
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");

                if (data.length == 4 && data[0].equalsIgnoreCase("ADMIN") && data[1].equalsIgnoreCase(username)) {
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
            if (!inputFile.delete() || !tempFile.renameTo(inputFile)) {
                System.out.println("File operation error during admin update.");
                return false;
            }
        } else {
            tempFile.delete();
        }

        return updated;
    }

    // Delete admin
    public static boolean deleteAdmin(String username) throws IOException {
        List<AdminUser> admins = getAdmins();
        boolean deleted = false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (AdminUser admin : admins) {
                if (!admin.getUsername().equalsIgnoreCase(username)) {
                    writer.write("ADMIN," + admin.getUsername() + "," + admin.getPassword() + "," + admin.getEmail());
                    writer.newLine();
                } else {
                    deleted = true;
                }
            }
        }
        return deleted;
    }

}

