package com.tourism.model;

public class CardPayment extends Payment {
    private String cardNumber;
    private String cvv;
    private String expiryDate;

    public CardPayment() {
        super();
    }

    @Override
    public String getPaymentMethod() {
        return "Card";
    }

    // Getters and Setters
    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    // Convert object to file string
    @Override
    public String toFileString() {
        return String.join("|",
                "Card", // Type indicator for polymorphic deserialization
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

    // Build object from file line
    public static CardPayment fromFileString(String[] parts) {
        if (parts.length != 10 || !"Card".equals(parts[0])) {
            throw new IllegalArgumentException("Invalid CardPayment record: " + String.join("|", parts));
        }

        CardPayment payment = new CardPayment();
        payment.setPaymentNumber(parts[1]);
        payment.setCustomerName(parts[2]);
        payment.setMobileNumber(parts[3]);
        payment.setEmail(parts[4]);
        payment.setCardNumber(parts[5]);
        payment.setCvv(parts[6]);
        payment.setExpiryDate(parts[7]);
        payment.setAmount(Double.parseDouble(parts[8]));
        payment.setPaymentStatus(parts[9]);

        return payment;
    }
}
