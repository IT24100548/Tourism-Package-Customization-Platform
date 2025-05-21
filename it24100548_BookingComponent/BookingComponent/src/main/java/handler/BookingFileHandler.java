package handler;

import model.Booking;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BookingFileHandler {
    // path to the file all bookings
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

    // method to read and return all bookings from file
    public static List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_NAME))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Booking booking = Booking.fromString(line); // convert line back to object
                if (booking != null) {
                    bookings.add(booking); // add valid booking to list
                } else {
                    System.err.println("skipped invalid booking record: " + line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return bookings; // return the list bookings
    }

    // method to update an existing booking
    public static void updateBooking(Booking updatedBooking) {
        List<Booking> bookings = getAllBookings(); // get current list
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_NAME))) {
            for (Booking booking : bookings) {
                if (booking.getBookingId().equals(updatedBooking.getBookingId())) {
                    // write updated booking if id matches
                    writer.write(updatedBooking.toString());
                } else {
                    // otherwise write the original booking
                    writer.write(booking.toString());
                }
                writer.newLine(); // make sure each booking is on its own line
            }
        } catch (IOException e) {
            e.printStackTrace(); // show file error if any
        }
    }

    // method to delete a booking by id
    public static void deleteBooking(String bookingId) {
        List<Booking> bookings = getAllBookings(); // get all bookings
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_NAME))) {
            for (Booking booking : bookings) {
                if (!booking.getBookingId().equals(bookingId)) {
                    // write only those bookings which don't match the id
                    writer.write(booking.toString());
                    writer.newLine();
                }
                // if it matches, we skip it = it's deleted
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // method to generate a new unique booking id
    public static String generateBookingId() {
        List<Booking> bookings = getAllBookings(); // load current bookings
        int maxId = 1000; // start from 1000 (or whatever base you want)

        for (Booking b : bookings) {
            if (b == null) continue; // skip if null (just in case)
            String id = b.getBookingId();
            if (id.startsWith("BKG")) {
                try {
                    // extract the number part and compare
                    int num = Integer.parseInt(id.substring(3));
                    if (num > maxId) {
                        maxId = num;
                    }
                } catch (NumberFormatException e) {
                    // ignore invalid ids like "BKGabc"
                }
            }
        }

        // generate next id like BKG1001, BKG1002, etc.
        return "BKG" + (maxId + 1);
    }
}
