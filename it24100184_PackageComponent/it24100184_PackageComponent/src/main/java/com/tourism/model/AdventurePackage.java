package com.tourism.model;

public class AdventurePackage extends TravelPackage {
    private String activityType;

    public AdventurePackage(String id, String name, String destination, double price, String description, String activityType) {
        super(id, name, destination, price, description);
        this.activityType = activityType;
    }

    public String getActivityType() {
        return activityType;
    }

    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }

    @Override
    public String getExtraDetails() {
        return "Activity Type: " + activityType;
    }

    @Override
    public String toString() {
        return super.toString() + "," + activityType + ",Adventure";
    }
}