package com.Admin.servlet;

import com.Admin.DAO.AdminDAO;
import com.Admin.model.AdminUser;
import com.User.DAO.UserDAO;
import com.User.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/UserManagement")
public class UserManagementServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> userList = UserDAO.getUsers();
        request.setAttribute("userList", userList);

        request.getRequestDispatcher("/Admin/UserManagement.jsp").forward(request, response);

    }
}
