package com.tourism.util;

import com.tourism.model.Payment;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
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

    private static void sendEmailWithAttachment(Payment payment, byte[] pdfAttachment) 
            throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(SMTP_USERNAME));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(payment.getEmail()));
        message.setSubject("Payment Confirmation - " + payment.getPaymentNumber());

        // Create the message body
        String emailBody = String.format(
            "Dear %s,\n\n" +
            "Thank you for your payment. Your payment has been %s.\n\n" +
            "Payment Details:\n" +
            "Payment Number: %s\n" +
            "Amount: $%.2f\n\n" +
            "Please find attached your payment receipt.\n\n" +
            "Best regards,\n" +
            "Tourism Package Team",
            payment.getCustomerName(),
            payment.getPaymentStatus().toLowerCase(),
            payment.getPaymentNumber(),
            payment.getAmount()
        );

        // Create multipart message
        Multipart multipart = new MimeMultipart();

        // Add text part
        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setText(emailBody);
        multipart.addBodyPart(textPart);

        // Add PDF attachment
        MimeBodyPart pdfPart = new MimeBodyPart();
        pdfPart.setContent(pdfAttachment, "application/pdf");
        pdfPart.setFileName("payment_receipt_" + payment.getPaymentNumber() + ".pdf");
        multipart.addBodyPart(pdfPart);

        message.setContent(multipart);
        Transport.send(message);
    }
}
