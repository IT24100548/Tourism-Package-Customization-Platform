package model;

// solobooking is for individual bookings (1 person only)
public class SoloBooking extends Booking {

    // constructor that sets everything including total price
    public SoloBooking(String bookingId, String fullName, String phoneNumber, String address,
                       String gender, String email, String packageId, String bookingDate,
                       String status, String specialRequirements, double totalPrice) {
        // calls the parent constructor and sets number of people = 1
        super(bookingId, fullName, phoneNumber, address, gender, email,
                packageId, bookingDate, status, specialRequirements, 1); // solo = 1 person
        this.totalPrice = totalPrice; // sets the price directly (usually from file)
    }

    // overrides the abstract method from booking class
    @Override
    public double calculateTotalPrice(double basePrice) {
        // no discount, just return base price for 1 person
        this.totalPrice = basePrice;
        return totalPrice;
    }
}
