package model;

public class SoloBooking extends Booking {

    // constructor
    public SoloBooking(String bookingId, String fullName, String phoneNumber, String address,
                       String gender, String email, String packageId, String bookingDate,
                       String status, String specialRequirements, double totalPrice) {
        // calls the parent constructor
        super(bookingId, fullName, phoneNumber, address, gender, email,
                packageId, bookingDate, status, specialRequirements, 1);
        this.totalPrice = totalPrice;
    }

    // overrides the abstract method
    @Override
    public double calculateTotalPrice(double basePrice) {
        this.totalPrice = basePrice;
        return totalPrice;
    }
}
