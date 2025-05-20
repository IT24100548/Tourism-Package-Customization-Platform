<%@ page import="com.tourism.model.TravelPackage" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Search Package</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-sm">
            <div class="card-header bg-dark text-white">
                <h2 class="mb-0">Search Travel Package</h2>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/searchPackage" method="post" class="mb-4">
                    <div class="form-group">
                        <label for="id" class="form-label">Enter Package ID</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="id" name="id" required />
                            <button type="submit" class="btn btn-primary">Search</button>
                        </div>
                    </div>
                </form>

                <%
                    TravelPackage result = (TravelPackage) request.getAttribute("result");
                    if (result != null) {
                %>
                    <div class="card shadow-sm">
                        <div class="card-header bg-success text-white">
                            <h4 class="mb-0">Package Found</h4>
                        </div>
                        <div class="card-body">
                            <p><strong>ID:</strong> <%= result.getId() %></p>
                            <p><strong>Name:</strong> <%= result.getName() %></p>
                            <p><strong>Destination:</strong> <%= result.getDestination() %></p>
                            <p><strong>Price:</strong> $<%= String.format("%.2f", result.getPrice()) %></p>
                            <p><strong>Description:</strong> <%= result.getDescription() %></p>
                            <p><strong>Extra:</strong> <%= result.getExtraDetails() %></p>
                        </div>
                    </div>
                <%
                    } else if (request.getAttribute("result") != null) {
                %>
                    <div class="alert alert-danger" role="alert">
                        No package found with that ID.
                    </div>
                <%
                    }
                %>

                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/viewPackages" class="btn btn-secondary">Back to Packages</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>