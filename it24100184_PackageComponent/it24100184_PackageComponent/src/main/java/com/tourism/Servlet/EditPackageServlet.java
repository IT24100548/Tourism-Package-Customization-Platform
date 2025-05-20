package com.tourism.Servlet;

import com.tourism.DAO.PackageDAO;
import com.tourism.BST.PackageBST;
import com.tourism.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/editPackage")
public class EditPackageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("loadId");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("viewPackages");
            return;
        }

        String realPath = getServletContext().getRealPath("/WEB-INF/classes/packages.txt");
        PackageBST bst = PackageDAO.loadPackages(realPath);
        TravelPackage pkg = bst.search(id);

        if (pkg != null) {
            request.setAttribute("package", pkg);
            request.getRequestDispatcher("/views/EditPackage.jsp").forward(request, response); // Fixed path
        } else {
            response.sendRedirect("viewPackages");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("viewPackages");
            return;
        }

        String realPath = getServletContext().getRealPath("/WEB-INF/classes/packages.txt");
        PackageBST bst = PackageDAO.loadPackages(realPath);
        bst.delete(id); // Remove old package

        // Insert new one with updated details
        String name = request.getParameter("name");
        String destination = request.getParameter("destination");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String type = request.getParameter("type");
        String extra = request.getParameter("extra");

        try {
            double price = Double.parseDouble(priceStr);
            TravelPackage updated;
            if ("Adventure".equalsIgnoreCase(type)) {
                updated = new AdventurePackage(id, name, destination, price, description, extra);
            } else {
                updated = new LeisurePackage(id, name, destination, price, description, extra);
            }

            bst.insert(updated);
            PackageDAO.savePackages(bst, realPath);
            response.sendRedirect("viewPackages");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price format.");
            request.getRequestDispatcher("/views/EditPackage.jsp").forward(request, response); // Fixed path
        }
    }
}