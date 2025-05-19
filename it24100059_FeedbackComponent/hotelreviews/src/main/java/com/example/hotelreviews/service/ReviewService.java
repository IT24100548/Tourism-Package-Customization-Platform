package com.example.hotelreviews.service;

import com.example.hotelreviews.model.Review;
import com.example.hotelreviews.model.GuestReview;
import com.example.hotelreviews.model.VerifiedReview;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;

@Service
public class ReviewService {
    private List<Review> reviewList;
    private static final String FILE_PATH = "C:\\Users\\User\\Desktop\\Tourism-Package-Customization-Platform\\it24100059_FeedbackComponent\\hotelreviews\\reviews.txt";
    private static final Logger LOGGER = Logger.getLogger(ReviewService.class.getName());

    public ReviewService() {
        this.reviewList = Objects.requireNonNullElseGet(loadReviewsFromFile(), ArrayList::new);  // ✅ Efficient null handling
        LOGGER.info("✅ Reviews loaded successfully! Total count: " + reviewList.size());
    }

    public String addReview(Review review) {
        reviewList.add(review);
        return saveReviewsToFile() ? "Review added successfully!" : "Failed to save review!";
    }

    public List<Review> getAllReviews() {
        if (reviewList == null) {
            reviewList = new ArrayList<>();  // ✅ Prevents NullPointerException
        }
        LOGGER.info("Returning reviews count: " + reviewList.size());
        return reviewList;
    }


    public Review getReviewByIndex(int index) {
        return (index >= 0 && index < reviewList.size()) ? reviewList.get(index) : null;
    }

    public String updateReview(int index, Review updatedReview) {
        if (index >= 0 && index < reviewList.size()) {
            reviewList.set(index, updatedReview);
            return saveReviewsToFile() ? "Review updated successfully!" : "Failed to update review!";
        }
        return "Invalid review index.";
    }

    public String deleteReview(int index) {
        if (index >= 0 && index < reviewList.size()) {
            reviewList.remove(index);
            return saveReviewsToFile() ? "Review deleted successfully!" : "Failed to delete review!";
        }
        return "Invalid review index.";
    }

    public String approveGuestReview(int index) {
        if (index >= 0 && index < reviewList.size() && reviewList.get(index) instanceof GuestReview) {
            ((GuestReview) reviewList.get(index)).approveReview();
            return saveReviewsToFile() ? "Guest review approved!" : "Failed to approve review!";
        }
        return "Invalid review index or not a guest review.";
    }

    private boolean saveReviewsToFile() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Review review : reviewList) {
                writer.write(review.toFileFormat());
                writer.newLine();
            }
            LOGGER.info("✅ Reviews saved successfully!");
            return true;  // ✅ Return success status
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error saving reviews to file", e);
            return false;  // ✅ Return failure status
        }
    }

    private List<Review> loadReviewsFromFile() {
        List<Review> reviews = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                try {
                    if (parts.length == 6 && "GUEST".equals(parts[0])) {
                        reviews.add(new GuestReview(parts[1], parts[2], parts[3], Integer.parseInt(parts[4]), Boolean.parseBoolean(parts[5])));
                    } else if (parts.length == 5 && "VERIFIED".equals(parts[0])) {
                        reviews.add(new VerifiedReview(parts[1], parts[2], parts[3], Integer.parseInt(parts[4])));
                    } else if (parts.length == 5 && "STANDARD".equals(parts[0])) {
                        reviews.add(new Review(parts[1], parts[2], parts[3], Integer.parseInt(parts[4])));
                    } else {
                        LOGGER.warning("Skipping malformed line: " + line);
                    }
                } catch (NumberFormatException e) {
                    LOGGER.log(Level.WARNING, "Error parsing rating for line: " + line, e);
                }
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading from file: " + FILE_PATH, e);
        }

        LOGGER.info("✅ Loaded reviews count: " + reviews.size());
        return reviews;
    }
}
