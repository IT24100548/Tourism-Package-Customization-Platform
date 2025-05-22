package com.Package.BST;

import com.Package.model.TravelPackage;
import java.util.ArrayList;
import java.util.List;

public class PackageBST {
    private PackageNode root;

    public PackageBST() {
        this.root = null;
    }

    // Insert into BST
    public void insert(TravelPackage newPackage) {
        root = insertRec(root, newPackage);
    }

    private PackageNode insertRec(PackageNode root, TravelPackage newPackage) {
        if (root == null) {
            return new PackageNode(newPackage);
        }
        if (newPackage.getId().compareTo(root.getData().getId()) < 0) {
            root.setLeft(insertRec(root.getLeft(), newPackage));
        } else if (newPackage.getId().compareTo(root.getData().getId()) > 0) {
            root.setRight(insertRec(root.getRight(), newPackage));
        }
        return root;
    }

    // Inorder Traversal (returns sorted list)
    public List<TravelPackage> inorderTraversal() {
        List<TravelPackage> packages = new ArrayList<>();
        inorderRec(root, packages);
        return packages;
    }

    private void inorderRec(PackageNode root, List<TravelPackage> packages) {
        if (root != null) {
            inorderRec(root.getLeft(), packages);
            packages.add(root.getData());
            inorderRec(root.getRight(), packages);
        }
    }

    // Search by ID
    public TravelPackage search(String id) {
        return searchRec(root, id);
    }

    private TravelPackage searchRec(PackageNode root, String id) {
        if (root == null) return null;
        if (id.equals(root.getData().getId())) {
            return root.getData();
        }
        if (id.compareTo(root.getData().getId()) < 0) {
            return searchRec(root.getLeft(), id);
        } else {
            return searchRec(root.getRight(), id);
        }
    }

    public List<TravelPackage> searchByName(String name) {
        List<TravelPackage> results = new ArrayList<>();
        searchByNameRec(root, name.toLowerCase(), results);
        return results;
    }

    private void searchByNameRec(PackageNode node, String name, List<TravelPackage> results) {
        if (node == null) return;

        // case-insensitive match
        if (node.getData().getName().toLowerCase().contains(name)) {
            results.add(node.getData());
        }

        searchByNameRec(node.getLeft(), name, results);
        searchByNameRec(node.getRight(), name, results);
    }
    public List<TravelPackage> searchByNameOrDestination(String keyword) {
        List<TravelPackage> results = new ArrayList<>();
        searchByNameOrDestinationRec(root, keyword.toLowerCase(), results);
        return results;
    }

    private void searchByNameOrDestinationRec(PackageNode node, String keyword, List<TravelPackage> results) {
        if (node == null) return;

        String name = node.getData().getName().toLowerCase();
        String destination = node.getData().getDestination().toLowerCase();

        if (name.contains(keyword) || destination.contains(keyword)) {
            results.add(node.getData());
        }

        searchByNameOrDestinationRec(node.getLeft(), keyword, results);
        searchByNameOrDestinationRec(node.getRight(), keyword, results);
    }
    public void clear() {
        root = null;
    }



}
