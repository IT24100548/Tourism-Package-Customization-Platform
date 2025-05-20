<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>TRAVELER - Customize Your Dream Tour</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">


    <style>
        /* Optional overlay for readability */
        .hero-header {
            position: relative;
            background: url('<%= request.getContextPath() %>/images/travel.png') center center / cover no-repeat;
        }

        .hero-header::before {
            content: "";
            position: absolute;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4); /* dark overlay */
            z-index: 1;
        }

        .hero-header .container,
        .hero-header .text-white,
        .hero-header .btn {
            position: relative;
            z-index: 2;
        }
    </style>
</head>

<body>

<%
    String deleteMessage = (String) session.getAttribute("deleteMessage");
    if (deleteMessage != null) {
%>
    <div class="alert alert-warning text-center">
        <%= deleteMessage %>
    </div>
<%
        session.removeAttribute("deleteMessage");
    }
%>

<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
    <a href="index.jsp" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
        <h2 class="m-0 text-primary"><i class="fa fa-globe me-3"></i>Travel Explorer</h2>
    </a>
    <button class="navbar-toggler me-4" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">
            <a href="${pageContext.request.contextPath}/User/index.jsp" class="nav-item nav-link active">Home</a>
            <a href="about.jsp" class="nav-item nav-link">About us</a>
            <a href="contact.jsp" class="nav-item nav-link">Contact us</a>
            <a href="${pageContext.request.contextPath}/User/register.jsp" class="nav-item nav-link">Register</a>
            <a href="${pageContext.request.contextPath}/User/login.jsp" class="nav-item nav-link">Login</a>

        </div>
    </div>
</nav>
<!-- Navbar End -->

<!-- Hero Start -->
<div class="container-fluid py-5 mb-5 hero-header">
    <div class="container py-5">
        <div class="row justify-content-center py-5">
            <div class="col-lg-10 pt-lg-5 mt-lg-5 text-center">
                <h1 class="display-3 text-white mb-3 animated slideInDown">Customize Your Dream Tour</h1>
                <p class="fs-4 text-white mb-4 animated slideInDown">Explore the world with personalized travel packages just for you.</p>
                <div class="position-relative w-75 mx-auto animated slideInDown">
                    <a href="${pageContext.request.contextPath}/User/register.jsp" class="btn btn-light py-3 px-5 me-3">Get Started</a>
                    <a href="${pageContext.request.contextPath}/User/login.jsp" class="btn btn-outline-light py-3 px-5">Login</a>

                </div>
            </div>
        </div>
    </div>
</div>
<!-- Hero End -->

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