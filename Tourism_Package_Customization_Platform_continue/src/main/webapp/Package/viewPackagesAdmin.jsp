<%@ page import="java.util.List" %>
<%@ page import="com.Package.model.TravelPackage" %>
<%@ page import="com.Package.DAO.PackageDAO" %>
<%
    List<TravelPackage> packages = (List<TravelPackage>) request.getAttribute("packages");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Travel Packages</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Template CSS -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<!-- Template Header Start -->
<div class="container-fluid bg-primary text-white p-3">
    <div class="d-flex justify-content-between align-items-center">
        <h1 class="mb-0">Travel Packages</h1>
        <a href= "Admin/AdminDashboard.jsp" class="btn btn-light">Home</a>
    </div>
</div>

<div class="container my-5">
    <!-- Sorting Buttons -->
    <div class="d-flex justify-content-end mb-4">
        <a href="${pageContext.request.contextPath}/ViewPackage?sort=id" class="btn btn-outline-primary me-2">Sort by ID</a>
        <a href="${pageContext.request.contextPath}/ViewPackage?sort=price" class="btn btn-outline-success">Sort by Price</a>
    </div>

    <!-- Package Table -->
    <div class="table-responsive">
        <table class="table table-striped table-hover border">
            <thead class="table-primary">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Destination</th>
                <th>Price</th>
                <th>Description</th>
                <th>Actions</th>
                <th>Booking</th>
            </tr>
            </thead>
            <tbody>
            <% for (TravelPackage p : packages) { %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getName() %></td>
                    <td><%= p.getDestination() %></td>
                    <td>$<%= p.getPrice() %></td>
                    <td><%= p.getDescription() %></td>
                    <td><%= p.getExtraDetails() %></td>
                    <td>
                        <% if (request.getRequestURI().contains("Admin")) { %>
                            <form action="${pageContext.request.contextPath}/DeletePackage" method="post" onsubmit="return confirm('Are you sure?');">
                                <input type="hidden" name="packageId" value="<%= p.getId() %>">
                                <button class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        <% } else { %>
                            <form action="BookPackageServlet" method="post">
                                <input type="hidden" name="packageId" value="<%= p.getId() %>">
                                <button class="btn btn-success btn-sm">Book now</button>
                            </form>
                        <% } %>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Template Footer Start -->
<div class="container-fluid bg-dark text-white text-center p-3">
    <p class="mb-0"> 2025 Traveler Dashboard. All rights reserved..</p>
</div>
<!-- Template Footer End -->

</body>
</html>
