package com.tourism.BST;

import com.tourism.model.TravelPackage;

import java.util.ArrayList;
import java.util.List;

public class PackageBST {
    private PackageNode root;

    public PackageBST() {
        this.root = null;
    }

    // Insert a package into BST based on ID
    public void insert(TravelPackage tp) {
        root = insertRec(root, tp);
    }

    private PackageNode insertRec(PackageNode root, TravelPackage tp) {
        if (root == null) {
            return new PackageNode(tp);
        }
        if (tp.getId().compareTo(root.data.getId()) < 0) {
            root.left = insertRec(root.left, tp);
        } else {
            root.right = insertRec(root.right, tp);
        }
        return root;
    }

    // Search by ID
    public TravelPackage search(String id) {
        return searchRec(root, id);
    }

    private TravelPackage searchRec(PackageNode root, String id) {
        if (root == null) return null;
        if (id.equals(root.data.getId())) return root.data;
        if (id.compareTo(root.data.getId()) < 0) return searchRec(root.left, id);
        return searchRec(root.right, id);
    }

    // Inorder traversal - returns sorted by ID
    public List<TravelPackage> inorderTraversal() {
        List<TravelPackage> packageList = new ArrayList<>();
        inorderRec(root, packageList);
        return packageList;
    }

    private void inorderRec(PackageNode root, List<TravelPackage> list) {
        if (root != null) {
            inorderRec(root.left, list);
            list.add(root.data);
            inorderRec(root.right, list);
        }
    }

    // Delete by ID
    public void delete(String id) {
        root = deleteRec(root, id);
    }

    private PackageNode deleteRec(PackageNode root, String id) {
        if (root == null) return null;

        if (id.compareTo(root.data.getId()) < 0) {
            root.left = deleteRec(root.left, id);
        } else if (id.compareTo(root.data.getId()) > 0) {
            root.right = deleteRec(root.right, id);
        } else {
            // Node to delete found
            if (root.left == null)
                return root.right;
            else if (root.right == null)
                return root.left;

            // Replace with inorder successor
            root.data = minValue(root.right);
            root.right = deleteRec(root.right, root.data.getId());
        }

        return root;
    }

    private TravelPackage minValue(PackageNode root) {
        TravelPackage min = root.data;
        while (root.left != null) {
            root = root.left;
            min = root.data;
        }
        return min;
    }

    // Check if BST is empty
    public boolean isEmpty() {
        return root == null;
    }

    // Clear all nodes
    public void clear() {
        root = null;
    }
}