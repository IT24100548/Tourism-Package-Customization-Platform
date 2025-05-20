package model;

public class GroupBooking extends Booking {
    private double discountRate = 0.10; // 10% group discount

    public GroupBooking(String bookingId, String fullName, String phoneNumber, String address,
                        String gender, String email, String packageId, String bookingDate,
                        String status, String specialRequirements, int numberOfPeople, double totalPrice) {
        super(bookingId, fullName, phoneNumber, address, gender, email,
                packageId, bookingDate, status, specialRequirements, numberOfPeople);
        this.totalPrice = totalPrice;
    }

    @Override
    public double calculateTotalPrice(double basePrice) {
        double gross = basePrice * numberOfPeople;
        this.totalPrice = gross - (gross * discountRate);
        return totalPrice;
    }
}
