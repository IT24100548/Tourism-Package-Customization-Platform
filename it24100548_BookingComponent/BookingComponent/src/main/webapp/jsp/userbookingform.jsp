<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>User Booking</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary: #4361ee;
      --primary-hover: #3a56d4;
      --primary-light: #eef2ff;
      --success: #10b981;
      --success-light: #d1fae5;
      --danger: #ef4444;
      --danger-light: #fee2e2;
      --warning: #f59e0b;
      --gray-light: #f3f4f6;
      --gray-medium: #e5e7eb;
      --gray-dark: #6b7280;
      --text-primary: #111827;
      --text-secondary: #4b5563;
      --border-radius: 8px;
      --border-radius-lg: 12px;
      --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
      --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      --transition: all 0.2s ease-in-out;
    }

    * {
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', sans-serif;
      background: #f9fafb;
      margin: 0;
      padding: 0;
      color: var(--text-primary);
      line-height: 1.5;
    }

    .container {
      max-width: 1000px;
      margin: 40px auto;
      padding: 0 20px;
    }

    .form-container {
      background: #fff;
      border-radius: var(--border-radius-lg);
      box-shadow: var(--shadow-md);
      overflow: hidden;
      position: relative;
    }

    .form-header {
      background: var(--primary);
      color: white;
      padding: 20px 30px;
      display: flex;
      align-items: center;
    }

    .form-header i {
      font-size: 24px;
      margin-right: 15px;
    }

    .form-title {
      font-size: 20px;
      font-weight: 600;
      margin: 0;
    }

    .form-body {
      padding: 30px;
    }

    .form-row {
      display: flex;
      flex-wrap: wrap;
      margin: 0 -15px;
    }

    .form-col {
      flex: 1;
      min-width: 250px;
      padding: 0 15px;
      margin-bottom: 20px;
    }

    .form-group {
      margin-bottom: 20px;
      position: relative;
    }

    label {
      font-weight: 500;
      margin-bottom: 8px;
      display: block;
      color: var(--text-secondary);
      font-size: 14px;
    }

    .required-field::after {
      content: " *";
      color: var(--danger);
    }

    input, select, textarea {
      width: 100%;
      padding: 12px 15px;
      border: 1px solid var(--gray-medium);
      border-radius: var(--border-radius);
      font-family: 'Inter', sans-serif;
      font-size: 15px;
      transition: var(--transition);
      background-color: white;
    }

    input:focus, select:focus, textarea:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.2);
    }

    textarea {
      min-height: 100px;
      resize: vertical;
    }

    button {
      background-color: var(--primary);
      color: #fff;
      padding: 14px 20px;
      border: none;
      border-radius: var(--border-radius);
      cursor: pointer;
      font-weight: 600;
      font-size: 16px;
      width: 100%;
      margin-top: 10px;
      transition: var(--transition);
      display: flex;
      align-items: center;
      justify-content: center;
    }

    button:hover {
      background-color: var(--primary-hover);
    }

    button i {
      margin-right: 8px;
    }

    .success-popup {
      display: none;
      background-color: var(--success-light);
      color: var(--success);
      padding: 15px;
      text-align: center;
      border-radius: var(--border-radius);
      margin-top: 20px;
      border: 1px solid var(--success);
      font-weight: 500;
    }

    .input-error {
      display: none;
      color: var(--danger);
      font-size: 13px;
      margin-top: 5px;
      font-weight: 500;
    }

    .form-group.error input,
    .form-group.error select,
    .form-group.error textarea {
      border-color: var(--danger);
      background-color: var(--danger-light);
    }

    .form-group.error .input-error {
      display: block;
    }

    .form-group.success input,
    .form-group.success select,
    .form-group.success textarea {
      border-color: var(--success);
      background-color: var(--success-light);
    }

    .input-icon {
      position: relative;
    }

    .input-icon i {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--gray-dark);
      pointer-events: none;
    }

    /* Adjust padding for inputs with icons */
    .input-icon input {
      padding-right: 40px;
    }

    @media (max-width: 768px) {
      .form-col {
        flex: 100%;
      }

      .form-body {
        padding: 20px;
      }
    }

    /* Animation for success message */
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .animate-fade {
      animation: fadeIn 0.3s ease-out forwards;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="form-container">
    <div class="form-header">
      <i class="fas fa-calendar-plus"></i>
      <h2 class="form-title">New Booking</h2>
    </div>

    <div class="form-body">
      <form id="bookingForm" action="<%= request.getContextPath() %>/BookingServlet" method="post">
        <input type="hidden" name="source" value="user">

        <div class="form-row">
          <div class="form-col">
            <div class="form-group">
              <label class="required-field">Full Name</label>
              <input type="text" id="fullName" name="fullName" required pattern="[A-Za-z\s]+" placeholder="John Doe">
              <div class="input-error">Only letters and spaces allowed</div>
            </div>
          </div>

          <div class="form-col">
            <div class="form-group">
              <label class="required-field">Phone Number</label>
              <input type="text" id="phoneNumber" name="phoneNumber" required pattern="^\+?[0-9\s]{7,15}$" placeholder="0712175244">
              <div class="input-error">Enter a valid phone number (7-15 digits)</div>
            </div>
          </div>
        </div>

        <div class="form-group">
          <label class="required-field">Address</label>
          <input type="text" id="address" name="address" required pattern="[A-Za-z0-9\s,./\-#]{5,100}" placeholder="123 Main St, Colombo">
          <div class="input-error">Enter a valid address (5-100 characters)</div>
        </div>

        <div class="form-row">
          <div class="form-col">
            <div class="form-group">
              <label class="required-field">Gender</label>
              <select id="gender" name="gender" required>
                <option value="" disabled selected>Select your gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
              </select>
              <div class="input-error">Please select a gender</div>
            </div>
          </div>

          <div class="form-col">
            <div class="form-group input-icon">
              <label class="required-field">Email</label>
              <input type="email" id="email" name="email" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" placeholder="your@email.com">
              <div class="input-error">Enter a valid email address</div>
            </div>
          </div>
        </div>

        <div class="form-row">
          <div class="form-col">
            <div class="form-group">
              <label class="required-field">Package</label>
              <select name="packageName" required>
                <option value="" disabled selected>Select a package</option>
                <%= request.getAttribute("packageOptions") %>
              </select>
              <div class="input-error">Please select a package</div>
            </div>
          </div>

          <div class="form-col">
            <div class="form-group">
              <label class="required-field">Booking Type</label>
              <select name="bookingType" id="bookingType" required onchange="togglePeopleInput()">
                <option value="solo" selected>Solo Booking</option>
                <option value="group">Group Booking</option>
              </select>
            </div>
          </div>
        </div>

        <div class="form-row">
          <div class="form-col">
            <div class="form-group input-icon">
              <label class="required-field">Booking Date</label>
              <input type="date" name="bookingDate" required min="<%= java.time.LocalDate.now() %>">
            </div>
          </div>

          <div class="form-col">
            <div class="form-group">
              <label class="required-field">Number of People</label>
              <input type="number" id="numberOfPeople" name="numberOfPeople" min="1" required value="1">
            </div>
          </div>
        </div>

        <div class="form-group">
          <label>Special Requirements</label>
          <textarea name="specialRequirements" placeholder="Any special requests or requirements..."></textarea>
        </div>

        <button type="submit">
          <i class="fas fa-paper-plane"></i> Submit Booking
        </button>
      </form>

      <div class="success-popup animate-fade" id="successMessage">
        <i class="fas fa-check-circle"></i> Booking submitted successfully! We'll contact you shortly.
      </div>
    </div>
  </div>
</div>

<script>
  function togglePeopleInput() {
    const type = document.getElementById("bookingType").value;
    const nop = document.getElementById("numberOfPeople");
    if (type === "solo") {
      nop.value = 1;
      nop.readOnly = true;
      nop.style.backgroundColor = "var(--gray-light)";
    } else {
      nop.readOnly = false;
      nop.style.backgroundColor = "white";
    }
  }

  document.addEventListener("DOMContentLoaded", function() {
    // Initialize form
    togglePeopleInput();

    // Set minimum date to today
    const today = new Date().toISOString().split('T')[0];
    document.querySelector("input[type='date']").min = today;

    const form = document.getElementById("bookingForm");
    const fields = form.querySelectorAll("input, select, textarea");

    // Real-time validation
    fields.forEach(field => {
      field.addEventListener("input", function() {
        const parent = this.closest(".form-group");
        if (this.checkValidity()) {
          parent.classList.remove("error");
          parent.classList.add("success");
        } else {
          parent.classList.remove("success");
        }
      });

      field.addEventListener("blur", function() {
        const parent = this.closest(".form-group");
        if (!this.checkValidity()) {
          parent.classList.add("error");
        }
      });
    });

    form.addEventListener("submit", function(e) {
      let isValid = true;

      // Validate all fields
      fields.forEach(field => {
        const parent = field.closest(".form-group");
        if (!field.checkValidity()) {
          parent.classList.add("error");
          isValid = false;

          // Scroll to first error
          if (isValid === false) {
            field.focus();
            isValid = null; // Prevent changing back to true
          }
        } else {
          parent.classList.remove("error");
        }
      });

      if (!isValid) {
        e.preventDefault();
        return;
      }

      // Show success message (in a real app, this would be after server response)
      e.preventDefault();
      document.getElementById("successMessage").style.display = "block";
      form.reset();
      window.scrollTo({ top: 0, behavior: 'smooth' });

      // Reset form after delay (for demo)
      setTimeout(() => {
        document.getElementById("successMessage").style.display = "none";
      }, 5000);
    });

    // Input formatting and restrictions
    document.getElementById("fullName").addEventListener("input", function() {
      this.value = this.value.replace(/[^A-Za-z\s]/g, '');
    });

    document.getElementById("phoneNumber").addEventListener("input", function() {
      this.value = this.value.replace(/[^0-9+\s]/g, '');
    });

    document.getElementById("email").addEventListener("input", function() {
      this.value = this.value.toLowerCase().replace(/[^a-z0-9@._%+\-]/g, '');
    });
  });
</script>

</body>
</html>