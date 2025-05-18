package handler;

import model.Booking;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BookingFileHandler {
    private static final String FILE_NAME = "C:\\Users\\ASUS\\OneDrive\\Desktop\\Tourism-Package-Customization-Platform\\it24100548_BookingComponent\\BookingComponent\\src\\main\\resources\\bookings.txt";

    // Add a new booking (append to file)
    public static void addBooking(Booking booking) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_NAME, true))) {
            writer.write(booking.toString()); // ✅ Includes address + totalPrice
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Get all bookings (read from file)
    public static List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_NAME))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Booking booking = Booking.fromString(line);
                if (booking != null) {
                    bookings.add(booking);
                } else {
                    System.err.println("⚠️ Skipped invalid booking record: " + line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Update a booking (by bookingId)
    public static void updateBooking(Booking updatedBooking) {
        List<Booking> bookings = getAllBookings();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_NAME))) {
            for (Booking booking : bookings) {
                if (booking.getBookingId().equals(updatedBooking.getBookingId())) {
                    writer.write(updatedBooking.toString()); // ✅ Writes updated address + totalPrice
                } else {
                    writer.write(booking.toString());
                }
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Delete a booking (by bookingId)
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

    // Generate a new unique Booking ID
    public static String generateBookingId() {
        List<Booking> bookings = getAllBookings(); // Load all bookings
        int maxId = 1000; // Start from 1000

        for (Booking b : bookings) {
            if (b == null) continue; // Safety: skip nulls
            String id = b.getBookingId();
            if (id.startsWith("BKG")) {
                try {
                    int num = Integer.parseInt(id.substring(3));
                    if (num > maxId) {
                        maxId = num;
                    }
                } catch (NumberFormatException e) {
                    // Skip if ID isn't in expected format
                }
            }
        }

        return "BKG" + (maxId + 1);
    }
}