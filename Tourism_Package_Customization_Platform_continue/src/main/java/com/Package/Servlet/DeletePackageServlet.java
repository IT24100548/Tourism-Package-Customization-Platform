package com.Package.Servlet;

import com.Package.DAO.PackageDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeletePackage")
public class DeletePackageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String packageId = request.getParameter("packageId");

        if (packageId != null && !packageId.trim().isEmpty()) {
            boolean deleted = PackageDAO.deletePackage(packageId);

            if (deleted) {
                request.getSession().setAttribute("message", "Package deleted successfully.");
            } else {
                request.getSession().setAttribute("error", "Package not found.");
            }
        } else {
            request.getSession().setAttribute("error", "Invalid package ID.");
        }

        response.sendRedirect(request.getContextPath() + "/ViewPackage");

    }
}
