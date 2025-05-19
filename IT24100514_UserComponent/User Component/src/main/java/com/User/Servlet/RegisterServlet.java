package com.User.Servlet;

import com.User.DAO.UserDAO;
import com.User.model.Traveler;
import com.User.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");


        // Ensure no admin registration happens
        if (request.getParameter("role") != null && request.getParameter("role").equalsIgnoreCase("admin")) {
            response.sendRedirect("register.jsp?error=Admin%20registration%20not%20allowed");
            return;
        }

        User newUser = new Traveler(username, email, password);
        UserDAO.saveUser(newUser);
        response.sendRedirect("User/login.jsp");
    }
}
