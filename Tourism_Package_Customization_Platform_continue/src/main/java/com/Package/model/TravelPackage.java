package com.Package.model;

public class TravelPackage {
    protected String id;
    protected String name;
    protected String destination;
    protected double price;
    protected String description;

    public TravelPackage() {}

    public TravelPackage(String id, String name, String destination, double price, String description) {
        this.id = id;
        this.name = name;
        this.destination = destination;
        this.price = price;
        this.description = description;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public  String getExtraDetails(){

            return "No extra details available.";


    }



    @Override
    public String toString() {
        return id + "," + name + "," + destination + "," + price + "," + description;
    }
}
