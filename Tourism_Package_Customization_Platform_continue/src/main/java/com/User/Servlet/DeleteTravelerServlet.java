package com.User.Servlet;

import com.User.DAO.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Delete")
public class DeleteTravelerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");

        UserDAO userDAO = new UserDAO();
        boolean deleted = userDAO.deleteTraveler(username);

        if (deleted) {
            request.getSession().setAttribute("deleteMessage", "Account has been deleted Successfully");
            response.sendRedirect("User/index.jsp");

        } else {
            System.out.println("Failed to delete account: " + username);
            request.getSession().setAttribute("error2Message", "Account deletion failed. Please try again.");
            response.sendRedirect("User/TravelerDashboard.jsp");
        }
    }
}
