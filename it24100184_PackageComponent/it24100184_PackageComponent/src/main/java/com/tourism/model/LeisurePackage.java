package com.tourism.model;

public class LeisurePackage extends TravelPackage {
    private String hotelType;

    public LeisurePackage(String id, String name, String destination, double price, String description, String hotelType) {
        super(id, name, destination, price, description);
        this.hotelType = hotelType;
    }

    public String getHotelType() {
        return hotelType;
    }

    public void setHotelType(String hotelType) {
        this.hotelType = hotelType;
    }

    @Override
    public String getExtraDetails() {
        return "Hotel Type: " + hotelType;
    }

    @Override
    public String toString() {
        return super.toString() + "," + hotelType + ",Leisure";
    }
}