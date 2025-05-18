package com.tourism.util;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import com.tourism.model.Payment;

import javax.mail.*;
import javax.mail.internet.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Properties;

public class PaymentNotificationUtil {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USERNAME = "your.email@gmail.com"; // TODO: Configure email
    private static final String SMTP_PASSWORD = "your-app-password"; // TODO: Configure app password

    public static void sendPaymentConfirmation(Payment payment) {
        try {
            // Generate PDF receipt
            byte[] pdfBytes = generatePdfReceipt(payment);
            
            // Send email with PDF attachment
            sendEmailWithAttachment(payment, pdfBytes);
        } catch (Exception e) {
            e.printStackTrace();
            // In a production environment, you should use proper logging and error handling
        }
    }

    private static byte[] generatePdfReceipt(Payment payment) throws DocumentException, IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document();
        PdfWriter.getInstance(document, baos);
        
        document.open();
        document.add(new Paragraph("Payment Receipt"));
        document.add(new Paragraph("-------------------"));
        document.add(new Paragraph("Payment Number: " + payment.getPaymentNumber()));
        document.add(new Paragraph("Customer Name: " + payment.getCustomerName()));
        document.add(new Paragraph("Amount: $" + String.format("%.2f", payment.getAmount())));
        document.add(new Paragraph("Status: " + payment.getPaymentStatus()));
        document.add(new Paragraph("Date: " + java.time.LocalDateTime.now().toString()));
        document.add(new Paragraph("\nCard Information:"));
        document.add(new Paragraph("Card ending in: ..." + 
            payment.getCardNumber().substring(payment.getCardNumber().length() - 4)));
        document.close();
        
        return baos.toByteArray();
    }
}
