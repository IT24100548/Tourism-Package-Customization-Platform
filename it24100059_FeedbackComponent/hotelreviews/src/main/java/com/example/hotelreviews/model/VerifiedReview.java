package com.example.hotelreviews.model;

public class VerifiedReview extends Review {
    public VerifiedReview(String userName, String tourName, String reviewText, int rating) {
        super(userName, tourName, reviewText, rating);
    }

    @Override
    public String toFileFormat() {
        return "VERIFIED|" + getUserName() + "|" + getTourName() + "|" + getReviewText() + "|" + getRating();
    }
}
