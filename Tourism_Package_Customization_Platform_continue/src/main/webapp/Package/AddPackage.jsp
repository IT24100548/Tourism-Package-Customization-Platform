<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Travel Package</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-5">

<body class="p-5">

<!-- Top Header with Home Button -->
<div class="container-fluid mb-4">
    <div class="d-flex justify-content-between align-items-center">
        <h2 class="mb-0">Add New Travel Package</h2>
        <a href="../Admin/AdminDashboard.jsp" class="btn btn-outline-primary">Home</a>
    </div>
</div>

<div class="container">


<div class="container">


<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");

    if ("1".equals(success)) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        Package added successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<%
    } else if ("exists".equals(error)) {
%>
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        A package with the same ID already exists.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<%
    } else if ("invalid".equals(error)) {
%>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        Invalid package type selected.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<%
    } else if ("exception".equals(error)) {
%>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        An unexpected error occurred while adding the package.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<%
    }
%>



    <%-- Show success or error message if present --%>
    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <%= message %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
        }
    %>

    <form action="../AddPackage" method="post">
        <div class="mb-3">
            <label class="form-label">Package ID</label>
            <input type="text" name="id" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Package Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Destination</label>
            <input type="text" name="destination" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Price</label>
            <input type="number" name="price" step="0.01" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Package Type</label>
            <select name="type" class="form-select" id="typeSelect" onchange="toggleExtraFields()" required>
                <option value="">Select</option>
                <option value="ADVENTURE">Adventure</option>
                <option value="LEISURE">Leisure</option>
            </select>
        </div>

        <div class="mb-3 d-none" id="adventureDiv">
            <label class="form-label">Activity Type</label>
            <input type="text" name="activityType" class="form-control">
        </div>

        <div class="mb-3 d-none" id="leisureDiv">
            <label class="form-label">Hotel Type</label>
            <input type="text" name="hotelType" class="form-control">
        </div>

        <button type="submit" class="btn btn-primary">Add Package</button>
    </form>
</div>

<script>
    function toggleExtraFields() {
        const type = document.getElementById("typeSelect").value;
        document.getElementById("adventureDiv").classList.add("d-none");
        document.getElementById("leisureDiv").classList.add("d-none");

        if (type === "ADVENTURE") {
            document.getElementById("adventureDiv").classList.remove("d-none");
        } else if (type === "LEISURE") {
            document.getElementById("leisureDiv").classList.remove("d-none");
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
