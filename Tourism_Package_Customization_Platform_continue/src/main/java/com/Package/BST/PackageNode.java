package com.Package.BST;



import com.Package.model.TravelPackage;

public class PackageNode {
    private TravelPackage data;
    private PackageNode left;
    private PackageNode right;

    public PackageNode(TravelPackage data) {
        this.data = data;
    }

    public TravelPackage getData() {
        return data;
    }

    public void setData(TravelPackage data) {
        this.data = data;
    }

    public PackageNode getLeft() {
        return left;
    }

    public void setLeft(PackageNode left) {
        this.left = left;
    }

    public PackageNode getRight() {
        return right;
    }

    public void setRight(PackageNode right) {
        this.right = right;
    }
}
