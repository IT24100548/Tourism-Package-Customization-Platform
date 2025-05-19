package com.User.Servlet;

import com.User.DAO.UserDAO;
import com.User.model.AdminUser;
import com.User.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = UserDAO.validateUser(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect Admins and Travelers to different dashboards
            if (user instanceof AdminUser) {
                response.sendRedirect("Admin/AdminDashboard.jsp");
            } else {
                response.sendRedirect("User/TravelerDashboard.jsp");
            }
        } else {
            response.sendRedirect("User/login.jsp?error=Invalid Credentials");
        }
    }
}
