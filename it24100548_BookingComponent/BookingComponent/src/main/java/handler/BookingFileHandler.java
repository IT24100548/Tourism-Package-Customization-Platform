package handler;

import model.Booking;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BookingFileHandler {
    // booking file path
    private static final String FILE_NAME = "C:\\Users\\ASUS\\OneDrive\\Desktop\\Tourism-Package-Customization-Platform\\it24100548_BookingComponent\\BookingComponent\\src\\main\\resources\\bookings.txt";

    // method to add a new booking
    public static void addBooking(Booking booking) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_NAME, true))) {
            writer.write(booking.toString()); // convert object to string
            writer.newLine(); // add new line
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // read and return all bookings from file
    public static List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_NAME))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Booking booking = Booking.fromString(line); // convert line to object
                if (booking != null) {
                    bookings.add(booking);
                } else {
                    System.err.println("skipped invalid booking record: " + line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return bookings; // return the list bookings
    }

    // method to update booking
    public static void updateBooking(Booking updatedBooking) {
        List<Booking> bookings = getAllBookings(); // get current list
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_NAME))) {
            for (Booking booking : bookings) {
                if (booking.getBookingId().equals(updatedBooking.getBookingId())) {
                    writer.write(updatedBooking.toString());
                } else {
                    writer.write(booking.toString());
                }
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void deleteBooking(String bookingId) {
        List<Booking> bookings = getAllBookings();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_NAME))) {
            for (Booking booking : bookings) {
                if (!booking.getBookingId().equals(bookingId)) {
                    writer.write(booking.toString());
                    writer.newLine();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // method to generate booking number
    public static String generateBookingId() {
        List<Booking> bookings = getAllBookings();
        int maxId = 1000;

        for (Booking b : bookings) {
            if (b == null) continue;
            String id = b.getBookingId();
            if (id.startsWith("BKG")) {
                try {
                    int num = Integer.parseInt(id.substring(3));
                    if (num > maxId) {
                        maxId = num;
                    }
                } catch (NumberFormatException e) {

                }
            }
        }

        return "BKG" + (maxId + 1);
    }
}
