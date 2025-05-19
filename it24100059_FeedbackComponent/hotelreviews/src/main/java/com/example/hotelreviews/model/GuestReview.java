package com.example.hotelreviews.model;

public class GuestReview extends Review {
    private boolean requiresApproval;

    public GuestReview(String userName, String tourName, String reviewText, int rating, boolean requiresApproval) {
        super(userName, tourName, reviewText, rating);
        this.requiresApproval = requiresApproval;
    }

    public void approveReview() { this.requiresApproval = false; }

    @Override
    public String toFileFormat() {
        return "GUEST|" + getUserName() + "|" + getTourName() + "|" + getReviewText() + "|" + getRating() + "|" + requiresApproval;
    }
}
