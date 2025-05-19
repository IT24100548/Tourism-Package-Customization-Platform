<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - Travel Explorer</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />


   <link rel="stylesheet" href="../css/style.css">


    <style>
        .register-section {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: url('../images/travel4.png') center center / cover no-repeat;
        }

        .register-card {
            background: #ffffff;
            border-radius: 15px;
            padding: 40px 30px;
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.1);
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #0d6efd;
        }
    </style>

</head>
<body>

<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
    <a href="index.jsp" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
        <h2 class="m-0 text-primary"><i class="fa fa-globe me-2"></i>Travel Explorer</h2>
    </a>
    <button class="navbar-toggler me-4" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">
            <a href="index.jsp" class="nav-item nav-link">Home</a>
            <a href="about.jsp" class="nav-item nav-link">About us</a>
            <a href="contact.jsp" class="nav-item nav-link">Contact us</a>
            <a href="register.jsp" class="nav-item nav-link active">Register</a>
            <a href="login.jsp" class="nav-item nav-link">Login</a>
        </div>
    </div>
</nav>
<!-- Navbar End -->

<!-- Register Section Start -->
<div class="register-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="register-card">
                    <h3 class="text-center text-primary mb-4">Create an Account</h3>
                    <form action="${pageContext.request.contextPath}/register" method="post">

                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" class="form-control" required placeholder="Enter username">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" required placeholder="Enter password">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" required placeholder="Enter email">
                        </div>
                        <button type="submit" class="btn btn-primary w-100 py-2">Register</button>
                    </form>
                    <p class="text-center mt-3">Already have an account? <a href="login.jsp" class="text-primary">Login</a></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Register Section End -->

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>
<script src="lib/tempusdominus/js/moment.min.js"></script>
<script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
<script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>
</body>
</html>