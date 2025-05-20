package servlet;

import handler.BookingFileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/BookingDeleteServlet")
public class BookingDeleteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingId = request.getParameter("bookingId");

        // Delete the booking
        BookingFileHandler.deleteBooking(bookingId);

        // Forward to confirmation JSP
        request.getRequestDispatcher("/jsp/bookingDeleted.jsp").forward(request, response);
    }
}
