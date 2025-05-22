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

@WebServlet("/change-username")
public class ChangeUsernameServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("User/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String currentUsername = user.getUsername();
        String newUsername = request.getParameter("newUsername");

        if (newUsername == null || newUsername.trim().isEmpty()) {
            session.setAttribute("error1Message", "Username cannot be empty!");
            response.sendRedirect("User/profile.jsp");
            return;
        }

        boolean success = userDAO.updateTravelerUsername(currentUsername, newUsername);

        if (success) {
            session.setAttribute("success1Message", "Username updated successfully!");
            // Update session
            user.setUsername(newUsername);
            session.setAttribute("user", user);
        } else {
            session.setAttribute("error1Message", "Failed to update username!");
        }

        response.sendRedirect("User/profile.jsp");
    }
}

