<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Travel Packages</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Template CSS -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Template Header Start -->
<div class="container-fluid bg-primary text-white p-3">
    <div class="d-flex justify-content-between align-items-center">
        <h2 class="mb-0">Search Travel Packages</h2>
        <a href="${pageContext.request.contextPath}/User/TravelerDashboard.jsp" class="btn btn-light">Home</a>
    </div>
</div>
<!-- Template Header End -->

<div class="container my-5">

    <!-- Search Form -->
    <form action="${pageContext.request.contextPath}/SearchPackage" method="post" class="mb-4">
        <div class="input-group">
            <input type="text" name="name" class="form-control" placeholder="Enter package name..." required>
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
    </form>

    <!-- Search Results -->
    <%
        List<com.Package.model.TravelPackage> results = (List<com.Package.model.TravelPackage>) request.getAttribute("results");
        if (results != null) {
            if (results.isEmpty()) {
    %>
        <div class="alert alert-warning">No packages found matching your search.</div>
    <%
            } else {
    %>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Destination</th>
                        <th>Price</th>
                        <th>Description</th>
                        <th>Activity/Hotel Type</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% for (com.Package.model.TravelPackage p : results) { %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><%= p.getName() %></td>
                        <td><%= p.getDestination() %></td>
                        <td>$<%= p.getPrice() %></td>
                        <td><%= p.getDescription() %></td>
                        <td><%= p.getExtraDetails() %></td>
                        <td>
                            <% if (request.getRequestURI().contains("Admin")) { %>
                                <form action="DeletePackageServlet" method="post" onsubmit="return confirm('Are you sure?');">
                                    <input type="hidden" name="packageId" value="<%= p.getId() %>">
                                    <button class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            <% } else { %>
                                <form action="BookPackageServlet" method="post">
                                    <input type="hidden" name="packageId" value="<%= p.getId() %>">
                                    <button class="btn btn-success btn-sm">Book</button>
                                </form>
                            <% } %>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    <%
            }
        }
    %>
</div>

<!-- Template Footer Start -->
<div class="container-fluid bg-dark text-white text-center p-3">
    <p class="mb-0">© 2025 Travel Explorer. All rights reserved.</p>
</div>
<!-- Template Footer End -->

</body>
</html>
