<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Deleted</title>
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
            padding: 40px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 450px;
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .icon {
            font-size: 46px;
            color: #e74c3c;
            margin-bottom: 15px;
        }

        h2 {
            font-size: 24px;
            color: #e74c3c;
            margin-bottom: 10px;
        }

        p {
            font-size: 16px;
            color: #555;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            background-color: #2980b9;
            color: white;
            padding: 10px 24px;
            border-radius: 6px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #1f6391;
        }
    </style>
</head>
<body>
<div class="box">
    <div class="icon"><i class="fas fa-trash-alt"></i></div>
    <h2>Booking Deleted</h2>
    <p>The booking has been successfully removed.</p>
    <a href="<%= request.getContextPath() %>/BookingHistoryServlet" class="btn">Back to Booking History</a>
</div>
</body>
</html>
