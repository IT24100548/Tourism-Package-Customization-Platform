package com.tourism.DAO;

import com.tourism.BST.PackageBST;
import com.tourism.model.*;

import java.io.*;
import java.util.List;

public class PackageDAO {
    // Load packages from file and populate BST
    public static PackageBST loadPackages(String realPath) {
        PackageBST bst = new PackageBST();
        File file = new File(realPath);

        System.out.println("[PackageDAO] File path: " + file.getAbsolutePath());

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                if (parts.length == 7) {
                    try {
                        String id = parts[0];
                        String name = parts[1];
                        String destination = parts[2];
                        double price = Double.parseDouble(parts[3]);
                        String description = parts[4];
                        String extra = parts[5];
                        String type = parts[6];

                        TravelPackage tp;
                        if (type.equalsIgnoreCase("Adventure")) {
                            tp = new AdventurePackage(id, name, destination, price, description, extra);
                        } else if (type.equalsIgnoreCase("Leisure")) {
                            tp = new LeisurePackage(id, name, destination, price, description, extra);
                        } else {
                            continue;
                        }

                        bst.insert(tp);
                    } catch (Exception e) {
                        System.out.println("[PackageDAO] Skipping bad line: " + line);
                    }
                }
            }
        } catch (IOException e) {
            System.out.println("[PackageDAO] File not found or unreadable: " + realPath);
            e.printStackTrace();
        }

        return bst;
    }

    // Save packages from BST back to file
    public static void savePackages(PackageBST bst, String realPath) {
        List<TravelPackage> packageList = bst.inorderTraversal();
        System.out.println("[PackageDAO] Saving " + packageList.size() + " packages to: " + realPath);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(realPath))) {
            for (TravelPackage tp : packageList) {
                writer.write(tp.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("[PackageDAO] Error writing to file: " + realPath);
            e.printStackTrace();
        }
    }
}