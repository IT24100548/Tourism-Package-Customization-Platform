# Tourism Package Payment Management System

A Java EE web application for managing payments in a Tourism Package Customization Platform. The system provides full CRUD operations for payments with file-based storage and features like auto-generated payment numbers, input validation, and email notifications with PDF receipts.

## Features

- Create, Read, Update, and Delete payment records
- File-based storage system using text files
- Input validation for all fields
- Auto-generated payment numbers
- Email notifications with PDF receipts
- Modern responsive UI using Bootstrap
- Real-time search functionality
- Secure card information handling

## Prerequisites

- Java 11 or higher
- Maven 3.6 or higher
- Java EE compatible application server (e.g., WildFly, GlassFish, or TomEE)
- SMTP server access for email notifications

## Project Structure

```
payment_system/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── tourism/
│   │   │           ├── model/
│   │   │           │   └── Payment.java
│   │   │           ├── service/
│   │   │           │   └── PaymentService.java
│   │   │           ├── servlet/
│   │   │           │   └── PaymentServlet.java
│   │   │           └── util/
│   │   │               └── PaymentNotificationUtil.java
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           └── views/
│   │               └── payment/
│   │                   ├── form.jsp
│   │                   ├── list.jsp
│   │                   └── view.jsp
└── pom.xml
```

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd payment_system
   ```

2. Configure email settings:
   - Open `src/main/java/com/tourism/util/PaymentNotificationUtil.java`
   - Update the following constants with your email configuration:
     ```java
     private static final String SMTP_USERNAME = "your.email@gmail.com";
     private static final String SMTP_PASSWORD = "your-app-password";
     ```

3. Build the project:
   ```bash
   mvn clean package
   ```

4. Deploy the WAR file:
   - Copy `target/payment_system.war` to your application server's deployment directory
   - Start your application server

5. Access the application:
   ```
   http://localhost:8080/payment_system/payment
   ```

## Usage

1. **View Payments**
   - Navigate to the home page to see all payments
   - Use the search box to filter payments by customer name or mobile number

2. **Create Payment**
   - Click "New Payment" button
   - Fill in all required fields
   - Submit the form

3. **View Payment Details**
   - Click the eye icon on any payment in the list
   - View complete payment information

4. **Update Payment Status**
   - Click the checkmark icon to mark a payment as completed
   - Confirmation email with PDF receipt will be sent to the customer

5. **Delete Payment**
   - Click the trash icon to delete a payment
   - Confirm the deletion when prompted

## Input Validation Rules

- Customer Name: Required, non-empty
- Mobile Number: 10 digits
- Email: Valid email format
- Card Number: 16 digits
- CVV: 3 digits
- Expiry Date: MM/YY format, must be in the future
- Amount: Positive number

## File Storage

Payments are stored in a text file located at:
```
${user.home}/tourism_payments/payments.txt
```

Each payment record is stored in a pipe-delimited format:
```
paymentNumber|customerName|mobileNumber|email|cardNumber|cvv|expiryDate|amount|paymentStatus
```

## Security Considerations

- Card numbers are masked in the UI, showing only the last 4 digits
- CVV is never displayed after initial entry
- File storage location is outside the web application directory
- Input validation is performed both client-side and server-side

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request
