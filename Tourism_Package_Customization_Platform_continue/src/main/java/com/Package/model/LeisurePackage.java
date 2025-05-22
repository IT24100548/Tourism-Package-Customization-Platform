package com.Package.model;



public class LeisurePackage extends TravelPackage {
    private String hotelType; // Example: 3-star, 5-star, Resort

    public LeisurePackage() {}

    public LeisurePackage(String id, String name, String destination, double price, String description, String hotelType) {
        super(id, name, destination, price, description);
        this.hotelType = hotelType;
    }

    public String getHotelType() { return hotelType; }
    public void setHotelType(String hotelType) { this.hotelType = hotelType; }

    @Override
    public String toString() {
        return "LEISURE," + super.toString() + "," + hotelType;
    }

    @Override
    public String getExtraDetails() {
        return "Hotel Type: " + hotelType;
    }
}

