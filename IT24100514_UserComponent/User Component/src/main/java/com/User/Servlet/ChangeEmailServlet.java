package com.User.Servlet;

import com.User.DAO.UserDAO;
import com.User.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/change-email")
public class ChangeEmailServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("User/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String username = user.getUsername();
        String newEmail = request.getParameter("newEmail");

        if (newEmail == null || newEmail.trim().isEmpty()) {
            session.setAttribute("error1Message", "Email cannot be empty!");
            response.sendRedirect("User/profile.jsp");
            return;
        }

        boolean success = userDAO.updateTravelerEmail(username, newEmail);

        if (success) {
            session.setAttribute("success1Message", "Email updated successfully!");
            // Also update session
            user.setEmail(newEmail);
            session.setAttribute("user", user);
        } else {
            session.setAttribute("error1Message", "Failed to update email!");
        }

        response.sendRedirect("User/profile.jsp");
    }
}
