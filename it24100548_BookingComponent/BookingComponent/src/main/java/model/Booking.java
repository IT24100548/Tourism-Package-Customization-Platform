package model;

public class Booking {
    private String bookingId;
    private String fullName;
    private String phoneNumber;
    private String address;
    private String gender;
    private String email;
    private String packageId;
    private String bookingDate;
    private String status;
    private String specialRequirements;  // new, optional
    private int numberOfPeople;
    private double totalPrice;

    public Booking(
            String bookingId,
            String fullName,
            String phoneNumber,
            String address,
            String gender,
            String email,
            String packageId,
            String bookingDate,
            String status,
            String specialRequirements,
            int numberOfPeople,
            double totalPrice
    ) {
        this.bookingId = bookingId;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.gender = gender;
        this.email = email;
        this.packageId = packageId;
        this.bookingDate = bookingDate;
        this.status = status;
        // avoid null
        this.specialRequirements = (specialRequirements == null ? "" : specialRequirements);
        this.numberOfPeople = numberOfPeople;
        this.totalPrice = totalPrice;
    }

    // --- ALL GETTERS & SETTERS ---

    public String getBookingId() { return bookingId; }
    public void setBookingId(String bookingId) { this.bookingId = bookingId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPackageId() { return packageId; }
    public void setPackageId(String packageId) { this.packageId = packageId; }

    public String getBookingDate() { return bookingDate; }
    public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getSpecialRequirements() { return specialRequirements; }
    public void setSpecialRequirements(String specialRequirements) {
        this.specialRequirements = (specialRequirements == null ? "" : specialRequirements);
    }

    public int getNumberOfPeople() { return numberOfPeople; }
    public void setNumberOfPeople(int numberOfPeople) { this.numberOfPeople = numberOfPeople; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    // --- Pipe-separated Serialization/Deserialization ---

    @Override
    public String toString() {
        // No need to sanitize commas now because we're using |
        return String.join("|",
                bookingId,
                fullName,
                phoneNumber,
                address,
                gender,
                email,
                packageId,
                bookingDate,
                status,
                (specialRequirements == null ? "" : specialRequirements),
                String.valueOf(numberOfPeople),
                String.valueOf(totalPrice)
        );
    }

    public static Booking fromString(String line) {
        // Expect exactly 12 columns separated by |
        String[] parts = line.split("\\|", -1);  // <- updated delimiter
        if (parts.length != 12) {
            System.err.println("⚠️ Invalid booking record (expected 12 fields): " + line);
            return null;
        }
        try {
            return new Booking(
                    parts[0],                // bookingId
                    parts[1],                // fullName
                    parts[2],                // phoneNumber
                    parts[3],                // address
                    parts[4],                // gender
                    parts[5],                // email
                    parts[6],                // packageId
                    parts[7],                // bookingDate
                    parts[8],                // status
                    parts[9],                // specialRequirements
                    Integer.parseInt(parts[10]),  // numberOfPeople
                    Double.parseDouble(parts[11]) // totalPrice
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
