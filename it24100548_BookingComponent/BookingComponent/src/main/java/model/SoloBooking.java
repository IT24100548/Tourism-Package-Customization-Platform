package model;

public class SoloBooking extends Booking {

    public SoloBooking(String bookingId, String fullName, String phoneNumber, String address,
                       String gender, String email, String packageId, String bookingDate,
                       String status, String specialRequirements, double totalPrice) {
        super(bookingId, fullName, phoneNumber, address, gender, email,
                packageId, bookingDate, status, specialRequirements, 1); // solo = 1 person
        this.totalPrice = totalPrice;
    }

    @Override
    public double calculateTotalPrice(double basePrice) {
        this.totalPrice = basePrice;
        return totalPrice;
    }
}
