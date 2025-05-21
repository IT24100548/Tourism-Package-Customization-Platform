package model;

// groupbooking is a subclass of booking for group travelers
public class GroupBooking extends Booking {
    // gives 10% discount for group bookings
    private double discountRate = 0.10; // 10% group discount

    // constructor that sets all values (including total price)
    public GroupBooking(String bookingId, String fullName, String phoneNumber, String address,
                        String gender, String email, String packageId, String bookingDate,
                        String status, String specialRequirements, int numberOfPeople, double totalPrice) {
        // call the parent (booking) constructor
        super(bookingId, fullName, phoneNumber, address, gender, email,
                packageId, bookingDate, status, specialRequirements, numberOfPeople);
        // set total price directly (usually when loading from file)
        this.totalPrice = totalPrice;
    }

    // this method overrides the abstract method in booking class
    @Override
    public double calculateTotalPrice(double basePrice) {
        // first calculate the full price for everyone
        double gross = basePrice * numberOfPeople;
        // then apply group discount
        this.totalPrice = gross - (gross * discountRate);
        return totalPrice;
    }
}
