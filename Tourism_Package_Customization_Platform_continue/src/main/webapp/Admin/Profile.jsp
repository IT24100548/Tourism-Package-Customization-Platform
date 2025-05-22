<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.User.model.User, com.Admin.model.AdminUser" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !(user instanceof AdminUser)) {
        response.sendRedirect("login.jsp?error=Please login first.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #198754;
            --secondary-color: #16a34a;
            --accent-color: #22c55e;
        }

        body {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
        }

        .profile-container {
            max-width: 700px;
            margin: 80px auto 40px;
            animation: fadeInUp 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card {
            border-radius: 24px;
            border: none;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(8px);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 16px 32px rgba(25, 135, 84, 0.15);
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 24px 24px 0 0 !important;
            padding: 1.5rem;
            position: relative;
            overflow: hidden;
        }

        .card-header::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg,
            transparent 25%,
            rgba(255, 255, 255, 0.1) 50%,
            transparent 75%);
            animation: shine 3s infinite;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 20px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.2);
            background: white;
        }

        .form-control::placeholder {
            color: #adb5bd;
            transition: opacity 0.3s ease;
        }

        .form-control:focus::placeholder {
            opacity: 0.5;
        }

        .btn-custom {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25, 135, 84, 0.3);
        }

        .btn-custom::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(255, 255, 255, 0.3),
                    transparent
            );
            transition: left 0.6s;
        }

        .btn-custom:hover::before {
            left: 100%;
        }

        .icon {
            margin-right: 10px;
            transition: transform 0.3s ease;
        }

        .btn-custom:hover .icon {
            transform: translateX(3px);
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

        @keyframes shine {
            100% {
                transform: translateX(100%);
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="AdminDashboard.jsp"><i class="bi bi-person-badge-fill"></i> Admin Panel</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link text-white" href="AdminDashboard.jsp"><i class="bi bi-house-door"></i> Home</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Profile Card -->
<div class="container profile-container">
    <div class="card shadow-lg">
        <div class="card-header text-center">
            <h4 class="mb-0"><i class="bi bi-person-circle"></i> Admin Profile</h4>
        </div>
        <div class="card-body">
            <p><strong><i class="bi bi-person-fill"></i> Username:</strong> <%= user.getUsername() %></p>
            <p><strong><i class="bi bi-envelope-fill"></i> Email:</strong> <%= user.getEmail() %></p>

            <form action="<%= request.getContextPath() %>\ProfileActionServlet" method="post" class="mt-4">
                <input type="hidden" name="username" value="<%= user.getUsername() %>">

                <!-- Change Email -->
                <div class="mb-4">
                    <label for="newEmail" class="form-label"><i class="bi bi-envelope-paper-fill"></i> New Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                        <input type="email" class="form-control" name="newEmail" id="newEmail" placeholder="Enter new email">
                    </div>
                    <button type="submit" name="action" value="changeEmail" class="btn btn-outline-primary btn-space w-100">
                        <i class="bi bi-save"></i> Change Email
                    </button>
                </div>

                <!-- Change Password -->
                <div class="mb-4">
                    <label for="newPassword" class="form-label"><i class="bi bi-lock-fill"></i> New Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password" class="form-control" name="newPassword" id="newPassword" placeholder="Enter new password">
                    </div>
                    <button type="submit" name="action" value="changePassword" class="btn btn-outline-warning btn-space w-100">
                        <i class="bi bi-shield-lock"></i> Change Password
                    </button>
                </div>

                <!-- Delete Account -->
                <div class="mt-4">
                    <button type="submit" name="action" value="delete" class="btn btn-danger w-100" onclick="return confirm('Are you sure you want to delete your account?')">
                        <i class="bi bi-trash"></i> Delete Account
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Optional Toast Notification Placeholder -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <!-- You can show success/error messages here with JS -->
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
