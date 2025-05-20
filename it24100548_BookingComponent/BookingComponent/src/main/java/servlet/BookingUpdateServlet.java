package servlet;

import handler.BookingFileHandler;
import model.Booking;
import model.SoloBooking;
import model.GroupBooking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/BookingUpdateServlet")
public class BookingUpdateServlet extends HttpServlet {
    private static final String PACKAGE_FILE =
            "C:\\Users\\ASUS\\OneDrive\\Desktop\\Tourism-Package-Customization-Platform\\it24100548_BookingComponent\\BookingComponent\\src\\main\\resources\\packages.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        Booking bookingToEdit = null;
        for (Booking b : BookingFileHandler.getAllBookings()) {
            if (b.getBookingId().equals(bookingId)) {
                bookingToEdit = b;
                break;
            }
        }
        if (bookingToEdit == null) {
            response.sendRedirect(request.getContextPath() + "/BookingHistoryServlet");
            return;
        }

        // Build package <option>s
        StringBuilder opts = new StringBuilder();
        try (BufferedReader rd = new BufferedReader(new FileReader(PACKAGE_FILE))) {
            String ln;
            while ((ln = rd.readLine()) != null) {
                String[] p = ln.split(",", 5);
                if (p.length >= 4) {
                    String name = p[1], price = p[3];
                    opts.append("<option value=\"")
                            .append(name).append("\"")
                            .append(name.equals(bookingToEdit.getPackageId()) ? " selected" : "")
                            .append(">")
                            .append(name).append(" – ").append(price)
                            .append("</option>");
                }
            }
        }

        request.setAttribute("bookingToEdit", bookingToEdit);
        request.setAttribute("packageOptions", opts.toString());
        request.getRequestDispatcher("/jsp/BookingUpdate.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get updated fields
        String bookingId = request.getParameter("bookingId");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String packageName = request.getParameter("packageName");
        String bookingDate = request.getParameter("bookingDate");
        String status = request.getParameter("status");
        String specialReq = request.getParameter("specialRequirements");
        int numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));
        String bookingType = request.getParameter("bookingType");

        // Look up price per unit
        double pricePerUnit = 0;
        try (BufferedReader rd = new BufferedReader(new FileReader(PACKAGE_FILE))) {
            String ln;
            while ((ln = rd.readLine()) != null) {
                String[] p = ln.split(",", 5);
                if (p.length >= 4 && p[1].equals(packageName)) {
                    pricePerUnit = Double.parseDouble(p[3]);
                    break;
                }
            }
        }

        // Create updated booking object based on type
        Booking updatedBooking;
        if ("solo".equalsIgnoreCase(bookingType)) {
            updatedBooking = new SoloBooking(
                    bookingId, fullName, phoneNumber, address, gender,
                    email, packageName, bookingDate, status, specialReq, 0
            );
        } else {
            updatedBooking = new GroupBooking(
                    bookingId, fullName, phoneNumber, address, gender,
                    email, packageName, bookingDate, status, specialReq, numberOfPeople, 0
            );
        }

        // Recalculate total price
        double totalPrice = updatedBooking.calculateTotalPrice(pricePerUnit);
        updatedBooking.setTotalPrice(totalPrice);

        // Replace booking in file
        BookingFileHandler.updateBooking(updatedBooking);

        // Forward success response
        request.setAttribute("newTotalPrice", totalPrice);
        request.setAttribute("success", true);
        request.setAttribute("fullName", fullName);
        request.getRequestDispatcher("/jsp/bookingSuccess.jsp").forward(request, response);
    }
}
