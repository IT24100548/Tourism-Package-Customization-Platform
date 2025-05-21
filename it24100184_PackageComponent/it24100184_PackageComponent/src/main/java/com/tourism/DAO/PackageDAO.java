package com.tourism.DAO;

import com.tourism.BST.PackageBST;
import com.tourism.model.*;

import java.io.*;
import java.net.URL;
import java.util.List;

public class PackageDAO {
    private static final String FILE_PATH = "packages.txt";

    // Load packages from file and populate BST
    public static PackageBST loadPackages() {
        PackageBST bst = new PackageBST();

        try (InputStream inputStream = PackageDAO.class.getClassLoader().getResourceAsStream(FILE_PATH);
             BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {

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
            System.out.println("[PackageDAO] Error reading file: " + FILE_PATH);
            e.printStackTrace();
        }

        return bst;
    }

    // Save packages from BST back to file
    public static void savePackages(PackageBST bst) {
        List<TravelPackage> packageList = bst.inorderTraversal();
        System.out.println("[PackageDAO] Saving " + packageList.size() + " packages");

        try {
            URL resourceUrl = PackageDAO.class.getClassLoader().getResource(FILE_PATH);
            File file = new File(resourceUrl.toURI());

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                for (TravelPackage tp : packageList) {
                    writer.write(tp.toString());
                    writer.newLine();
                }
            }
        } catch (Exception e) {
            System.out.println("[PackageDAO] Error writing to file: " + FILE_PATH);
            e.printStackTrace();
        }
    }
}