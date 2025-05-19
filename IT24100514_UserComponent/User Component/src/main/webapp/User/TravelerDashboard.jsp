<%@ page import="com.User.model.User, com.User.model.Traveler" %>
<%@ page session="true" %>
<%@ page isErrorPage="true" %>
<%
    try {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Traveler)) {
            response.sendRedirect("login.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !(user instanceof Traveler)) {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Traveler Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="<%= request.getContextPath() %>/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }

        .navbar {
            background-color: #ffffff;
        }

        .navbar-brand h2 {
            color: #7ED957 !important;
        }

        .nav-link {
            color: #333;
            font-weight: 500;
            margin-right: 15px;
        }

        .nav-link:hover,
        .nav-item .active {
            color: #7ED957 !important;
        }

        .content-area {
            padding: 40px 20px;
        }

        .welcome-box {
            background-color: #f8f9fa;
            border-left: 5px solid #7ED957;
            padding: 20px;
            border-radius: 8px;
        }

        footer {
            font-size: 14px;
            color: #777;
        }
        .btn-lg {
            font-size: 1.2rem;
            transition: all 0.3s ease-in-out;
        }

        .btn-outline-info:hover, .btn-outline-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .shadow-lg {
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,.15) !important;
        }

    </style>
</head>

<body>
<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg navbar-light shadow sticky-top">
    <div class="container-fluid">
        <a href="TravelerDashboard.jsp" class="navbar-brand px-4">
            <h2 class="m-0"><i class="fa fa-globe me-2"></i>Travel Explorer</h2>
        </a>
        <button class="navbar-toggler me-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTraveler">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarTraveler">
            <div class="navbar-nav ms-auto px-4">
                <a href="TravelerDashboard.jsp" class="nav-item nav-link active">Home</a>

                <a href="MyBookings.jsp" class="nav-item nav-link">My Bookings</a>
                <a href="MyPayments.jsp" class="nav-item nav-link">My Payments</a>
                <a href="profile.jsp" class="nav-item nav-link">Profile</a>
                <a href="<%= request.getContextPath() %>/logout" class="nav-item nav-link text-danger">Logout</a>
            </div>
        </div>
    </div>
</nav>
<!-- Navbar End -->

<!-- Dashboard Content -->
<div class="container content-area">
    <div class="welcome-box">
        <h4>Welcome, <b><%= ((Traveler) user).getUsername() %></b></h4>

        <div class="alert alert-success mt-3">
            <%= user.login() %>
        </div>

<div class="container mt-5 text-center">
    <div class="row justify-content-center g-4">
        <div class="col-md-4">
            <a href="<%= request.getContextPath() %>/Package/SearchPackage.jsp" class="btn btn-outline-info btn-lg w-100 shadow-lg py-3">
                <i class="fas fa-search me-2"></i> Search Packages
            </a>
        </div>
        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/ViewPackage" class="btn btn-outline-success btn-lg w-100 shadow-lg py-3">
                <i class="fas fa-list me-2"></i> View All Packages
            </a>
        </div>
    </div>
</div>




    </div>
</div>

<!-- Footer -->
<footer class="text-center py-4 bg-light mt-5">
    <p class="mb-0">&copy; 2025 Traveler Dashboard. All rights reserved.</p>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
