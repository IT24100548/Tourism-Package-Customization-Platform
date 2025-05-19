<%@ page import="com.User.model.User, com.User.model.Traveler" %>
<%@ page session="true" %>
<%@ page isErrorPage="true" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !(user instanceof Traveler)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Traveler Profile</title>

    <!-- Bootstrap & Custom CSS -->
    <link href="<%= request.getContextPath() %>/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        .navbar {
            background-color: #ffffff;
        }
        .navbar-brand h2 {
            color: #7ED957 !important;
        }
        .nav-link {
            color: #333;
            font-weight: 500;
            margin-right: 15px;
        }
        .nav-link:hover,
        .nav-item .active {
            color: #7ED957 !important;
        }
        footer {
            font-size: 14px;
            color: #777;
            margin-top: 30px;
        }
    </style>
</head>

<body>

<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg navbar-light shadow sticky-top">
    <div class="container-fluid">
        <a href="TravelerDashboard.jsp" class="navbar-brand px-4">
            <h2 class="m-0"><i class="fa fa-globe me-2"></i>Travel Explorer</h2>
        </a>
        <button class="navbar-toggler me-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTraveler">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarTraveler">
            <div class="navbar-nav ms-auto px-4">
                <a href="TravelerDashboard.jsp" class="nav-item nav-link active">Home</a>
                <a href="MyPackages.jsp" class="nav-item nav-link">My Packages</a>
                <a href="MyBookings.jsp" class="nav-item nav-link">My Bookings</a>
                <a href="MyPayments.jsp" class="nav-item nav-link">My Payments</a>
                <a href="profile.jsp" class="nav-item nav-link">Profile</a>
                <a href="<%= request.getContextPath() %>/logout" class="nav-item nav-link text-danger">Logout</a>
            </div>
        </div>
    </div>
</nav>
<!-- Navbar End -->

<!-- Profile Management Section -->
<section class="section-padding">
    <div class="container">

        <%-- Success or Error Message Handling --%>
        <% String success1Message = (String) session.getAttribute("success1Message");
           String error1Message = (String) session.getAttribute("error1Message");
        %>

        <% if (success1Message != null) { %>
            <div class="alert alert-success text-center"><%= success1Message %></div>
            <% session.removeAttribute("success1Message"); } %>
        <% if (error1Message != null) { %>
            <div class="alert alert-danger text-center"><%= error1Message %></div>
            <% session.removeAttribute("error1Message"); } %>

        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card mb-4 shadow">
                    <div class="card-header text-center">
                        <h4>Manage Your Profile</h4>
                    </div>
                    <div class="card-body">

                        <!-- Action Buttons -->
                        <div id="buttonSection" class="text-center mb-4">
                            <button class="btn btn-outline-primary w-100 mb-2" onclick="showForm('emailForm')">Change Email</button>
                            <button class="btn btn-outline-success w-100 mb-2" onclick="showForm('passwordForm')">Change Password</button>
                            <button class="btn btn-outline-warning w-100 mb-2" onclick="showForm('usernameForm')">Change Username</button>
                        </div>

                        <!-- Change Email Form -->
                        <form id="emailForm" action="../change-email" method="post" style="display: none;" class="row g-3">
                            <input type="hidden" name="username" value="<%= user.getUsername() %>">
                            <div class="col-12">
                                <label for="newEmail" class="form-label">New Email</label>
                                <input type="email" class="form-control" name="newEmail" required>
                            </div>
                            <div class="col-12 d-flex justify-content-between">
                                <button type="button" class="btn btn-secondary" onclick="backToButtons()">Back</button>
                                <button type="submit" class="btn btn-primary">Update Email</button>
                            </div>
                        </form>

                        <!-- Change Password Form -->
                        <form id="passwordForm" action="../change-password" method="post" style="display: none;" class="row g-3">
                            <input type="hidden" name="username" value="<%= user.getUsername() %>">
                            <div class="col-12">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" class="form-control" name="newPassword" required>
                            </div>
                            <div class="col-12 d-flex justify-content-between">
                                <button type="button" class="btn btn-secondary" onclick="backToButtons()">Back</button>
                                <button type="submit" class="btn btn-success">Update Password</button>
                            </div>
                        </form>

                        <!-- Change Username Form -->
                        <form id="usernameForm" action="../change-username" method="post" style="display: none;" class="row g-3">
                            <input type="hidden" name="oldUsername" value="<%= user.getUsername() %>">
                            <div class="col-12">
                                <label for="newUsername" class="form-label">New Username</label>
                                <input type="text" class="form-control" name="newUsername" required>
                            </div>
                            <div class="col-12 d-flex justify-content-between">
                                <button type="button" class="btn btn-secondary" onclick="backToButtons()">Back</button>
                                <button type="submit" class="btn btn-warning">Update Username</button>
                            </div>
                        </form>

                        <!-- Delete Account Button -->
                        <button type="button" class="btn btn-danger w-100 mt-4" data-bs-toggle="modal" data-bs-target="#deleteModal">
                            <i class="fas fa-trash-alt"></i> Delete Account
                        </button>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Account Deletion</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete your account? This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form action="${pageContext.request.contextPath}/Delete" method="get">
                    <input type="hidden" name="username" value="<%= user.getUsername() %>">
                    <button type="submit" class="btn btn-danger">Yes, Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer-area text-center py-3">
    <p>&copy; 2025 Traveler Dashboard. All rights reserved.</p>
</footer>

<!-- JS Scripts -->
<script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
function showForm(formId) {
    document.getElementById('buttonSection').style.display = 'none';
    document.getElementById('emailForm').style.display = 'none';
    document.getElementById('passwordForm').style.display = 'none';
    document.getElementById('usernameForm').style.display = 'none';
    document.getElementById(formId).style.display = 'block';
}

function backToButtons() {
    document.getElementById('buttonSection').style.display = 'block';
    document.getElementById('emailForm').style.display = 'none';
    document.getElementById('passwordForm').style.display = 'none';
    document.getElementById('usernameForm').style.display = 'none';
}
</script>

</body>
</html>
