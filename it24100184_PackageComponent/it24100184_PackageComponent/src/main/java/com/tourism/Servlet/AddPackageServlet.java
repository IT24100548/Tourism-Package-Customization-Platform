package com.tourism.Servlet;

import com.tourism.DAO.PackageDAO;
import com.tourism.BST.PackageBST;
import com.tourism.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addPackage")
public class AddPackageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String destination = request.getParameter("destination");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String type = request.getParameter("type");
        String extra = request.getParameter("extra");

        TravelPackage pkg = null;
        if ("Adventure".equalsIgnoreCase(type)) {
            pkg = new AdventurePackage(id, name, destination, price, description, extra);
        } else if ("Leisure".equalsIgnoreCase(type)) {
            pkg = new LeisurePackage(id, name, destination, price, description, extra);
        }

        if (pkg != null) {
            //String realPath = getServletContext().getRealPath("/WEB-INF/classes/packages.txt");
            PackageBST bst = PackageDAO.loadPackages();
            bst.insert(pkg);
            PackageDAO.savePackages(bst);
        }

        response.sendRedirect("views/AddPackage.jsp?success=true");
    }
}