package com.tourism.Servlet;

import com.tourism.DAO.PackageDAO;
import com.tourism.DAO.PackageSorter;
import com.tourism.BST.PackageBST;
import com.tourism.model.TravelPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@WebServlet("/viewPackages")
public class ViewPackageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //String realPath = getServletContext().getRealPath("/WEB-INF/classes/packages.txt");

        PackageBST bst = PackageDAO.loadPackages();
        List<TravelPackage> packages = bst.inorderTraversal(); // Default sort by ID

        // Get the sort parameter
        String sortBy = request.getParameter("sort");

        if (packages != null && !packages.isEmpty()) {
            if ("price".equalsIgnoreCase(sortBy)) {
                PackageSorter.quickSortByPrice(packages, 0, packages.size() - 1);
            } else if ("name".equalsIgnoreCase(sortBy)) {
                Collections.sort(packages, Comparator.comparing(TravelPackage::getName));
            } else if ("destination".equalsIgnoreCase(sortBy)) {
                Collections.sort(packages, Comparator.comparing(TravelPackage::getDestination));
            }
            // Default sorting (by ID) is already done via inorderTraversal
        }

        System.out.println("[ViewPackageServlet] Loaded: " + (packages == null ? "null" : packages.size()));

        request.setAttribute("packages", packages);
        request.setAttribute("currentSort", sortBy != null ? sortBy : "id"); // Pass current sort to JSP
        request.getRequestDispatcher("/views/ViewPackage.jsp").forward(request, response);
    }
}