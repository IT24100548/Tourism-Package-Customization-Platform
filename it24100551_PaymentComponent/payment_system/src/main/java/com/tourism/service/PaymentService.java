package com.tourism.service;

import com.tourism.model.Payment;
import java.io.*;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class PaymentService {

    private static final String FILE_PATH = "C:\\Users\\USER\\Desktop\\zp\\payment_system\\src\\main\\resources\\payments.txt";

    public PaymentService() {
        // Create directory if it doesn't exist
        try {
            Files.createDirectories(Paths.get(FILE_PATH).getParent());
            if (!Files.exists(Paths.get(FILE_PATH))) {
                Files.createFile(Paths.get(FILE_PATH));
            }
        } catch (IOException e) {
            throw new RuntimeException("Could not initialize payment storage", e);
        }
    }

    // Create new payment
    public Payment createPayment(Payment payment) throws IOException {
        payment.setPaymentNumber(generatePaymentNumber());
        List<Payment> payments = getAllPayments();
        payments.add(payment);
        savePayments(payments);
        // TODO: Send email with PDF receipt
        return payment;
    }

    // Read all payments
    public List<Payment> getAllPayments() throws IOException {
        List<Payment> payments = new ArrayList<>();
        if (Files.exists(Paths.get(FILE_PATH))) {
            List<String> lines = Files.readAllLines(Paths.get(FILE_PATH));
            for (String line : lines) {
                if (!line.trim().isEmpty()) {
                    payments.add(Payment.fromFileString(line));
                }
            }
        }
        return payments;
    }
      // Get payment by payment number
    public Payment getPaymentByNumber(String paymentNumber) throws IOException {
        return getAllPayments().stream()
                .filter(p -> p.getPaymentNumber().equals(paymentNumber))
                .findFirst()
                .orElse(null);
    }

    // Update payment
    public boolean updatePayment(Payment payment) throws IOException {
        List<Payment> payments = getAllPayments();
        boolean updated = false;

        for (int i = 0; i < payments.size(); i++) {
            if (payments.get(i).getPaymentNumber().equals(payment.getPaymentNumber())) {
                payments.set(i, payment);
                updated = true;
                break;
            }
        }

        if (updated) {
            savePayments(payments);
        }
        return updated;
    }

    // Delete payment
    public boolean deletePayment(String paymentNumber) throws IOException {
        List<Payment> payments = getAllPayments();
        List<Payment> updatedPayments = payments.stream()
                .filter(p -> !p.getPaymentNumber().equals(paymentNumber))
                .collect(Collectors.toList());

        if (payments.size() != updatedPayments.size()) {
            savePayments(updatedPayments);
            return true;
        }
        return false;
    }

    // Get payments by customer mobile number
    public List<Payment> getPaymentsByMobileNumber(String mobileNumber) throws IOException {
        return getAllPayments().stream()
                .filter(p -> p.getMobileNumber().equals(mobileNumber))
                .collect(Collectors.toList());
    }

    // Generate unique payment number
    private String generatePaymentNumber() throws IOException {
        LocalDateTime now = LocalDateTime.now();
        String dateStr = now.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        return "PAY" + dateStr;
    }

    // Save all payments to file
    private void savePayments(List<Payment> payments) throws IOException {
        List<String> lines = payments.stream()
                .map(Payment::toFileString)
                .collect(Collectors.toList());
        Files.write(Paths.get(FILE_PATH), lines, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
    }
}
