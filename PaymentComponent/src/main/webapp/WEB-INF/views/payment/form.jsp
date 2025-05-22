<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .payment-form {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            margin-top: 40px;
            margin-bottom: 40px;
        }
        .form-label { font-weight: 600; color: #495057; margin-bottom: 8px; }
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
        .btn-primary { background: #0d6efd; border: none; }
        .btn-primary:hover { background: #0b5ed7; transform: translateY(-1px); }
        .btn-secondary { background: #6c757d; border: none; }
        .btn-secondary:hover { background: #5c636a; }
        .card-icon { color: #0d6efd; margin-right: 8px; }
        .form-header {
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 30px;
            padding-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="payment-form">
                <div class="form-header text-center">
                    <h2><i class="fas fa-credit-card card-icon"></i> Payment Details</h2>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/payment" method="post" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label class="form-label">Customer Name</label>
                        <input type="text" name="customerName" class="form-control" id="customerName" required pattern="[A-Za-z ]{2,50}" placeholder="Janith">
                        <div class="invalid-feedback">Name must be 2-50 letters and spaces only</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mobile Number</label>
                        <div class="input-group">
                            <span class="input-group-text">+94</span>
                            <input type="text" name="mobileNumber" class="form-control" id="mobileNumber" required pattern="\d{10}" placeholder="771234567">
                        </div>
                        <div class="invalid-feedback">Must be 10 digits</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" id="email" required placeholder="janith@example.com">
                        <div class="invalid-feedback">Enter a valid email</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Payment Method</label>
                        <select class="form-select" id="paymentMethod" name="paymentMethod" required onchange="togglePaymentFields(this.value)">
                            <option value="">-- Select Method --</option>
                            <option value="Card">Card</option>
                            <option value="PayPal">PayPal</option>
                        </select>
                        <div class="invalid-feedback">Select a payment method</div>
                    </div>

                    <!-- Card Fields -->
                    <div id="cardFields" style="display:none;">
                        <div class="mb-3">
                            <label class="form-label">Card Number</label>
                            <input type="text" class="form-control" id="cardNumber" name="cardNumber"
                                   placeholder="1111 2222 3333 4444" maxlength="19" inputmode="numeric">
                            <div class="invalid-feedback">Must be 16 digits</div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">CVV</label>
                                <input type="text" class="form-control" id="cvv" name="cvv" pattern="\d{3}" placeholder="123">
                                <div class="invalid-feedback">3 digits required</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Expiry Date</label>
                                <input type="text" class="form-control" id="expiryDate" name="expiryDate" placeholder="MM/YY" pattern="(0[1-9]|1[0-2])\/\d{2}">
                                <div class="invalid-feedback">Format MM/YY</div>
                            </div>
                        </div>
                    </div>

                    <!-- PayPal Fields -->
                    <div id="paypalFields" style="display:none;">
                        <div class="mb-3">
                            <label class="form-label">PayPal Email</label>
                            <input type="email" class="form-control" id="paypalEmail" name="paypalEmail" placeholder="paypal@example.com">
                            <div class="invalid-feedback">Valid PayPal email required</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Amount (LKR)</label>
                        <div class="input-group">
                            <span class="input-group-text">LKR</span>
                            <input type="number" class="form-control" name="amount" id="amount" min="0.01" step="0.01" required placeholder="100.00">
                        </div>
                        <div class="invalid-feedback">Amount must be greater than 0</div>
                    </div>

                    <div class="d-flex justify-content-end gap-2">
                        <a href="${pageContext.request.contextPath}/payment" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary">Submit Payment</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function togglePaymentFields(method) {
        document.getElementById('cardFields').style.display = method === 'Card' ? 'block' : 'none';
        document.getElementById('paypalFields').style.display = method === 'PayPal' ? 'block' : 'none';
    }

    function formatCardNumber(input) {
        let digits = input.value.replace(/\D/g, '').substring(0, 16);
        input.value = digits.replace(/(.{4})/g, '$1 ').trim();
        input.setCustomValidity(digits.length === 16 ? '' : 'Card number must be 16 digits');
    }

    document.addEventListener('DOMContentLoaded', () => {
        togglePaymentFields(document.getElementById('paymentMethod').value);

        document.getElementById('customerName').addEventListener('input', e => {
            e.target.value = e.target.value.replace(/[^A-Za-z ]/g, '');
        });

        document.getElementById('mobileNumber').addEventListener('input', e => {
            e.target.value = e.target.value.replace(/\D/g, '').substring(0, 10);
        });

        document.getElementById('cardNumber')?.addEventListener('input', e => formatCardNumber(e.target));
        document.getElementById('cvv')?.addEventListener('input', e => e.target.value = e.target.value.replace(/\D/g, '').substring(0, 3));
        document.getElementById('expiryDate')?.addEventListener('input', function () {
            if (this.value.length === 2 && !this.value.includes('/')) this.value += '/';
        });

        Array.from(document.querySelectorAll('.needs-validation')).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            });
        });
    });
</script>
</body>
</html>
