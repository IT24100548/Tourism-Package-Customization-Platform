package servlet;

import handler.BookingFileHandler;
import model.Booking;
import model.SoloBooking;
import model.GroupBooking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.time.LocalDate;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final String PACKAGE_FILE =
            "C:\\Users\\ASUS\\OneDrive\\Desktop\\Tourism-Package-Customization-Platform\\it24100548_BookingComponent\\BookingComponent\\src\\main\\resources\\packages.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String packageName = request.getParameter("packageName");
        String specialReq = request.getParameter("specialRequirements");
        String bookingType = request.getParameter("bookingType");  // NEW
        int numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));

        // Generate ID & date
        String bookingId = BookingFileHandler.generateBookingId();
        String bookingDate = request.getParameter("bookingDate");
        String status = "Pending";

        // Lookup price per unit
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

        // --- Create Booking object dynamically based on type ---
        Booking booking;
        if ("solo".equalsIgnoreCase(bookingType)) {
            booking = new SoloBooking(
                    bookingId, fullName, phoneNumber, address, gender,
                    email, packageName, bookingDate, status, specialReq, 0
            );
        } else {
            booking = new GroupBooking(
                    bookingId, fullName, phoneNumber, address, gender,
                    email, packageName, bookingDate, status, specialReq, numberOfPeople, 0
            );
        }

        booking.calculateTotalPrice(pricePerUnit);

        BookingFileHandler.addBooking(booking);

        String source = request.getParameter("source");

        if ("user".equals(source)) {
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("success");
        } else {
            request.setAttribute("newTotalPrice", booking.getTotalPrice());
            request.setAttribute("success", true);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("/jsp/bookingSuccess.jsp").forward(request, response);
        }


    }
}
