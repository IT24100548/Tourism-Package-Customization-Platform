package com.tourism.service;

import com.tourism.model.Payment;
import com.tourism.model.CardPayment;
import com.tourism.model.PayPalPayment;

import java.io.*;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class PaymentService {

    private static final String FILE_PATH = "C:\\Users\\USER\\Desktop\\Tourism-Package-Customization-Platform\\PaymentComponent\\src\\main\\resources\\payments.txt";

    public PaymentService() {
        try {
            Files.createDirectories(Paths.get(FILE_PATH).getParent());
            if (!Files.exists(Paths.get(FILE_PATH))) {
                Files.createFile(Paths.get(FILE_PATH));
            }
        } catch (IOException e) {
            throw new RuntimeException("Could not initialize payment storage", e);
        }
    }

    public Payment createPayment(Payment payment) throws IOException {
        payment.setPaymentNumber(generatePaymentNumber());
        List<Payment> payments = getAllPayments();
        payments.add(payment);
        savePayments(payments);
        return payment;
    }

    public List<Payment> getAllPayments() throws IOException {
        List<Payment> payments = new ArrayList<>();
        if (Files.exists(Paths.get(FILE_PATH))) {
            List<String> lines = Files.readAllLines(Paths.get(FILE_PATH));
            for (String line : lines) {
                if (!line.trim().isEmpty()) {
                    try {
                        String[] parts = line.split("\\|", -1);
                        String type = parts[0];

                        Payment payment = null;
                        if ("Card".equalsIgnoreCase(type)) {
                            payment = CardPayment.fromFileString(parts);
                        } else if ("PayPal".equalsIgnoreCase(type)) {
                            payment = PayPalPayment.fromFileString(parts);
                        } else {
                            System.err.println("⚠️ Unknown payment type: " + type);
                        }

                        if (payment != null) {
                            payments.add(payment);
                        }
                    } catch (Exception ex) {
                        System.err.println("⚠️ Skipping invalid payment record: " + line);
                        ex.printStackTrace();
                    }
                }
            }
        }
        return payments;
    }

    public Payment getPaymentByNumber(String paymentNumber) throws IOException {
        return getAllPayments().stream()
                .filter(p -> p.getPaymentNumber().equals(paymentNumber))
                .findFirst()
                .orElse(null);
    }

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

    public List<Payment> getPaymentsByMobileNumber(String mobileNumber) throws IOException {
        return getAllPayments().stream()
                .filter(p -> p.getMobileNumber().equals(mobileNumber))
                .collect(Collectors.toList());
    }

    private String generatePaymentNumber() {
        LocalDateTime now = LocalDateTime.now();
        String dateStr = now.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        return "PAY" + dateStr;
    }

    private void savePayments(List<Payment> payments) throws IOException {
        List<String> lines = payments.stream()
                .map(Payment::toFileString)
                .collect(Collectors.toList());
        Files.write(Paths.get(FILE_PATH), lines, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
    }
}
