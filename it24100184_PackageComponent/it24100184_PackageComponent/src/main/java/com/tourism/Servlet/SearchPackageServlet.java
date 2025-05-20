package com.tourism.Servlet;

import com.tourism.DAO.PackageDAO;
import com.tourism.BST.PackageBST;
import com.tourism.model.TravelPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/searchPackage")
public class SearchPackageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        String realPath = getServletContext().getRealPath("/WEB-INF/classes/packages.txt");
        PackageBST bst = PackageDAO.loadPackages(realPath);
        TravelPackage found = bst.search(id);

        request.setAttribute("result", found);
        request.getRequestDispatcher("/views/SearchPackage.jsp").forward(request, response); // Fixed path
    }
}