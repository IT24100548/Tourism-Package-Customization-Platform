package com.tourism.BST;

import com.tourism.model.TravelPackage;

public class PackageNode {
    public TravelPackage data;
    public PackageNode left;
    public PackageNode right;

    public PackageNode(TravelPackage data) {
        this.data = data;
        this.left = null;
        this.right = null;
    }
}