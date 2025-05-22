package com.Package.Servlet;

import com.Package.DAO.PackageDAO;
import com.Package.model.TravelPackage;
import com.Admin.model.AdminUser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


import java.util.List;

@WebServlet("/ViewPackage")
public class ViewPackageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sort = request.getParameter("sort"); // "price" or "id"
        PackageDAO.loadPackages();

        List<TravelPackage> packages;
        if ("price".equals(sort)) {
            packages = PackageDAO.getPackagesSortedByPrice();
        } else {
            packages = PackageDAO.packageTree.inorderTraversal(); // sort by ID
        }

        request.setAttribute("packages", packages);

        // Determine view (user or admin)
        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");
        String page = (user instanceof AdminUser) ? "/Package/viewPackagesAdmin.jsp" : "/Package/viewPackagesUser.jsp";
        request.getRequestDispatcher(page).forward(request, response);
    }
}


