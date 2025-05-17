<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, model.Booking" %>
<html>
<head>
    <title>Booking Management</title>
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

        .dashboard {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        h1 {
            margin-bottom: 40px;
            text-align: center;
        }

        .stats-container {
            display: flex;
            gap: 20px;
            margin-bottom: 50px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .stat-card {
            flex: 1;
            min-width: 220px;
            background: white;
            border-radius: 10px;
            padding: 30px 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            text-align: center;
            border-top: 4px solid transparent;
        }

        .stat-total { border-top-color: #2c3e50; }
        .stat-confirmed { border-top-color: #27ae60; }
        .stat-pending { border-top-color: #f39c12; }
        .stat-cancelled { border-top-color: #e74c3c; }

        .stat-value {
            font-size: 32px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 8px;
        }

        .stat-label {
            font-size: 16px;
            color: #7f8c8d;
        }

        .booking-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .booking-table th {
            background-color: #f8f9fa;
            padding: 18px;
            text-align: left;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #ecf0f1;
        }

        .booking-table td {
            padding: 18px;
            border-bottom: 1px solid #ecf0f1;
            vertical-align: middle;
        }

        .booking-table tr:hover {
            background-color: #f8f9fa;
        }

        .status {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-confirmed {
            background-color: #d5f5e3;
            color: #27ae60;
        }

        .status-pending {
            background-color: #fef9e7;
            color: #f39c12;
        }

        .status-cancelled {
            background-color: #fadbd8;
            color: #e74c3c;
        }

        .action-btn {
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            border: none;
            margin-right: 6px;
        }

        .edit-btn {
            background-color: #3498db;
            color: white;
        }

        .delete-btn {
            background-color: #e74c3c;
            color: white;
        }

        .customer-cell {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .customer-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background-color: #3498db;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 18px;
        }

        .customer-info {
            line-height: 1.5;
        }

        .customer-name {
            font-weight: 500;
        }

        .customer-phone, .customer-email, .customer-address {
            font-size: 13px;
            color: #7f8c8d;
            margin-top: 2px;
        }

        .customer-phone i, .customer-email i, .customer-address i {
            margin-right: 5px;
            color: #3498db;
        }

        .customer-allergy {
            font-size: 13px;
            color: #e74c3c; /* red color */
            margin-top: 2px;
            font-weight: 500;
        }

        .customer-allergy i {
            margin-right: 5px;
            color: #e74c3c;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar-pro">
    <a href="<%= request.getContextPath() %>/" class="logo">Booking Manager</a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/PackageListServlet">New Booking</a>
        <a href="<%= request.getContextPath() %>/BookingHistoryServlet">Booking History</a>
    </div>
</div>

<div class="dashboard">
    <h1>Booking Management</h1>

    <%
        List<Booking> bookings = (List<Booking>) request.getAttribute("bookingsList");
        int totalBookings = 0;
        int confirmedCount = 0;
        int pendingCount = 0;
        int cancelledCount = 0;

        if (bookings != null) {
            totalBookings = bookings.size();
            for (Booking bk : bookings) {
                String status = bk.getStatus().toLowerCase();
                if (status.equals("confirmed")) {
                    confirmedCount++;
                } else if (status.equals("pending")) {
                    pendingCount++;
                } else if (status.equals("cancelled")) {
                    cancelledCount++;
                }
            }
        }
    %>

    <div class="stats-container">
        <div class="stat-card stat-total">
            <div class="stat-value"><%= totalBookings %></div>
            <div class="stat-label">Total Bookings</div>
        </div>
        <div class="stat-card stat-confirmed">
            <div class="stat-value"><%= confirmedCount %></div>
            <div class="stat-label">Confirmed</div>
        </div>
        <div class="stat-card stat-pending">
            <div class="stat-value"><%= pendingCount %></div>
            <div class="stat-label">Pending</div>
        </div>
        <div class="stat-card stat-cancelled">
            <div class="stat-value"><%= cancelledCount %></div>
            <div class="stat-label">Cancelled</div>
        </div>
    </div>

    <table class="booking-table">
        <thead>
        <tr>
            <th>Booking ID</th>
            <th>Customer</th>
            <th>Package</th>
            <th>Booking Date</th>
            <th>People</th>
            <th>Total</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (bookings != null && !bookings.isEmpty()) {
                for (Booking bk : bookings) {
                    String initials = bk.getFullName().substring(0, 1).toUpperCase();
                    if (bk.getFullName().contains(" ")) {
                        initials += bk.getFullName().substring(bk.getFullName().indexOf(" ") + 1, bk.getFullName().indexOf(" ") + 2).toUpperCase();
                    }
                    String statusClass = "status-" + bk.getStatus().toLowerCase();
        %>
        <tr>
            <td>#<%= bk.getBookingId() %></td>
            <td>
                <div class="customer-cell">
                    <div class="customer-avatar"><%= initials %></div>
                    <div class="customer-info">
                        <div class="customer-name"><%= bk.getFullName() %></div>
                        <div class="customer-phone"><i class="fas fa-phone"></i> <%= bk.getPhoneNumber() %></div>
                        <div class="customer-address"><i class="fas fa-home"></i> <%= bk.getAddress() %></div>
                        <div class="customer-email"><i class="fas fa-envelope"></i> <%= bk.getEmail() %></div>
                        <% if (bk.getSpecialRequirements() != null && !bk.getSpecialRequirements().trim().isEmpty()) { %>
                        <div class="customer-allergy"><i class="fas fa-exclamation-triangle"></i> <%= bk.getSpecialRequirements() %></div>
                        <% } %>
                    </div>
                </div>
            </td>
            <td><%= bk.getPackageId() %></td>
            <td><%= bk.getBookingDate() %></td>
            <td><%= bk.getNumberOfPeople() %></td>
            <td>Rs.<%= bk.getTotalPrice() %></td>
            <td><span class="status <%= statusClass %>"><%= bk.getStatus() %></span></td>
            <td>
                <form action="<%= request.getContextPath() %>/BookingUpdateServlet" method="get" style="display: inline;">
                    <input type="hidden" name="bookingId" value="<%= bk.getBookingId() %>"/>
                    <button type="submit" class="action-btn edit-btn">Edit</button>
                </form>
                <form action="<%= request.getContextPath() %>/BookingDeleteServlet" method="post"
                      onsubmit="return confirm('Delete this booking?');" style="display: inline;">
                    <input type="hidden" name="bookingId" value="<%= bk.getBookingId() %>"/>
                    <button type="submit" class="action-btn delete-btn">Delete</button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="8" style="text-align: center; padding: 30px; color: #95a5a6;">
                No bookings found
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
