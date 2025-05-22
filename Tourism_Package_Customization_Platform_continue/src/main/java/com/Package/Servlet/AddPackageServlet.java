package com.Package.Servlet;

import com.Package.DAO.PackageDAO;
import com.Package.model.AdventurePackage;
import com.Package.model.LeisurePackage;
import com.Package.model.TravelPackage;
import com.Package.BST.PackageBST;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AddPackage")
public class AddPackageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Load existing packages into BST (if not already loaded)
        PackageDAO.packageTree = new PackageBST(); // Reinitialize in case of restart
        PackageDAO.loadPackages();

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String destination = request.getParameter("destination");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String type = request.getParameter("type");

        TravelPackage newPackage = null;

        if ("ADVENTURE".equalsIgnoreCase(type)) {
            String activity = request.getParameter("activityType");
            newPackage = new AdventurePackage(id, name, destination, price, description, activity);
        } else if ("LEISURE".equalsIgnoreCase(type)) {
            String hotel = request.getParameter("hotelType");
            newPackage = new LeisurePackage(id, name, destination, price, description, hotel);
        }

        if (newPackage != null) {
            PackageDAO.packageTree.insert(newPackage);
            PackageDAO.savePackages(); // Now safe to save
            response.sendRedirect("Package/AddPackage.jsp?success=1");
        } else {
            response.sendRedirect("Package/AddPackage.jsp?error=1");
        }
    }
}

