<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Package Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body, html {
            height: 100%;
        }
    </style>
</head>

<body class="bg-light d-flex justify-content-center align-items-center">

    <div class="text-center">
        <h1 class="display-5 fw-bold mb-2">Discover Amazing Travel Packages</h1>
        <p class="text-muted mb-4">Customize and book your dream vacation with ease.</p>

        <div class="d-flex justify-content-center gap-3">
            <a href="views/AddPackage.jsp" class="btn btn-primary btn-lg">Add Package</a>
            <a href="viewPackages" class="btn btn-secondary btn-lg">View Packages</a>
            <a href="views/SearchPackage.jsp" class="btn btn-secondary btn-lg">Search Packages</a>
        </div>
    </div>
</body>
</html>