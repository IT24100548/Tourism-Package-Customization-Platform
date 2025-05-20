package com.tourism.Servlet;

import com.tourism.DAO.PackageDAO;
import com.tourism.BST.PackageBST;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deletePackage")
public class DeletePackageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        String realPath = getServletContext().getRealPath("/WEB-INF/classes/packages.txt");
        PackageBST bst = PackageDAO.loadPackages(realPath);
        bst.delete(id);
        PackageDAO.savePackages(bst, realPath);

        response.sendRedirect("viewPackages");
    }
}