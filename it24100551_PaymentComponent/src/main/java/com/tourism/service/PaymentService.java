package com.tourism.service;

import com.tourism.model.Payment;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class PaymentService {

    private static final String FILE_PATH = "E:\\zp\\payment_system\\src\\main\\resources\\payments.txt";

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
}
