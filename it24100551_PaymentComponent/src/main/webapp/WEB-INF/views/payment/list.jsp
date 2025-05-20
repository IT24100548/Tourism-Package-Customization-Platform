<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            color: #495057;
        }
        .payment-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-top: 2rem;
            margin-bottom: 2rem;
        }
        .page-header {
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
        }
        .search-box {
            position: relative;
            margin-bottom: 2rem;
        }
        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        .search-input {
            padding-left: 2.5rem;
            border-radius: 10px;
            border: 2px solid #e9ecef;
            transition: all 0.3s;
        }
        .search-input:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        .btn {
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
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
        .table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
        }
        .table thead {
            background-color: #f8f9fa;
        }
        .table th {
            border-top: none;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            color: #495057;
        }
        .table td {
            vertical-align: middle;
        }
        .badge {
            padding: 0.5rem 0.8rem;
            font-weight: 500;
            border-radius: 6px;
        }
        .badge.bg-success {
            background-color: #198754 !important;
        }
        .badge.bg-warning {
            background-color: #ffc107 !important;
            color: #000;
        }
        .badge.bg-danger {
            background-color: #dc3545 !important;
        }
        .btn-group .btn {
            padding: 0.4rem 0.6rem;
            margin: 0 0.1rem;
            border-radius: 6px;
        }
        .btn-info {
            background-color: #0dcaf0;
            border: none;
            color: white;
        }
        .btn-info:hover {
            background-color: #0bacce;
            color: white;
        }
        .btn-success {
            background-color: #198754;
            border: none;
        }
        .btn-success:hover {
            background-color: #157347;
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
        }
        .btn-danger:hover {
            background-color: #bb2d3b;
        }
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        .amount-column {
            font-weight: 600;
            color: #198754;
        }
        .payment-number {
            font-family: monospace;
            color: #0d6efd;
            font-weight: 500;
        }
        .table-hover tbody tr:hover {
            background-color: #f8f9fa;
            transition: background-color 0.3s;
        }
        .action-buttons {
            white-space: nowrap;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="payment-container">
            <div class="page-header d-flex justify-content-between align-items-center">
                <h2>
                    <i class="fas fa-list-ul me-2 text-primary"></i>
                    Payment List
                </h2>
                <a href="${pageContext.request.contextPath}/payment/new" class="btn btn-primary">
                    <i class="fas fa-plus-circle me-2"></i>New Payment
                </a>
            </div>

            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" class="form-control search-input" id="searchInput" 
                       placeholder="Search by customer name or mobile number...">
            </div>

            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><i class="fas fa-hashtag me-2"></i>Payment Number</th>
                            <th><i class="fas fa-user me-2"></i>Customer Name</th>
                            <th><i class="fas fa-phone me-2"></i>Mobile Number</th>
                            <th><i class="fas fa-envelope me-2"></i>Email</th>
                            <th><i class="fas fa-dollar-sign me-2"></i>Amount</th>
                            <th><i class="fas fa-info-circle me-2"></i>Status</th>
                            <th><i class="fas fa-cogs me-2"></i>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="paymentTableBody">
                        <c:forEach items="${payments}" var="payment">
                            <tr>
                                <td class="payment-number">${payment.paymentNumber}</td>
                                <td>${payment.customerName}</td>
                                <td>${payment.mobileNumber}</td>
                                <td>${payment.email}</td>
                                <td class="amount-column">
                                    <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="$"/>
                                </td>
                                <td>
                                    <span class="badge bg-${payment.paymentStatus eq 'COMPLETED' ? 'success' : 
                                                          payment.paymentStatus eq 'PENDING' ? 'warning' : 'danger'}">
                                        <i class="fas fa-${payment.paymentStatus eq 'COMPLETED' ? 'check-circle' : 
                                                           payment.paymentStatus eq 'PENDING' ? 'clock' : 'times-circle'} me-1"></i>
                                        ${payment.paymentStatus}
                                    </span>
                                </td>
                                <td class="action-buttons">
                                    <div class="btn-group" role="group">
                                        <a href="${pageContext.request.contextPath}/payment/${payment.paymentNumber}" 
                                           class="btn btn-info" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <button type="button" class="btn btn-success" 
                                                onclick="updateStatus('${payment.paymentNumber}', 'COMPLETED')"
                                                ${payment.paymentStatus eq 'COMPLETED' ? 'disabled' : ''}
                                                title="Mark as Completed">
                                            <i class="fas fa-check"></i>
                                        </button>
                                        <button type="button" class="btn btn-danger" 
                                                onclick="deletePayment('${payment.paymentNumber}')"
                                                title="Delete Payment">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty payments}">
                            <tr>
                                <td colspan="7" class="empty-state">
                                    <i class="fas fa-inbox fa-3x mb-3"></i>
                                    <h4>No payments found</h4>
                                    <p class="text-muted">Create a new payment to get started</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Search functionality
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const searchText = this.value.toLowerCase();
            const rows = document.getElementById('paymentTableBody').getElementsByTagName('tr');
            
            Array.from(rows).forEach(row => {
                const customerName = row.cells[1]?.textContent.toLowerCase() || '';
                const mobileNumber = row.cells[2]?.textContent.toLowerCase() || '';
                if (customerName.includes(searchText) || mobileNumber.includes(searchText)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });

        // Update payment status
        function updateStatus(paymentNumber, status) {
            if (confirm('Are you sure you want to mark this payment as completed?')) {
                const formData = new URLSearchParams();
                formData.append('paymentStatus', status);
                
                fetch('${pageContext.request.contextPath}/payment/' + paymentNumber, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: formData.toString()
                }).then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        alert('Error updating payment status');
                    }
                }).catch(error => {
                    console.error('Error:', error);
                    alert('Error updating payment status');
                });
            }
        }

        // Delete payment
        function deletePayment(paymentNumber) {
            if (confirm('Are you sure you want to delete this payment?')) {
                fetch('${pageContext.request.contextPath}/payment/' + paymentNumber, {
                    method: 'DELETE'
                }).then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        alert('Error deleting payment');
                    }
                });
            }
        }
    </script>
</body>
</html>
