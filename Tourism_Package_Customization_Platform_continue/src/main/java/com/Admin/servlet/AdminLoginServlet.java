package com.Admin.servlet;

import com.Admin.model.AdminUser;
import com.Admin.DAO.AdminDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminLogin")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        AdminUser admin = AdminDAO.validateAdmin(username, password);

        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", admin); // Store the full object, not just the username
            response.sendRedirect("Admin/AdminDashboard.jsp");
        }



        else {
            response.sendRedirect("Admin/Adminlogin.jsp?error=Invalid username or password.");
        }
    }
}
