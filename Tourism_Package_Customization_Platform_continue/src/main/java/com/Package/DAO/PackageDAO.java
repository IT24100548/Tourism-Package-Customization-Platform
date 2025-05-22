package com.Package.DAO;


import com.Package.BST.PackageBST;

import com.Package.model.TravelPackage;
import com.Package.model.AdventurePackage;
import com.Package.model.LeisurePackage;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections;


public class PackageDAO {

    private static final String FILE_PATH = "C:\\Users\\DELL\\Desktop\\Tourism_Package_Customization_Platform_continue\\src\\main\\resources\\packages.txt";

    // Save new package
    public static void savePackage(TravelPackage pack) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(pack.toString());
            writer.newLine();
        }
    }

    // Read all packages
    public static List<TravelPackage> getAllPackages() throws IOException {
        List<TravelPackage> packages = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                TravelPackage pack = parsePackage(line);
                if (pack != null) {
                    packages.add(pack);
                }
            }
        }
        return packages;
    }

    // Parse a line into a Package object
    private static TravelPackage parsePackage(String line) {
        String[] data = line.split(",");
        if (data.length >= 6) {
            String type = data[0].trim();
            String id = data[1].trim();
            String name = data[2].trim();
            String destination = data[3].trim();
            double price = Double.parseDouble(data[4].trim());
            String description = data[5].trim();

            if ("ADVENTURE".equalsIgnoreCase(type) && data.length >= 7) {
                String activityType = data[6].trim();
                return new AdventurePackage(id, name, destination, price, description, activityType);
            } else if ("LEISURE".equalsIgnoreCase(type) && data.length >= 7) {
                String hotelType = data[6].trim();
                return new LeisurePackage(id, name, destination, price, description, hotelType);
            }
        }
        return null; // Invalid line format
    }

    // Update a package (by ID)
    public static boolean updatePackage(String id, TravelPackage updatedPackage) throws IOException {
        List<TravelPackage> packages = getAllPackages();
        boolean updated = false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (TravelPackage pack : packages) {
                if (pack.getId().equalsIgnoreCase(id)) {
                    writer.write(updatedPackage.toString());
                    updated = true;
                } else {
                    writer.write(pack.toString());
                }
                writer.newLine();
            }
        }
        return updated;
    }

    // Delete a package (by ID)
    public static boolean deletePackage(String id) throws IOException {
        List<TravelPackage> packages = getAllPackages();
        boolean deleted = false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (TravelPackage pack : packages) {
                if (!pack.getId().equalsIgnoreCase(id)) {
                    writer.write(pack.toString());
                    writer.newLine();
                } else {
                    deleted = true;
                }
            }
        }

        // Rebuild the BST after deletion
        if (deleted) {
            packageTree.clear();  // clear current tree
            for (TravelPackage pack : getAllPackages()) {
                packageTree.insert(pack);  // re-insert from file
            }
        }

        return deleted;
    }


    // Find a specific package (by ID)
    public static TravelPackage findPackageById(String id) throws IOException {
        for (TravelPackage pack : getAllPackages()) {
            if (pack.getId().equalsIgnoreCase(id)) {
                return pack;
            }
        }
        return null;
    }
    public static PackageBST packageTree = new PackageBST(); // Global tree

    // Load all packages from file into BST
    public static void loadPackages() throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                TravelPackage pack = parsePackage(line);
                if (pack != null) {
                    packageTree.insert(pack);  // Insert into BST
                }
            }
        }
    }

    // Save BST into file (inorder traversal)
    public static void savePackages() throws IOException {
        List<TravelPackage> allPackages = packageTree.inorderTraversal();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (TravelPackage pack : allPackages) {
                writer.write(pack.toString());
                writer.newLine();
            }
        }
    }

    public static List<TravelPackage> getPackagesSortedByPrice() {
        List<TravelPackage> packages = packageTree.inorderTraversal(); // BST gives sorted by ID
        quickSortByPrice(packages, 0, packages.size() - 1);
        return packages;
    }

    private static void quickSortByPrice(List<TravelPackage> list, int low, int high) {
        if (low < high) {
            int pi = partition(list, low, high);
            quickSortByPrice(list, low, pi - 1);
            quickSortByPrice(list, pi + 1, high);
        }
    }

    private static int partition(List<TravelPackage> list, int low, int high) {
        double pivot = list.get(high).getPrice();
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (list.get(j).getPrice() < pivot) {
                i++;
                Collections.swap(list, i, j);
            }
        }
        Collections.swap(list, i + 1, high);
        return i + 1;
    }

}

