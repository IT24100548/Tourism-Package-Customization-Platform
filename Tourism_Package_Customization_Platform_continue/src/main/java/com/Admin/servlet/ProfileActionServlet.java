package com.Admin.servlet;

import com.Admin.DAO.AdminDAO;
import com.Admin.model.AdminUser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ProfileActionServlet")
public class ProfileActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        AdminUser currentAdmin = (AdminUser) session.getAttribute("user");

        if (currentAdmin == null) {
            response.sendRedirect("Admin/Adminlogin.jsp?error=Session expired. Please login again.");
            return;
        }

        String username = currentAdmin.getUsername();
        String action = request.getParameter("action");

        boolean success = false;

        switch (action) {
            case "changeEmail":
                String newEmail = request.getParameter("newEmail");
                if (newEmail != null && !newEmail.trim().isEmpty()) {
                    success = AdminDAO.updateAdminEmail(username, newEmail);
                    if (success) currentAdmin.setEmail(newEmail);
                }
                break;

            case "changePassword":
                String newPassword = request.getParameter("newPassword");
                if (newPassword != null && !newPassword.trim().isEmpty()) {
                    success = AdminDAO.updateAdminPassword(username, newPassword);
                    if (success) currentAdmin.setPassword(newPassword);
                }
                break;

            case "delete":
                success = AdminDAO.deleteAdmin(username);
                if (success) {
                    session.invalidate(); // logout after deletion
                    response.sendRedirect("Admin/Adminlogin.jsp?message=Account deleted successfully.");
                    return;
                }
                break;
        }

        // Update session attribute if needed
        if (success) {
            session.setAttribute("user", currentAdmin);
            response.sendRedirect("Admin/Profile.jsp?message=Update successful");
        } else {
            response.sendRedirect("Admin/Profile.jsp?error=Operation failed. Please try again.");
        }
    }
}

