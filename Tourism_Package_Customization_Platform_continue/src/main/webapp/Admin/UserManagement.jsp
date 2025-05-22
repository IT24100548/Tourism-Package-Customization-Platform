<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.Admin.model.AdminUser" %>
<%@ page import="com.User.model.User" %>
<%
  List<User> userList = (List<User>) request.getAttribute("userList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Management</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Template CSS -->
  <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<div class="container-fluid bg-primary text-white p-3">
  <div class="d-flex justify-content-between align-items-center">
    <h1 class="mb-0">Travel Packages</h1>
    <a href= "Admin/AdminDashboard.jsp" class="btn btn-light">Home</a>
  </div>
</div>

<div class="table-responsive">
  <table class="table table-striped table-hover border">
    <thead class="table-primary">
    <tr>
      <th>Username</th>
      <th>Email</th>
    </tr>
    </thead>
    <tbody>
    <% for (User user : userList) { %>
    <tr>
      <td><%= user.getUsername() %></td>
      <td><%= user.getEmail() %></td>
      <td>
        <form action="${pageContext.request.contextPath}/AdminDeleteTraveler" method="post" onsubmit="return confirm('Are you sure?');">
          <input type="hidden" name="username" value="<%= user.getUsername() %>">
          <button class="btn btn-danger btn-sm">Delete</button>
        </form>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
</div>
</body>
</html>
