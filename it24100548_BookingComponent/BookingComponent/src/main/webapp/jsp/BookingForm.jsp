<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>New Booking</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #eef2ff;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --dark: #1f2937;
            --light: #f9fafb;
            --gray: #6b7280;
            --gray-light: #f3f4f6;
            --border-radius: 12px;
            --shadow-sm: 0 1px 2px 0 rgba(0,0,0,0.05);
            --shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
            --shadow-md: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body, html {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--gray-light);
            color: var(--dark);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
        }

        .navbar-pro {
            background: white;
            box-shadow: var(--shadow);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 32px;
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .navbar-pro .logo {
            font-size: 20px;
            font-weight: 700;
            color: var(--primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo-icon {
            color: var(--primary);
            font-size: 22px;
        }

        .nav-links {
            display: flex;
            gap: 24px;
        }

        .nav-links a {
            font-size: 15px;
            font-weight: 500;
            color: var(--gray);
            text-decoration: none;
            transition: all 0.2s ease;
            padding: 8px 0;
            position: relative;
        }

        .nav-links a:hover {
            color: var(--primary);
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary);
            transition: width 0.3s ease;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .booking-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .booking-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 40px;
        }

        .form-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .form-title {
            font-size: 24px;
            font-weight: 700;
            color: var(--dark);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .form-title i {
            color: var(--primary);
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark);
            margin: 32px 0 20px;
            padding-bottom: 8px;
            border-bottom: 1px solid var(--gray-light);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            color: var(--primary);
            font-size: 16px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 24px;
        }

        .form-field {
            margin-bottom: 8px;
        }

        .form-field label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 500;
            color: var(--gray);
        }

        .form-field input,
        .form-field select,
        .form-field textarea {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--gray-light);
            border-radius: 8px;
            font-size: 15px;
            font-family: 'Inter', sans-serif;
            transition: all 0.2s ease;
            background-color: white;
        }

        .form-field input:focus,
        .form-field select:focus,
        .form-field textarea:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
            outline: none;
        }

        .form-field textarea {
            min-height: 120px;
            resize: vertical;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        .form-footer {
            display: flex;
            justify-content: flex-end;
            gap: 16px;
            margin-top: 40px;
            padding-top: 24px;
            border-top: 1px solid var(--gray-light);
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn i {
            font-size: 14px;
        }

        .cancel-btn {
            background-color: white;
            color: var(--gray);
            border: 1px solid var(--gray-light);
        }

        .cancel-btn:hover {
            background-color: var(--gray-light);
            border-color: var(--gray);
        }

        .submit-btn {
            background-color: var(--primary);
            color: white;
            border: none;
        }

        .submit-btn:hover {
            background-color: #3a56d4;
        }

        .input-hint {
            font-size: 13px;
            color: var(--gray);
            margin-top: 6px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .input-hint i {
            font-size: 12px;
        }

        .input-error {
            color: var(--danger);
            font-size: 13px;
            margin-top: 6px;
            display: none;
        }

        .form-field.error input,
        .form-field.error select,
        .form-field.error textarea {
            border-color: var(--danger);
        }

        .form-field.error .input-error {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        @media (max-width: 768px) {
            .booking-card {
                padding: 30px 20px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-footer {
                flex-direction: column-reverse;
                gap: 12px;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>

<div class="navbar-pro">
    <a href="<%= request.getContextPath() %>/" class="logo">
        <i class="fas fa-calendar-alt logo-icon"></i>
        <span>Booking Manager</span>
    </a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/PackageListServlet">
            <i class="fas fa-plus-circle"></i> New Booking
        </a>
        <a href="<%= request.getContextPath() %>/BookingHistoryServlet">
            <i class="fas fa-history"></i> Booking History
        </a>
    </div>
</div>
<div class="booking-container">
    <div class="booking-card">
        <div class="form-header">
            <h1 class="form-title">
                <i class="fas fa-plus-circle"></i> New Booking
            </h1>
        </div>
        <form id="bookingForm" action="<%= request.getContextPath() %>/BookingServlet" method="post">
            <div class="section-title">
                <i class="fas fa-user"></i> Customer Information
            </div>
            <div class="form-grid">
                <div class="form-field">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" required pattern="[A-Za-z\s]+" title="Only letters and spaces allowed" placeholder="John Doe">
                    <div class="input-error">
                        <i class="fas fa-exclamation-circle"></i> Please enter a valid name
                    </div>
                </div>
                <div class="form-field">
                    <label for="phoneNumber">Phone Number</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" required pattern="^\+?[0-9\s]{7,15}$" title="Only numbers, spaces, and optional '+' at the start" placeholder="0712345678">
                    <div class="input-error">
                        <i class="fas fa-exclamation-circle"></i> Please enter a valid phone number
                    </div>
                </div>
                <div class="form-field">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required placeholder="john.doe@example.com" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
                    <div class="input-error">
                        <i class="fas fa-exclamation-circle"></i> Please enter a valid email
                    </div>
                </div>
                <div class="form-field">
                    <label for="gender">Gender</label>
                    <select id="gender" name="gender" required>
                        <option value="" disabled selected>Select Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                    <div class="input-error">
                        <i class="fas fa-exclamation-circle"></i> Please select a gender
                    </div>
                </div>
                <div class="form-field full-width">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" required pattern="[A-Za-z0-9\s,./\-#]{5,100}" title="Street address with numbers and symbols" placeholder="123 Main Street, Colombo">
                    <div class="input-error">
                        <i class="fas fa-exclamation-circle"></i> Please enter a valid address
                    </div>
                </div>
            </div>
            <div class="section-title">
                <i class="fas fa-calendar-alt"></i> Booking Details
            </div>
            <div class="form-grid">
                <div class="form-field">
                    <label for="packageName">Package</label>
                    <select id="packageName" name="packageName" required>
                        <option value="" disabled selected>Select a Package</option>
                        <%= request.getAttribute("packageOptions") %>
                    </select>
                    <div class="input-error">
                        <i class="fas fa-exclamation-circle"></i> Please select a package
                    </div>
                </div>
                <div class="form-field">
                    <label for="bookingType">Booking Type</label>
                    <select id="bookingType" name="bookingType" required onchange="togglePeopleInput()">
                        <option value="solo">Solo Booking</option>
                        <option value="group">Group Booking</option>
                    </select>
                </div>
                <div class="form-field">
                    <label for="numberOfPeople">Number of People</label>
                    <input type="number" id="numberOfPeople" name="numberOfPeople" min="1" value="1" placeholder="1">
                    <div class="input-hint">
                        <i class="fas fa-info-circle"></i> Minimum 1 person
                    </div>
                </div>
                <div class="form-field">
                    <label for="bookingDate">Booking Date</label>
                    <input type="date" id="bookingDate" name="bookingDate" required min="<%= java.time.LocalDate.now() %>">
                    <div class="input-hint">
                        <i class="fas fa-calendar-day"></i> Future dates only
                    </div>
                </div>
                <div class="form-field full-width">
                    <label for="specialRequirements">Special Requirements</label>
                    <textarea id="specialRequirements" name="specialRequirements" placeholder="Any allergies, dietary restrictions, or special notes..."></textarea>
                    <div class="input-hint">
                        <i class="fas fa-edit"></i> Optional information
                    </div>
                </div>
            </div>
            <div class="form-footer">
                <a href="<%= request.getContextPath() %>/BookingHistoryServlet" class="btn cancel-btn">
                    <i class="fas fa-times"></i> Cancel
                </a>
                <button type="submit" class="btn submit-btn">
                    <i class="fas fa-plus"></i> Create Booking
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    // Toggle people input based on booking type
    function togglePeopleInput() {
        const type = document.getElementById("bookingType").value;
        const nop = document.getElementById("numberOfPeople");
        if (type === "solo") {
            nop.value = 1;
            nop.readOnly = true;
        } else {
            nop.readOnly = false;
        }
    }

    // Initialize form validation
    document.addEventListener("DOMContentLoaded", function() {
        togglePeopleInput();

        // Form validation
        const form = document.getElementById('bookingForm');
        const fields = form.querySelectorAll('input, select, textarea');

        fields.forEach(field => {
            // Validate on blur
            field.addEventListener('blur', function() {
                validateField(this);
            });

            // Input sanitization
            if (field.id === 'fullName') {
                field.addEventListener('input', function() {
                    this.value = this.value.replace(/[^a-zA-Z\s]/g, '');
                });
            }
            if (field.id === 'phoneNumber') {
                field.addEventListener('input', function() {
                    this.value = this.value.replace(/[^0-9+\s]/g, '');
                });
            }
            if (field.id === 'email') {
                field.addEventListener('input', function() {
                    this.value = this.value.replace(/[^a-z0-9@._%+\-]/g, '');
                });
            }
            if (field.id === 'address') {
                field.addEventListener('input', function() {
                    this.value = this.value.replace(/[^a-zA-Z0-9\s,./\-#]/g, '');
                });
            }
        });

        // Form submission
        form.addEventListener('submit', function(e) {
            let isValid = true;
            fields.forEach(field => {
                if (!validateField(field)) {
                    isValid = false;
                }
            });

            if (!isValid) {
                e.preventDefault();
                // Scroll to first error
                const firstError = form.querySelector('.error');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });
    });

    function validateField(field) {
        const formField = field.closest('.form-field');
        const errorElement = formField.querySelector('.input-error');

        if (field.required && !field.value.trim()) {
            formField.classList.add('error');
            return false;
        }

        if (field.pattern) {
            const regex = new RegExp(field.pattern);
            if (!regex.test(field.value)) {
                formField.classList.add('error');
                return false;
            }
        }

        formField.classList.remove('error');
        return true;
    }
</script>

</body>
</html>