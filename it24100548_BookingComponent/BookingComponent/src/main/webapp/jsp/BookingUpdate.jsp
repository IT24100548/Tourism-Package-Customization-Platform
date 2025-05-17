<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Booking" %>
<html>
<head>
    <title>Update Booking</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body, html {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            color: #2c3e50;
            background: #f4f4f4;
        }

        .navbar-pro {
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-pro .logo {
            font-size: 20px;
            font-weight: bold;
            color: #2c3e50;
            text-decoration: none;
        }

        .navbar-pro .nav-links {
            display: flex;
            gap: 20px;
        }

        .navbar-pro .nav-links a {
            text-decoration: none;
            color: #3498db;
            font-size: 16px;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 6px;
            transition: background 0.3s, color 0.3s;
        }

        .navbar-pro .nav-links a:hover {
            background: #3498db;
            color: white;
        }

        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 40px 30px;
            max-width: 900px;
            margin: 50px auto;
        }

        .form-title {
            font-size: 24px;
            color: #2c3e50;
            font-weight: 600;
            text-align: center;
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 10px;
            border-bottom: 1px solid #eee;
            padding-bottom: 8px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 25px;
        }

        .form-field label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }

        .form-field input,
        .form-field select,
        .form-field textarea {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .form-field input:focus,
        .form-field select:focus,
        .form-field textarea:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52,152,219,0.1);
            outline: none;
        }

        .form-field textarea {
            min-height: 100px;
            resize: vertical;
        }

        .full-width {
            grid-column: span 2;
        }

        .form-footer {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
        }

        .cancel-btn {
            background: #95a5a6;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 500;
            transition: background 0.3s;
        }

        .cancel-btn:hover {
            background: #7f8c8d;
        }

        .submit-btn {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.3s;
        }

        .submit-btn:hover {
            background: #2980b9;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            .full-width {
                grid-column: span 1;
            }
        }
    </style>
</head>
<body>

<!-- Modern Navbar -->
<div class="navbar-pro">
    <a href="<%= request.getContextPath() %>/" class="logo">Booking Manager</a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/PackageListServlet">New Booking</a>
        <a href="<%= request.getContextPath() %>/BookingHistoryServlet">Booking History</a>
    </div>
</div>

<div class="card">
    <div class="form-title">
        Update Booking #<%= ((Booking) request.getAttribute("bookingToEdit")).getBookingId() %>
    </div>
    <%
        Booking booking = (Booking) request.getAttribute("bookingToEdit");
    %>
    <form action="<%= request.getContextPath() %>/BookingUpdateServlet" method="post">
        <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">

        <!-- Customer Information -->
        <div class="section-title">
            <i class="fas fa-user"></i> Customer Information
        </div>
        <div class="form-grid">

            <div class="form-field">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName"
                       value="<%= booking.getFullName() %>"
                       required
                       oninput="validateName(this)"
                       pattern="[A-Za-z\s]+"
                       title="Only letters and spaces allowed">
            </div>

            <script>
                function validateName(input) {
                    input.value = input.value.replace(/[^a-zA-Z\s]/g, '');
                }
            </script>

            <!-- Phone Number -->
            <div class="form-field">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber"
                       value="<%= booking.getPhoneNumber() %>"
                       required
                       oninput="validatePhone(this)"
                       pattern="^\+?[0-9\s]{7,15}$"
                       title="Only numbers, spaces, and optional '+' at the start">
            </div>

            <script>
                function validatePhone(input) {
                    input.value = input.value.replace(/[^0-9+\s]/g, '');
                }
            </script>

            <!-- Email -->
            <div class="form-field">
                <label for="email">Email</label>
                <input type="email" id="email" name="email"
                       value="<%= booking.getEmail() %>"
                       required
                       oninput="validateEmail(this)"
                       pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                       title="Enter a valid email address like you@example.com">
            </div>

            <script>
                function validateEmail(input) {
                    input.value = input.value.replace(/[^a-z0-9@._%+\-]/g, '');
                }
            </script>

            <div class="form-field">
                <label for="gender">Gender</label>
                <select id="gender" name="gender" required>
                    <option value="Male" <%= "Male".equals(booking.getGender()) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= "Female".equals(booking.getGender()) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= "Other".equals(booking.getGender()) ? "selected" : "" %>>Other</option>
                </select>
            </div>

            <div class="form-field full-width">
                <label for="address">Address</label>
                <input type="text" id="address" name="address"
                       value="<%= booking.getAddress() %>" required
                       oninput="validateAddress(this)"
                       pattern="[A-Za-z0-9\s,./\-#]{5,100}"
                       title="Only letters, numbers, spaces, commas, periods, slashes, dashes, and # allowed">
            </div>

            <script>
                function validateAddress(input) {
                    input.value = input.value.replace(/[^a-zA-Z0-9\s,./\-#]/g, '');
                }
            </script>

        </div>

        <!-- Booking Details -->
        <div class="section-title">
            <i class="fas fa-calendar-alt"></i> Booking Details
        </div>
        <div class="form-grid">
            <div class="form-field">
                <label for="packageName">Package</label>
                <select id="packageName" name="packageName" required>
                    <%= request.getAttribute("packageOptions") %>
                </select>
            </div>

            <div class="form-field">
                <label for="numberOfPeople">Number of People</label>
                <input type="number" id="numberOfPeople" name="numberOfPeople" min="1"
                       value="<%= booking.getNumberOfPeople() %>" required>
            </div>

            <div class="form-field">
                <label for="bookingDate">Booking Date</label>
                <input type="date" id="bookingDate" name="bookingDate"
                       value="<%= booking.getBookingDate() %>"
                       required min="<%= java.time.LocalDate.now() %>">
            </div>

            <div class="form-field full-width">
                <label for="specialRequirements">Special Requirements</label>
                <textarea id="specialRequirements" name="specialRequirements" rows="3"><%= booking.getSpecialRequirements() %></textarea>
            </div>

            <div class="form-field full-width">
                <label for="status">Status</label>
                <select id="status" name="status" required>
                    <option value="Confirmed" <%= "Confirmed".equals(booking.getStatus()) ? "selected" : "" %>>Confirmed</option>
                    <option value="Pending" <%= "Pending".equals(booking.getStatus()) ? "selected" : "" %>>Pending</option>
                    <option value="Cancelled" <%= "Cancelled".equals(booking.getStatus()) ? "selected" : "" %>>Cancelled</option>
                </select>
            </div>
        </div>

        <div class="form-footer">
            <a href="<%= request.getContextPath() %>/BookingHistoryServlet" class="cancel-btn">
                <i class="fas fa-times"></i> Cancel
            </a>
            <button type="submit" class="submit-btn">
                <i class="fas fa-save"></i> Update Booking
            </button>
        </div>
    </form>
</div>
</body>
</html>
