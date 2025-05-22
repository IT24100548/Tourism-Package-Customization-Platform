package com.Admin.servlet;
import com.User.DAO.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminDeleteTraveler")
public class AdminDeleteTravelerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = request.getParameter("username");

        if (userID != null && !userID.trim().isEmpty()) {
            boolean deleted = UserDAO.deleteTraveler(userID);

            if (deleted) {
                request.getSession().setAttribute("message", "Account deleted successfully.");
            } else {
                request.getSession().setAttribute("error", "Account not found.");
            }
        } else {
            request.getSession().setAttribute("error", "Invalid User ID.");
        }

        response.sendRedirect(request.getContextPath() + "/UserManagement");

    }
}
