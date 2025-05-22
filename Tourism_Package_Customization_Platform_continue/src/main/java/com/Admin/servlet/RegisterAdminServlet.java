package com.Admin.servlet;

import com.Admin.model.AdminUser ;
import com.Admin.DAO.AdminDAO ;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/RegisterAdminServlet")
public class RegisterAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        AdminUser admin = new AdminUser(username, password, email);
        AdminDAO.saveAdmin(admin);
        response.sendRedirect("Admin/Adminlogin.jsp");
    }
}

