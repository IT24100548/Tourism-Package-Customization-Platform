<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="mb-0">Payment Details</h3>
                <a href="${pageContext.request.contextPath}/payment" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Back to List
                </a>
            </div>
        </div>
        <div class="card-body">
            <div class="row">
                <!-- Payment Info -->
                <div class="col-md-6">
                    <h4>Payment Information</h4>
                    <table class="table table-borderless">
                        <tr>
                            <th>Payment Number:</th>
                            <td>${payment.paymentNumber}</td>
                        </tr>
                        <tr>
                            <th>Amount:</th>
                            <td>
                                <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="LKR "/>
                            </td>
                        </tr>
                        <tr>
                            <th>Status:</th>
                            <td>
                                <span class="badge bg-${payment.paymentStatus eq 'COMPLETED' ? 'success' :
                                                      payment.paymentStatus eq 'PENDING' ? 'warning' : 'danger'}">
                                    ${payment.paymentStatus}
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>Method:</th>
                            <td>${payment.paymentMethod}</td>
                        </tr>
                    </table>
                </div>

                <!-- Customer Info -->
                <div class="col-md-6">
                    <h4>Customer Information</h4>
                    <table class="table table-borderless">
                        <tr>
                            <th>Name:</th>
                            <td>${payment.customerName}</td>
                        </tr>
                        <tr>
                            <th>Mobile:</th>
                            <td>${payment.mobileNumber}</td>
                        </tr>
                        <tr>
                            <th>Email:</th>
                            <td>${payment.email}</td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- Card Info (only if method is Card) -->
            <c:if test="${paymentMethod == 'Card'}">
                <div class="row mt-4">
                    <div class="col-md-6">
                        <h4>Card Information</h4>
                        <table class="table table-borderless">
                            <tr>
                                <th>Card Number:</th>
                                <td>
                                    **** **** **** ${fn:substring(payment.cardNumber, fn:length(payment.cardNumber) - 4, fn:length(payment.cardNumber))}
                                </td>
                            </tr>
                            <tr>
                                <th>Expiry Date:</th>
                                <td>${payment.expiryDate}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </c:if>

            <div class="mt-4">
                <button type="button" class="btn btn-success me-2"
                        onclick="updateStatus('${payment.paymentNumber}', 'COMPLETED')"
                ${payment.paymentStatus eq 'COMPLETED' ? 'disabled' : ''}>
                    <i class="bi bi-check-circle"></i> Mark as Completed
                </button>
                <button type="button" class="btn btn-danger"
                        onclick="deletePayment('${payment.paymentNumber}')">
                    <i class="bi bi-trash"></i> Delete Payment
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function updateStatus(paymentNumber, status) {
        if (confirm('Are you sure you want to mark this payment as completed?')) {
            fetch('${pageContext.request.contextPath}/payment/' + paymentNumber, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'paymentStatus=' + status
            }).then(res => res.ok ? location.reload() : alert('Update failed'));
        }
    }

    function deletePayment(paymentNumber) {
        if (confirm('Are you sure you want to delete this payment?')) {
            fetch('${pageContext.request.contextPath}/payment/' + paymentNumber, {
                method: 'DELETE'
            }).then(res => {
                if (res.ok) {
                    window.location.href = '${pageContext.request.contextPath}/payment';
                } else {
                    alert('Delete failed');
                }
            });
        }
    }
</script>
</body>
</html>
