<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.User.model.User, com.User.model.AdminUser" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !(user instanceof AdminUser)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Template & Bootstrap CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }

        .dashboard-container {
            margin-top: 60px;
        }

        .action-buttons .btn {
            font-size: 1.1rem;
            padding: 15px;
            transition: 0.3s ease-in-out;
            width: 100%;
        }

        .action-buttons .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .welcome-box {
            background: #f8f9fa;
            border-left: 5px solid #7ED957;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 40px;
        }
    </style>
</head>

<body>
<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container-fluid">
        <a href="AdminDashboard.jsp" class="navbar-brand px-4">
            <h2 class="m-0 text-success"><i class="fas fa-cogs me-2"></i>Admin Panel</h2>
        </a>
        <button class="navbar-toggler me-3" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="adminNavbar">
            <div class="navbar-nav ms-auto px-4">
                <a href="AdminDashboard.jsp" class="nav-item nav-link active">Dashboard</a>
                <a href="<%= request.getContextPath() %>/logout" class="nav-item nav-link text-danger">Logout</a>
            </div>
        </div>
    </div>
</nav>
<!-- Navbar End -->

<!-- Dashboard Content -->
<div class="container dashboard-container">
    <div class="welcome-box">
        <h4>Welcome, <b><%= user.getUsername() %></b></h4>
        <p class="mb-0 text-muted">You have administrator privileges.</p>
    </div>

    <div class="row action-buttons text-center g-4">
        <div class="col-md-6">
            <a href="<%= request.getContextPath() %>/ViewPackage" class="btn btn-outline-primary shadow">
                <i class="fas fa-eye me-2"></i> View All Packages
            </a>
        </div>
        <div class="col-md-6">
            <a href="<%= request.getContextPath() %>/Package/AddPackage.jsp" class="btn btn-outline-success shadow">
                <i class="fas fa-plus me-2"></i> Add New Package
            </a>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="text-center py-4 mt-5 bg-light">
    <p class="mb-0">&copy; 2025 Admin Dashboard. All rights reserved.</p>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
