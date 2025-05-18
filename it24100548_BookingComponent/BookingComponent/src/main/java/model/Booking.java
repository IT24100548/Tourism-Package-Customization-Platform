package model;

public abstract class Booking {
    protected String bookingId;
    protected String fullName;
    protected String phoneNumber;
    protected String address;
    protected String gender;
    protected String email;
    protected String packageId;
    protected String bookingDate;
    protected String status;
    protected String specialRequirements;
    protected int numberOfPeople;
    protected double totalPrice;

    public Booking(String bookingId, String fullName, String phoneNumber, String address,
                   String gender, String email, String packageId, String bookingDate,
                   String status, String specialRequirements, int numberOfPeople) {
        this.bookingId = bookingId;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.gender = gender;
        this.email = email;
        this.packageId = packageId;
        this.bookingDate = bookingDate;
        this.status = status;
        this.specialRequirements = (specialRequirements == null ? "" : specialRequirements);
        this.numberOfPeople = numberOfPeople;
    }

    // Abstract method to be overridden
    public abstract double calculateTotalPrice(double basePrice);

    // Getters and Setters
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

    // Serialize to string (first token is the class name)
    @Override
    public String toString() {
        return String.join("|",
                this.getClass().getSimpleName(),  // SoloBooking or GroupBooking
                bookingId, fullName, phoneNumber, address, gender,
                email, packageId, bookingDate, status,
                specialRequirements,
                String.valueOf(numberOfPeople),
                String.valueOf(totalPrice)
        );
    }

    // Deserialize from string (factory method)
    public static Booking fromString(String line) {
        String[] parts = line.split("\\|", -1);
        if (parts.length != 13) {
            System.err.println("Invalid booking record (expected 13 fields): " + line);
            return null;
        }

        String type = parts[0];
        try {
            String bookingId = parts[1];
            String fullName = parts[2];
            String phoneNumber = parts[3];
            String address = parts[4];
            String gender = parts[5];
            String email = parts[6];
            String packageId = parts[7];
            String bookingDate = parts[8];
            String status = parts[9];
            String specialRequirements = parts[10];
            int numberOfPeople = Integer.parseInt(parts[11]);
            double totalPrice = Double.parseDouble(parts[12]);

            if (type.equals("SoloBooking")) {
                return new SoloBooking(bookingId, fullName, phoneNumber, address, gender, email,
                        packageId, bookingDate, status, specialRequirements, totalPrice);
            } else if (type.equals("GroupBooking")) {
                return new GroupBooking(bookingId, fullName, phoneNumber, address, gender, email,
                        packageId, bookingDate, status, specialRequirements, numberOfPeople, totalPrice);
            } else {
                System.err.println("Unknown booking type: " + type);
                return null;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
