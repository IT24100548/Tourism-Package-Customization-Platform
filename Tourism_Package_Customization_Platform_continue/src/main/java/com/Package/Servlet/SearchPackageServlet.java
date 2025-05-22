package com.Package.Servlet;



import com.Package.model.TravelPackage;
import com.Package.BST.PackageBST;
import com.Package.DAO.PackageDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/SearchPackage")
public class SearchPackageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("name").trim().toLowerCase();

        PackageDAO.loadPackages();  // Load if not already done
        List<TravelPackage> results = PackageDAO.packageTree.searchByNameOrDestination(keyword);

        request.setAttribute("results", results);
        request.getRequestDispatcher("Package/SearchPackage.jsp").forward(request, response);
    }
}

