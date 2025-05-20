<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Add Package</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-sm">
            <div class="card-header bg-dark text-white">
                <h2 class="mb-0">Add New Travel Package</h2>
            </div>
            <div class="card-body">
                <c:if test="${param.success == 'true'}">
                    <div class="alert alert-success" role="alert">
                        Package added successfully!
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/addPackage" method="post">
                    <div class="form-group">
                        <label for="id" class="form-label">ID</label>
                        <input type="text" class="form-control" id="id" name="id" required />
                    </div>
                    <div class="form-group">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" required />
                    </div>
                    <div class="form-group">
                        <label for="destination" class="form-label">Destination</label>
                        <input type="text" class="form-control" id="destination" name="destination" required />
                    </div>
                    <div class="form-group">
                        <label for="price" class="form-label">Price</label>
                        <input type="number" step="0.01" class="form-control" id="price" name="price" required />
                    </div>
                    <div class="form-group">
                        <label for="description" class="form-label">Description</label>
                        <input type="text" class="form-control" id="description" name="description" required />
                    </div>
                    <div class="form-group">
                        <label for="type" class="form-label">Type</label>
                        <select class="form-select" id="type" name="type" onchange="toggleExtraField(this.value)">
                            <option value="Adventure">Adventure</option>
                            <option value="Leisure">Leisure</option>
                        </select>
                    </div>
                    <div class="form-group" id="extraField">
                        <label for="extra" class="form-label">Extra (Activity Type or Hotel Type)</label>
                        <input type="text" class="form-control" id="extra" name="extra" required />
                    </div>
                    <div class="d-flex justify-content-between mt-4">
                        <button type="submit" class="btn btn-success">Add Package</button>
                        <a href="${pageContext.request.contextPath}/viewPackages" class="btn btn-secondary">Back to Packages</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleExtraField(type) {
            const fieldLabel = type === 'Adventure' ? 'Activity Type' : 'Hotel Type';
            document.getElementById('extraField').innerHTML = `
                <label for="extra" class="form-label">${fieldLabel}</label>
                <input type="text" class="form-control" id="extra" name="extra" required />
            `;
        }
    </script>
</body>
</html>