// Abstract Base Class
package com.tourism.model;

import java.io.Serializable;

public abstract class Payment implements Serializable {
    protected String paymentNumber;
    protected String customerName;
    protected String mobileNumber;
    protected String email;
    protected double amount;
    protected String paymentStatus;

    public Payment() {
        this.paymentStatus = "PENDING";
    }

    // Abstract method
    public abstract String getPaymentMethod();

    // Getters and setters
    public String getPaymentNumber() { return paymentNumber; }
    public void setPaymentNumber(String paymentNumber) { this.paymentNumber = paymentNumber; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public abstract String toFileString();
}
