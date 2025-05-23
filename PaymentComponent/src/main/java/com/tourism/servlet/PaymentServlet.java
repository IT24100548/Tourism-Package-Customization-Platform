package com.tourism.servlet;

import com.tourism.model.*;
import com.tourism.service.PaymentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/payment/*")
public class PaymentServlet extends HttpServlet {

    private PaymentService paymentService;

    @Override
    public void init() throws ServletException {
        super.init();
        paymentService = new PaymentService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            List<Payment> payments = paymentService.getAllPayments();

            if (payments.isEmpty()) {
                CardPayment defaultPayment = new CardPayment();
                defaultPayment.setCustomerName("John Doe");
                defaultPayment.setMobileNumber("1234567890");
                defaultPayment.setEmail("john.doe@example.com");
                defaultPayment.setCardNumber("1234567890123456");
                defaultPayment.setCvv("123");
                defaultPayment.setExpiryDate("12/26");
                defaultPayment.setAmount(999.99);
                defaultPayment.setPaymentNumber("PAY" + System.currentTimeMillis());
                defaultPayment.setPaymentStatus("PENDING");

                try {
                    paymentService.createPayment(defaultPayment);
                    payments.add(defaultPayment);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            request.setAttribute("payments", payments);
            request.getRequestDispatcher("/WEB-INF/views/payment/list.jsp").forward(request, response);

        } else if (pathInfo.equals("/new")) {
            request.getRequestDispatcher("/WEB-INF/views/payment/form.jsp").forward(request, response);

        } else if (!pathInfo.equals("/list")) {
            String paymentNumber = pathInfo.substring(1);
            Payment payment = paymentService.getPaymentByNumber(paymentNumber);
            if (payment != null) {
                request.setAttribute("payment", payment);
                request.setAttribute("paymentMethod", payment.getPaymentMethod());
                request.getRequestDispatcher("/WEB-INF/views/payment/view.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("paymentMethod");
        try {
            Payment payment;
            if ("PayPal".equalsIgnoreCase(method)) {
                PayPalPayment paypal = new PayPalPayment();
                paypal.setCustomerName(request.getParameter("customerName"));
                paypal.setMobileNumber(request.getParameter("mobileNumber"));
                paypal.setEmail(request.getParameter("email"));
                paypal.setPaypalEmail(request.getParameter("paypalEmail"));
                paypal.setAmount(Double.parseDouble(request.getParameter("amount")));
                payment = paypal;
            } else {
                CardPayment card = new CardPayment();
                card.setCustomerName(request.getParameter("customerName"));
                card.setMobileNumber(request.getParameter("mobileNumber"));
                card.setEmail(request.getParameter("email"));
                card.setCardNumber(request.getParameter("cardNumber"));
                card.setCvv(request.getParameter("cvv"));
                card.setExpiryDate(request.getParameter("expiryDate"));
                card.setAmount(Double.parseDouble(request.getParameter("amount")));
                payment = card;
            }

            paymentService.createPayment(payment);
            response.sendRedirect(request.getContextPath() + "/payment");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/payment/form.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && !pathInfo.equals("/")) {
            String paymentNumber = pathInfo.substring(1);
            Payment payment = paymentService.getPaymentByNumber(paymentNumber);

            if (payment != null) {
                String body = request.getReader().lines().collect(Collectors.joining());
                String[] params = body.split("=");

                if (params.length == 2 && params[0].equals("paymentStatus")) {
                    String newStatus = params[1];
                    payment.setPaymentStatus(newStatus);
                    paymentService.updatePayment(payment);
                    response.setStatus(HttpServletResponse.SC_OK);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request parameters");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && !pathInfo.equals("/")) {
            String paymentNumber = pathInfo.substring(1);
            if (paymentService.deletePayment(paymentNumber)) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }
}