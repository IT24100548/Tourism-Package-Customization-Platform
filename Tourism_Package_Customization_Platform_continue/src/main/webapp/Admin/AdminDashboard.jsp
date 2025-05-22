<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.User.model.User, com.Admin.model.AdminUser" %>
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
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
        }

        .dashboard-container {
            margin-top: 60px;
            padding: 2rem;
            animation: fadeInUp 0.8s ease-out;
        }

        .action-buttons .btn {
            font-size: 1.1rem;
            padding: 18px 25px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border-radius: 12px;
            border: none;
            background: linear-gradient(135deg, #7ED957 0%, #5cb130 100%);
            color: white;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .action-buttons .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.1);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .action-buttons .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 20px rgba(126, 217, 87, 0.3);
            background: linear-gradient(135deg, #7ED957 0%, #4d9a24 100%);
        }

        .action-buttons .btn:hover::before {
            opacity: 1;
        }

        .welcome-box {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            border-left: 5px solid #7ED957;
            padding: 30px;
            border-radius: 16px;
            margin-bottom: 40px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05);
            position: relative;
            overflow: hidden;
        }

        .welcome-box::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 3px;
            height: 100%;
            background: linear-gradient(180deg, #7ED957 0%, rgba(126, 217, 87, 0) 100%);
            opacity: 0.3;
        }

        .welcome-box h3 {
            color: #2d3436;
            font-weight: 600;
            margin-bottom: 15px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.05);
        }

        .welcome-box p {
            color: #636e72;
            line-height: 1.7;
            font-size: 1.05rem;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Add subtle floating animation to buttons */
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-5px); }
            100% { transform: translateY(0px); }
        }

        .action-buttons .btn {
            animation: float 4s ease-in-out infinite;
        }
    </style>
</head>

<body>
<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container-fluid">
        <a href="AdminDashboard.jsp" class="navbar-brand px-4">
            <h2 class="m-0 text-success">ADMIN PANEL</h2>
        </a>
        <button class="navbar-toggler me-3" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="adminNavbar">
            <div class="navbar-nav ms-auto px-4">
                <a href="AdminDashboard.jsp" class="nav-item nav-link active">Dashboard</a>
                <a href="Profile.jsp" class="nav-item nav-link active">Profile</a>

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
        <p class="mb-0 text-muted">Admin Successfully Logged In.</p>
    </div>

    <div class="row action-buttons text-center g-4">
        <div class="col-md-4 pb-4">
            <a href="<%= request.getContextPath() %>/ViewPackage" class="btn btn-outline-primary shadow">
                View All Packages
            </a>
        </div>
        <div class="col-md-4 pb-4">
            <a href="<%= request.getContextPath() %>/UserManagement" class="btn btn-outline-primary shadow">
                User Management
            </a>
        </div>
        <div class="col-md-4 pb-4">
            <a href="<%= request.getContextPath() %>/Package/AddPackage.jsp" class="btn btn-outline-success shadow">
                Add New Package
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
