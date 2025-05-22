package com.example.hotelreviews.model;

public class Review {
    protected String userName;
    protected String tourName;
    protected String reviewText;
    protected int rating;

    public Review(String userName, String tourName, String reviewText, int rating) {
        this.userName = userName;
        this.tourName = tourName;
        this.reviewText = reviewText;
        this.rating = rating;
    }

    public String getUserName() { return userName; }
    public String getTourName() { return tourName; }
    public String getReviewText() { return reviewText; }
    public int getRating() { return rating; }

    public String toFileFormat() {
        return userName + "|" + tourName + "|" + reviewText + "|" + rating;
    }
}
