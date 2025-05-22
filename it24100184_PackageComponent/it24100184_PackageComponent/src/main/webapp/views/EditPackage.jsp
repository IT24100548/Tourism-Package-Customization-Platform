<%@ page import="com.tourism.model.TravelPackage" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Edit Package</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-sm">
            <div class="card-header bg-dark text-white">
                <h2 class="mb-0">Edit Travel Package</h2>
            </div>
            <div class="card-body">
                <%
                    TravelPackage pkg = (TravelPackage) request.getAttribute("package");
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                    <div class="alert alert-danger" role="alert">
                        <%= error %>
                    </div>
                <%
                    }
                    if (pkg != null) {
                %>
                <form action="${pageContext.request.contextPath}/editPackage" method="post">
                    <input type="hidden" name="id" value="<%= pkg.getId() %>" />
                    <div class="form-group">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" value="<%= pkg.getName() %>" required />
                    </div>
                    <div class="form-group">
                        <label for="destination" class="form-label">Destination</label>
                        <input type="text" class="form-control" id="destination" name="destination" value="<%= pkg.getDestination() %>" required />
                    </div>
                    <div class="form-group">
                        <label for="price" class="form-label">Price</label>
                        <input type="number" step="0.01" class="form-control" id="price" name="price" value="<%= pkg.getPrice() %>" required />
                    </div>
                    <div class="form-group">
                        <label for="description" class="form-label">Description</label>
                        <input type="text" class="form-control" id="description" name="description" value="<%= pkg.getDescription() %>" required />
                    </div>
                    <div class="form-group">
                        <label for="type" class="form-label">Type</label>
                        <select class="form-select" id="type" name="type" onchange="toggleField(this.value)">
                            <option value="Adventure" <%= (pkg instanceof com.tourism.model.AdventurePackage ? "selected" : "") %>>Adventure</option>
                            <option value="Leisure" <%= (pkg instanceof com.tourism.model.LeisurePackage ? "selected" : "") %>>Leisure</option>
                        </select>
                    </div>
                    <div class="form-group" id="extraField">
                        <%
                            String extra = "";
                            String label = "";
                            if (pkg instanceof com.tourism.model.AdventurePackage) {
                                label = "Activity Type";
                                extra = pkg.getExtraDetails().startsWith("Activity Type: ") ? pkg.getExtraDetails().substring("Activity Type: ".length()) : "";
                            } else if (pkg instanceof com.tourism.model.LeisurePackage) {
                                label = "Hotel Type";
                                extra = pkg.getExtraDetails().startsWith("Hotel Type: ") ? pkg.getExtraDetails().substring("Hotel Type: ".length()) : "";
                            }
                        %>
                        <label for="extra" class="form-label"><%= label %></label>
                        <input type="text" class="form-control" id="extra" name="extra" value="<%= extra %>" required />
                    </div>
                    <div class="d-flex justify-content-between mt-4">
                        <button type="submit" class="btn btn-success">Update Package</button>
                        <a href="${pageContext.request.contextPath}/viewPackages" class="btn btn-secondary">Back to Packages</a>
                    </div>
                </form>
                <%
                    } else {
                %>
                    <div class="alert alert-danger" role="alert">
                        No package loaded for editing.
                    </div>
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/viewPackages" class="btn btn-secondary">Back to Packages</a>
                    </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <script>
        function toggleField(type) {
            const label = type === 'Adventure' ? 'Activity Type' : 'Hotel Type';
            document.getElementById('extraField').innerHTML = `
                <label for="extra" class="form-label">${label}</label>
                <input type="text" class="form-control" id="extra" name="extra" required />
            `;
        }
    </script>
</body>
</html>