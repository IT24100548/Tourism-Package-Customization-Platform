package com.tourism.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.regex.Pattern;

public class Payment implements Serializable {
    private String paymentNumber;
    private String customerName;
    private String mobileNumber;
    private String email;
    private String cardNumber;
    private String cvv;
    private String expiryDate;
    private double amount;
    private String paymentStatus;

    // Email pattern for validation
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    
    // Constructor
    public Payment() {
        this.paymentStatus = "PENDING";
    }

    // Getters and Setters with validation
    public String getPaymentNumber() {
        return paymentNumber;
    }

    public void setPaymentNumber(String paymentNumber) {
        this.paymentNumber = paymentNumber;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        if (customerName == null || customerName.trim().isEmpty()) {
            throw new IllegalArgumentException("Customer name cannot be empty");
        }
        this.customerName = customerName;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        if (!mobileNumber.matches("\\d{10}")) {
            throw new IllegalArgumentException("Mobile number must be 10 digits");
        }
        this.mobileNumber = mobileNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            throw new IllegalArgumentException("Invalid email format");
        }
        this.email = email;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        if (!cardNumber.matches("\\d{16}")) {
            throw new IllegalArgumentException("Card number must be 16 digits");
        }
        this.cardNumber = cardNumber;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        if (!cvv.matches("\\d{3}")) {
            throw new IllegalArgumentException("CVV must be 3 digits");
        }
        this.cvv = cvv;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        if (!expiryDate.matches("\\d{2}/\\d{2}")) {
            throw new IllegalArgumentException("Expiry date must be in MM/YY format");
        }
        
        try {
            // Parse the expiry date
            String[] parts = expiryDate.split("/");
            int month = Integer.parseInt(parts[0]);
            int year = Integer.parseInt(parts[1]) + 2000; // Convert YY to YYYY
            
            // Create YearMonth object
            YearMonth cardExpiry = YearMonth.of(year, month);
            YearMonth now = YearMonth.now();
            
            // Check if card has expired
            if (cardExpiry.isBefore(now)) {
                throw new IllegalArgumentException("Card has expired");
            }
            
            this.expiryDate = expiryDate;
        } catch (NumberFormatException | ArrayIndexOutOfBoundsException e) {
            throw new IllegalArgumentException("Invalid expiry date format");
        }
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }
        this.amount = amount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    // Method to convert payment to string format for file storage
    public String toFileString() {
        return String.join("|", 
            paymentNumber,
            customerName,
            mobileNumber,
            email,
            cardNumber,
            cvv,
            expiryDate,
            String.valueOf(amount),
            paymentStatus
        );
    }

    // Method to create payment from string
    public static Payment fromFileString(String line) {
        String[] parts = line.split("\\|");
        Payment payment = new Payment();
        payment.setPaymentNumber(parts[0]);
        payment.setCustomerName(parts[1]);
        payment.setMobileNumber(parts[2]);
        payment.setEmail(parts[3]);
        payment.setCardNumber(parts[4]);
        payment.setCvv(parts[5]);
        payment.setExpiryDate(parts[6]);
        payment.setAmount(Double.parseDouble(parts[7]));
        payment.setPaymentStatus(parts[8]);
        return payment;
    }
}
