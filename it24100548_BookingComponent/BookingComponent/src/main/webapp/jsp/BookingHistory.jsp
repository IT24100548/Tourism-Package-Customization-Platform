<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, model.Booking" %>

<html>
<head>
    <title>Booking Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #eef2ff;
            --success: #10b981;
            --success-light: #d1fae5;
            --warning: #f59e0b;
            --warning-light: #fef3c7;
            --danger: #ef4444;
            --danger-light: #fee2e2;
            --dark: #1f2937;
            --light: #f9fafb;
            --gray: #6b7280;
            --gray-light: #f3f4f6;
            --border-radius: 12px;
            --shadow-sm: 0 1px 2px 0 rgba(0,0,0,0.05);
            --shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
            --shadow-md: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05);
        }
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body, html {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--gray-light);
            color: var(--dark);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
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

        .logo-icon {
            color: var(--primary);
            font-size: 22px;
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

        .dashboard {
            max-width: 1400px;
            margin: 0 auto;
            padding: 32px;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--dark);
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
        }

        .stat-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 24px;
            box-shadow: var(--shadow-sm);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border-left: 4px solid transparent;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        .stat-total { border-left-color: var(--primary); }
        .stat-confirmed { border-left-color: var(--success); }
        .stat-pending { border-left-color: var(--warning); }
        .stat-cancelled { border-left-color: var(--danger); }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 8px;
            color: var(--dark);
        }

        .stat-label {
            font-size: 14px;
            color: var(--gray);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .stat-icon {
            font-size: 16px;
        }

        .booking-table-container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
        }

        .booking-table {
            width: 100%;
            border-collapse: collapse;
        }

        .booking-table th, .booking-table td {
            padding: 16px 20px;
            text-align: left;
            border-bottom: 1px solid var(--gray-light);
        }

        .booking-table th {
            background-color: var(--light);
            font-weight: 600;
            color: var(--gray);
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }

        .booking-table tr:last-child td {
            border-bottom: none;
        }

        .booking-table tr:hover td {
            background-color: var(--primary-light);
        }

        .status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
        }

        .status-confirmed { background: var(--success-light); color: var(--success); }
        .status-pending { background: var(--warning-light); color: var(--warning); }
        .status-cancelled { background: var(--danger-light); color: var(--danger); }

        .status-icon {
            font-size: 12px;
        }

        .action-btns {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            padding: 8px 14px;
            font-size: 13px;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .action-btn i {
            font-size: 12px;
        }

        .edit-btn {
            background-color: var(--primary);
            color: white;
        }

        .edit-btn:hover {
            background-color: #3a56d4;
        }

        .delete-btn {
            background-color: var(--danger);
            color: white;
        }

        .delete-btn:hover {
            background-color: #dc2626;
        }

        .customer-cell {
            display: block;
            padding-left: 0;
        }


        .customer-avatar {
            width: 40px;
            height: 40px;
            background-color: var(--primary);
            color: white;
            font-weight: 600;
            font-size: 16px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .customer-info {
            line-height: 1.5;
        }

        .customer-name {
            font-weight: 600;
            margin-bottom: 2px;
        }

        .customer-detail {
            font-size: 13px;
            color: var(--gray);
            display: flex;
            align-items: center;
            gap: 6px;
            margin-top: 4px;
        }

        .customer-detail i {
            width: 16px;
            color: var(--gray);
            font-size: 12px;
        }

        .customer-allergy {
            color: var(--danger);
            font-weight: 500;
            font-size: 13px;
            margin-top: 4px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .booking-type-badge {
            padding: 4px 10px;
            background-color: var(--primary-light);
            color: var(--primary);
            border-radius: 10px;
            font-size: 13px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
        }

        .empty-state {
            padding: 48px 20px;
            text-align: center;
            color: var(--gray);
        }

        .empty-icon {
            font-size: 48px;
            color: var(--gray-light);
            margin-bottom: 16px;
        }

        .empty-text {
            font-size: 16px;
            margin-bottom: 16px;
        }

        .new-booking-btn {
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 6px;
            padding: 10px 20px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .new-booking-btn:hover {
            background-color: #3a56d4;
        }

        .price {
            font-weight: 600;
            color: var(--dark);
        }

        @media (max-width: 1024px) {
            .dashboard {
                padding: 24px 16px;
            }

            .booking-table th, .booking-table td {
                padding: 12px 16px;
            }

            .customer-cell {
                flex-direction: column;
                gap: 8px;
            }

            .action-btns {
                flex-direction: column;
                gap: 6px;
            }
        }

        @media (max-width: 768px) {
            .navbar-pro {
                padding: 16px;
                flex-direction: column;
                gap: 16px;
            }

            .nav-links {
                gap: 16px;
            }

            .stats-container {
                grid-template-columns: 1fr 1fr;
            }

            .booking-table-container {
                overflow-x: auto;
            }
        }
    </style>

</head>
<body>

<div class="navbar-pro">
    <a href="<%= request.getContextPath() %>/" class="logo">
        <i class="fas fa-calendar-alt logo-icon"></i>
        <span>Booking Manager</span>
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

<div class="dashboard">
    <div class="dashboard-header">
        <h1><i class="fas fa-calendar-check"></i> Booking Management</h1>
        <a href="<%= request.getContextPath() %>/PackageListServlet" class="new-booking-btn">
            <i class="fas fa-plus"></i> New Booking
        </a>
    </div>

    <%
        List<Booking> bookings = (List<Booking>) request.getAttribute("bookingsList");
        int totalBookings = 0, confirmedCount = 0, pendingCount = 0, cancelledCount = 0;
        if (bookings != null) {
            totalBookings = bookings.size();
            for (Booking bk : bookings) {
                String status = bk.getStatus().toLowerCase();
                if ("confirmed".equals(status)) confirmedCount++;
                else if ("pending".equals(status)) pendingCount++;
                else if ("cancelled".equals(status)) cancelledCount++;
            }
        }
    %>

    <div class="stats-container">
        <div class="stat-card stat-total">
            <div class="stat-value"><%= totalBookings %></div>
            <div class="stat-label">
                <i class="fas fa-calendar stat-icon"></i> Total Bookings
            </div>
        </div>
        <div class="stat-card stat-confirmed">
            <div class="stat-value"><%= confirmedCount %></div>
            <div class="stat-label">
                <i class="fas fa-check-circle stat-icon"></i> Confirmed
            </div>
        </div>
        <div class="stat-card stat-pending">
            <div class="stat-value"><%= pendingCount %></div>
            <div class="stat-label">
                <i class="fas fa-clock stat-icon"></i> Pending
            </div>
        </div>
        <div class="stat-card stat-cancelled">
            <div class="stat-value"><%= cancelledCount %></div>
            <div class="stat-label">
                <i class="fas fa-times-circle stat-icon"></i> Cancelled
            </div>
        </div>
    </div>

<div class="booking-table-container" style="overflow-x: auto;">
        <div style="min-width: 1024px;">
            <table class="booking-table">
                <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Type</th>
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
                            String bookingType = bk.getClass().getSimpleName().replace("Booking", "");
                %>
                <tr>
                    <td>#<%= bk.getBookingId() %></td>
                    <td><span class="booking-type-badge"><i class="fas fa-<%= bookingType.equalsIgnoreCase("Group") ? "users" : "user" %>"></i> <%= bookingType %></span></td>
                    <td>
                        <div class="customer-cell">
                            <div class="customer-info">
                                <div class="customer-name"><%= bk.getFullName() %></div>
                                <div class="customer-detail"><i class="fas fa-phone"></i> <%= bk.getPhoneNumber() %></div>
                                <div class="customer-detail"><i class="fas fa-home"></i> <%= bk.getAddress() %></div>
                                <div class="customer-detail"><i class="fas fa-envelope"></i> <%= bk.getEmail() %></div>
                                <% if (bk.getSpecialRequirements() != null && !bk.getSpecialRequirements().trim().isEmpty()) { %>
                                <div class="customer-allergy"><i class="fas fa-exclamation-triangle"></i> <%= bk.getSpecialRequirements() %></div>
                                <% } %>
                            </div>
                        </div>
                    </td>
                    <td><%= bk.getPackageId() %></td>
                    <td><%= bk.getBookingDate() %></td>
                    <td><%= bk.getNumberOfPeople() %></td>
                    <td class="price">$<%= String.format("%.2f", bk.getTotalPrice()) %></td>
                    <td>
                    <span class="status <%= statusClass %>">
                        <i class="fas fa-<%= bk.getStatus().equalsIgnoreCase("confirmed") ? "check-circle" : bk.getStatus().equalsIgnoreCase("pending") ? "clock" : "times-circle" %> status-icon"></i>
                        <%= bk.getStatus() %>
                    </span>
                    </td>
                    <td>
                        <div class="action-btns">
                            <form action="<%= request.getContextPath() %>/BookingUpdateServlet" method="get" style="display:inline;">
                                <input type="hidden" name="bookingId" value="<%= bk.getBookingId() %>"/>
                                <button type="submit" class="action-btn edit-btn">
                                    <i class="fas fa-pencil-alt"></i> Edit
                                </button>
                            </form>
                            <form action="<%= request.getContextPath() %>/BookingDeleteServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this booking?');" style="display:inline;">
                                <input type="hidden" name="bookingId" value="<%= bk.getBookingId() %>"/>
                                <button type="submit" class="action-btn delete-btn">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="9" class="empty-state">
                        <div class="empty-icon">
                            <i class="far fa-calendar-times"></i>
                        </div>
                        <div class="empty-text">No bookings found</div>
                        <a href="<%= request.getContextPath() %>/PackageListServlet" class="new-booking-btn">
                            <i class="fas fa-plus"></i> Create New Booking
                        </a>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
</div>

</body>
</html>
