<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Status</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #f4f4f4, #e8f1f9);
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .box {
            background-color: #ffffff;
            padding: 30px 120px;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .status-icon {
            font-size: 48px;
            color: <%= Boolean.TRUE.equals(request.getAttribute("success")) ? "#27ae60" : "#e74c3c" %>;
            margin-bottom: 15px;
        }

        h2 {
            font-size: 26px;
            color: <%= Boolean.TRUE.equals(request.getAttribute("success")) ? "#27ae60" : "#e74c3c" %>;
            margin-bottom: 10px;
        }

        p {
            font-size: 18px;
            color: #333;
            margin: 8px 0;
        }

        .back-btn {
            margin-top: 25px;
            display: inline-block;
            background-color: #2980b9;
            color: white;
            padding: 10px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .back-btn:hover {
            background-color: #1f6391;
        }
    </style>
</head>
<body>
<div class="box">
    <div class="status-icon">
        <i class="fas <%= Boolean.TRUE.equals(request.getAttribute("success")) ? "fa-check-circle" : "fa-times-circle" %>"></i>
    </div>
    <%
        Boolean success = (Boolean) request.getAttribute("success");
        if (success != null && success) {
    %>
    <h2>Booking <%= request.getAttribute("fullName") != null ? "Successful" : "Updated" %>!</h2>
    <p>Total Price: <strong>Rs. <%= String.format("%.2f", request.getAttribute("newTotalPrice")) %></strong></p>
    <%
    } else {
    %>
    <h2>Booking Failed</h2>
    <p style="color: #e74c3c;">An error occurred. Please try again.</p>
    <%
        }
    %>
    <a href="<%= request.getContextPath() %>/BookingHistoryServlet" class="back-btn">Back to History</a>
</div>
</body>
</html>
