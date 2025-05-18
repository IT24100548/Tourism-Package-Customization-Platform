package servlet;

import handler.BookingFileHandler;
import model.Booking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/BookingHistoryServlet")
public class BookingHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Booking> bookings = BookingFileHandler.getAllBookings();
        request.setAttribute("bookingsList", bookings);

        // ✅ Forward to the JSP page to render the table
        request.getRequestDispatcher("/jsp/BookingHistory.jsp").forward(request, response);
    }
}
