<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .payment-form {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            margin-top: 40px;
            margin-bottom: 40px;
        }
        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
        }
        .form-control {
            border-radius: 8px;
            padding: 12px;
            border: 2px solid #e9ecef;
            transition: all 0.3s;
        }
        .form-control:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s;
        }
        .btn-primary {
            background: #0d6efd;
            border: none;
        }
        .btn-primary:hover {
            background: #0b5ed7;
            transform: translateY(-1px);
        }
        .btn-secondary {
            background: #6c757d;
            border: none;
        }
        .btn-secondary:hover {
            background: #5c636a;
        }
        .card-icon {
            color: #0d6efd;
            margin-right: 8px;
        }
        .form-header {
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 30px;
            padding-bottom: 20px;
        }
        .error {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 4px;
        }
        .input-group-text {
            background: #e9ecef;
            border: 2px solid #e9ecef;
            border-right: none;
        }
        .input-group .form-control {
            border-left: none;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="payment-form">
                <div class="form-header">
                    <h2 class="text-center">
                        <i class="fas fa-credit-card card-icon"></i>Payment Details
                    </h2>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/payment" method="post" class="needs-validation" novalidate>
                    <div class="mb-4">
                        <label for="customerName" class="form-label">
                            <i class="fas fa-user me-2"></i>Customer Name
                        </label>
                        <input type="text" class="form-control" id="customerName" name="customerName"
                               minlength="2" maxlength="50" pattern="^[A-Za-z ]+$"
                               placeholder="Janith" required
                               onkeypress="return /[A-Za-z ]/.test(event.key)"
                               onpaste="return false;">
                        <div class="invalid-feedback">Please enter a valid name (letters and spaces only, 2-50 characters)</div>
                    </div>

                    <div class="mb-4">
                        <label for="mobileNumber" class="form-label">
                            <i class="fas fa-phone me-2"></i>Mobile Number
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">+94</span>
                            <input type="text" class="form-control" id="mobileNumber" name="mobileNumber"
                                   pattern="[0-9]{10}" placeholder="771234567" required
                                   onkeypress="return /[0-9]/.test(event.key)">
                        </div>
                        <div class="invalid-feedback">Please enter a valid 10-digit mobile number</div>
                    </div>
</script>
</body>
</html>