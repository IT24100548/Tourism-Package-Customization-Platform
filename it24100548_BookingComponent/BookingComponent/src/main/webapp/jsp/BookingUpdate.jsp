<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Booking" %>
<html>
<head>
    <title>Update Booking</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #eef2ff;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --dark: #1f2937;
            --light: #f9fafb;
            --gray: #6b7280;
            --gray-light: #f3f4f6;
            --border-radius: 12px;
            --shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body, html {
            font-family: 'Inter', sans-serif;
            background: var(--gray-light);
            color: var(--dark);
        }
        .navbar-pro {
            background: white;
            box-shadow: var(--shadow);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 32px;
            position: sticky;
            top: 0;
            z-index: 50;
        }
        .navbar-pro .logo {
            font-size: 20px;
            font-weight: 700;
            color: var(--primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .nav-links {
            display: flex;
            gap: 24px;
        }
        .nav-links a {
            font-size: 15px;
            font-weight: 500;
            color: var(--gray);
            text-decoration: none;
            transition: all 0.2s ease;
            padding: 8px 0;
            position: relative;
        }
        .nav-links a:hover {
            color: var(--primary);
        }
        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary);
            transition: width 0.3s ease;
        }
        .nav-links a:hover::after {
            width: 100%;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 40px;
        }
        .form-title {
            text-align: center;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 32px;
        }
        .section-title {
            font-size: 18px;
            font-weight: 600;
            margin: 32px 0 20px;
            padding-bottom: 8px;
            border-bottom: 1px solid var(--gray-light);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .section-title i { color: var(--primary); font-size: 16px; }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
        .form-field { margin-bottom: 16px; }
        .form-field label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--gray);
        }
        .form-field input, .form-field select, .form-field textarea {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--gray-light);
            border-radius: 8px;
            font-size: 15px;
            background-color: white;
        }
        .form-field textarea { min-height: 100px; resize: vertical; }
        .form-footer {
            display: flex;
            justify-content: flex-end;
            gap: 16px;
            margin-top: 32px;
            padding-top: 24px;
            border-top: 1px solid var(--gray-light);
        }
        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn i { font-size: 14px; }
        .cancel-btn {
            background-color: white;
            color: var(--gray);
            border: 1px solid var(--gray-light);
        }
        .cancel-btn:hover { background-color: var(--gray-light); }
        .submit-btn {
            background-color: var(--primary);
            color: white;
            border: none;
        }
        .submit-btn:hover { background-color: #3a56d4; }
        @media (max-width: 768px) {
            .form-footer { flex-direction: column-reverse; gap: 12px; }
            .btn { width: 100%; justify-content: center; }
        }
    </style>
</head>
<body>

<div class="navbar-pro">
    <a href="<%= request.getContextPath() %>/" class="logo">
        <i class="fas fa-calendar-alt"></i> Booking Manager
    </a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/PackageListServlet">
            <i class="fas fa-plus-circle"></i> New Booking
        </a>
        <a href="<%= request.getContextPath() %>/BookingHistoryServlet">
            <i class="fas fa-history"></i> Booking History
        </a>
    </div>

</div>

<div class="container">
    <div class="card">
        <div class="form-title">
            Update Booking #<%= ((Booking) request.getAttribute("bookingToEdit")).getBookingId() %>
        </div>
        <%
            Booking booking = (Booking) request.getAttribute("bookingToEdit");
            String bookingType = booking.getNumberOfPeople() == 1 ? "solo" : "group";
        %>
        <form action="<%= request.getContextPath() %>/BookingUpdateServlet" method="post">
            <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">

            <div class="section-title"><i class="fas fa-user"></i> Customer Information</div>
            <div class="form-grid">
                <div class="form-field">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" value="<%= booking.getFullName() %>" required placeholder="John Doe">
                </div>
                <div class="form-field">
                    <label for="phoneNumber">Phone Number</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" value="<%= booking.getPhoneNumber() %>" required placeholder="+94 712345678">
                </div>
                <div class="form-field">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="<%= booking.getEmail() %>" required placeholder="you@example.com">
                </div>
                <div class="form-field">
                    <label for="gender">Gender</label>
                    <select id="gender" name="gender" required>
                        <option value="Male" <%= "Male".equals(booking.getGender()) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(booking.getGender()) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equals(booking.getGender()) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                <div class="form-field">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" value="<%= booking.getAddress() %>" required placeholder="123 Main Street">
                </div>
            </div>

            <div class="section-title"><i class="fas fa-calendar-alt"></i> Booking Details</div>
            <div class="form-grid">
                <div class="form-field">
                    <label for="packageName">Package</label>
                    <select id="packageName" name="packageName" required>
                        <%= request.getAttribute("packageOptions") %>
                    </select>
                </div>
                <div class="form-field">
                    <label for="bookingType">Booking Type</label>
                    <select id="bookingType" name="bookingType" onchange="togglePeopleInput()">
                        <option value="solo" <%= "solo".equals(bookingType) ? "selected" : "" %>>Solo</option>
                        <option value="group" <%= "group".equals(bookingType) ? "selected" : "" %>>Group</option>
                    </select>
                </div>
                <div class="form-field">
                    <label for="numberOfPeople">Number of People</label>
                    <input type="number" id="numberOfPeople" name="numberOfPeople" min="1" value="<%= booking.getNumberOfPeople() %>" required placeholder="1">
                </div>
                <div class="form-field">
                    <label for="bookingDate">Booking Date</label>
                    <input type="date" id="bookingDate" name="bookingDate" value="<%= booking.getBookingDate() %>" required min="<%= java.time.LocalDate.now() %>">
                </div>
                <div class="form-field">
                    <label for="specialRequirements">Special Requirements</label>
                    <textarea id="specialRequirements" name="specialRequirements" placeholder="Any special notes..."><%= booking.getSpecialRequirements() %></textarea>
                </div>
                <div class="form-field">
                    <label for="status">Status</label>
                    <select id="status" name="status" required>
                        <option value="Confirmed" <%= "Confirmed".equals(booking.getStatus()) ? "selected" : "" %>>Confirmed</option>
                        <option value="Pending" <%= "Pending".equals(booking.getStatus()) ? "selected" : "" %>>Pending</option>
                        <option value="Cancelled" <%= "Cancelled".equals(booking.getStatus()) ? "selected" : "" %>>Cancelled</option>
                    </select>
                </div>
            </div>

            <div class="form-footer">
                <a href="<%= request.getContextPath() %>/BookingHistoryServlet" class="btn cancel-btn"><i class="fas fa-times"></i> Cancel</a>
                <button type="submit" class="btn submit-btn"><i class="fas fa-save"></i> Update Booking</button>
            </div>
        </form>
    </div>
</div>

<script>
    function togglePeopleInput() {
        const type = document.getElementById("bookingType").value;
        const nop = document.getElementById("numberOfPeople");
        if (type === "solo") {
            nop.value = 1;
            nop.readOnly = true;
        } else {
            nop.readOnly = false;
        }
    }
    document.addEventListener("DOMContentLoaded", togglePeopleInput);
</script>

</body>
</html>
