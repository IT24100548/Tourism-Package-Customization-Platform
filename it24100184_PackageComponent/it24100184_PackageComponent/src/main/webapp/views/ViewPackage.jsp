<%@ page import="java.util.*, com.tourism.model.TravelPackage" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>View Packages</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-sm">
            <div class="card-header bg-dark text-white">
                <h2 class="mb-0">Available Tourism Packages</h2>
            </div>
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="sort-buttons btn-group">
                        <%
                            String currentSort = (String) request.getAttribute("currentSort");
                            if (currentSort == null) {
                                currentSort = "id"; // Fallback to default sort
                            }
                        %>
                        <a href="${pageContext.request.contextPath}/viewPackages"
                           class="btn <%= "id".equals(currentSort) ? "btn-primary" : "btn-outline-primary" %>">Default Order (by ID)</a>
                        <a href="${pageContext.request.contextPath}/viewPackages?sort=price"
                           class="btn <%= "price".equals(currentSort) ? "btn-primary" : "btn-outline-primary" %>">Sort by Price</a>
                        <a href="${pageContext.request.contextPath}/viewPackages?sort=name"
                           class="btn <%= "name".equals(currentSort) ? "btn-primary" : "btn-outline-primary" %>">Sort by Name</a>
                        <a href="${pageContext.request.contextPath}/viewPackages?sort=destination"
                           class="btn <%= "destination".equals(currentSort) ? "btn-primary" : "btn-outline-primary" %>">Sort by Destination</a>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/views/AddPackage.jsp" class="btn btn-success">Add New Package</a>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Back to Home</a>
                    </div>
                </div>

                <%
                    List<TravelPackage> packages = (List<TravelPackage>) request.getAttribute("packages");
                    out.println("<p class='text-danger'>Debug - Packages Size: " + (packages == null ? "null" : packages.size()) + "</p>");
                %>

                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Destination</th>
                            <th>Price</th>
                            <th>Description</th>
                            <th>Extra</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (packages != null && !packages.isEmpty()) {
                                for (TravelPackage p : packages) {
                        %>
                        <tr>
                            <td><%= p.getId() %></td>
                            <td><%= p.getName() %></td>
                            <td><%= p.getDestination() %></td>
                            <td>$<%= String.format("%.2f", p.getPrice()) %></td>
                            <td><%= p.getDescription() %></td>
                            <td><%= p.getExtraDetails() %></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/editPackage?loadId=<%= p.getId() %>" class="btn btn-warning btn-sm me-1">Edit</a>
                                <a href="${pageContext.request.contextPath}/deletePackage?id=<%= p.getId() %>" class="btn btn-danger btn-sm">Delete</a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center text-danger">No packages available or failed to load!</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>