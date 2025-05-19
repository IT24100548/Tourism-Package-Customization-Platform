<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Travel Explorer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">


       <link rel="stylesheet" href="../css/style.css">

    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Poppins', sans-serif;
        }

        .login-bg {
            background: url('../images/travel5.png') center center / cover no-repeat;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding-top: 80px;
        }

        .login-card {
            background: #fff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
        }

        .login-card h3 {
            font-weight: 600;
            margin-bottom: 25px;
            color: #86B817;
        }

        .form-control:focus {
            border-color: #86B817;
            box-shadow: none;
        }

        .btn-primary {
            background-color: #86B817;
            border-color: #86B817;
        }

        .btn-primary:hover {
            background-color: #6f9f13;
            border-color: #6f9f13;
        }

        .error {
            color: red;
            font-size: 14px;
        }
    </style>
</head>
<body>

<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow sticky-top">
    <div class="container">
        <a href="index.jsp" class="navbar-brand d-flex align-items-center">
            <h2 class="m-0 text-primary"><i class="fa fa-globe me-2"></i>Travel Explorer</h2>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a href="index.jsp" class="nav-link">Home</a>
                </li>
                <li class="nav-item">
                    <a href="about.jsp" class="nav-link">About Us</a>
                </li>
                <li class="nav-item">
                    <a href="contact.jsp" class="nav-link">Contact Us</a>
                </li>
                <li class="nav-item">
                    <a href="register.jsp" class="nav-link">Register</a>
                </li>
                <li class="nav-item">
                    <a href="login.jsp" class="nav-link active">Login</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- Navbar End -->



<!-- Login Section -->
<div class="login-bg">
    <div class="login-card">
        <h3 class="text-center">User Login</h3>

        <% if (request.getParameter("error") != null) { %>
            <p class="error text-center">Invalid username or password!</p>
        <% } %>

        <form action="../login" method="post">


            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" required placeholder="Enter username">
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required placeholder="Enter password">
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>

        <p class="text-center mt-3">Don't have an account? <a href="register.jsp" class="text-decoration-none" style="color: #86B817;">Register</a></p>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>