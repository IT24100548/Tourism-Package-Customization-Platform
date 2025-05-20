package com.example.hotelreviews.controller;

import com.example.hotelreviews.model.Review;
import com.example.hotelreviews.service.ReviewService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/reviews")
public class ReviewController {
    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    // ✅ Display all reviews in index.html
    @GetMapping("/")
    public String getReviews(Model model) {
        model.addAttribute("reviews", reviewService.getAllReviews());  // ✅ Sends reviews to Thymeleaf
        return "index";  // ✅ Loads index.html
    }

    // ✅ Display all reviews in admin.html with actions
    @GetMapping("/admin")
    public String getAdminPage(Model model) {
        model.addAttribute("reviews", reviewService.getAllReviews());  // ✅ Passes reviews to the page
        return "admin";  // ✅ Loads admin.html
    }



    // ✅ Show Add Review Page (addReview.html)
    @GetMapping("/addReview")
    public String showAddReviewPage(Model model) {
        model.addAttribute("review", new Review("", "", "", 0));
        return "addReview";  // ✅ Loads addReview.html
    }

    // ✅ Handle review submission
    @PostMapping("/add")
    public String addReview(@ModelAttribute Review review) {
        reviewService.addReview(review);
        return "redirect:/reviews/";
    }


    // ✅ Show Update Review Page (updateReview.html)
    @GetMapping("/update/{index}")
    public String showUpdateReviewPage(@PathVariable int index, Model model) {
        Review review = reviewService.getReviewByIndex(index);
        if (review != null) {
            model.addAttribute("review", review);
            model.addAttribute("index", index);
            return "updateReview";  // ✅ Loads updateReview.html
        }
        return "redirect:/reviews/";  // ✅ Redirects if review doesn't exist
    }

    // ✅ Handle review update
    @GetMapping("/reviews/update/{index}")
    public String showUpdateForm(@PathVariable int index, Model model) {
        Review review = reviewService.getReviewByIndex(index);
        model.addAttribute("review", review);
        return "updateReview"; // ✅ Loads updateReview.html
    }


    // ✅ Approve a guest review
    @GetMapping("/approve/{index}")
    public String approveGuestReview(@PathVariable int index) {
        reviewService.approveGuestReview(index);
        return "redirect:/reviews/";  // ✅ Redirects after approval
    }

    // ✅ Delete a review
    @GetMapping("/delete/{index}")
    public String deleteReview(@PathVariable int index) {
        reviewService.deleteReview(index);
        return "redirect:/reviews/";  // ✅ Redirects after deletion
    }
}
