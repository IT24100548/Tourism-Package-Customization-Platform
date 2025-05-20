package com.tourism.model;

public class PayPalPayment extends Payment {
    private String paypalEmail;

    public PayPalPayment() {
        super();
    }

    @Override
    public String getPaymentMethod() {
        return "PayPal";
    }

    public String getPaypalEmail() {
        return paypalEmail;
    }

    public void setPaypalEmail(String paypalEmail) {
        this.paypalEmail = paypalEmail;
    }

    @Override
    public String toFileString() {
        return String.join("|",
                "PayPal", // Type indicator
                paymentNumber,
                customerName,
                mobileNumber,
                email,
                paypalEmail,
                String.valueOf(amount),
                paymentStatus
        );
    }

    public static PayPalPayment fromFileString(String[] parts) {
        if (parts.length != 8 || !"PayPal".equals(parts[0])) {
            throw new IllegalArgumentException("Invalid PayPalPayment record: " + String.join("|", parts));
        }

        PayPalPayment payment = new PayPalPayment();
        payment.setPaymentNumber(parts[1]);
        payment.setCustomerName(parts[2]);
        payment.setMobileNumber(parts[3]);
        payment.setEmail(parts[4]);
        payment.setPaypalEmail(parts[5]);
        payment.setAmount(Double.parseDouble(parts[6]));
        payment.setPaymentStatus(parts[7]);

        return payment;
    }
}
