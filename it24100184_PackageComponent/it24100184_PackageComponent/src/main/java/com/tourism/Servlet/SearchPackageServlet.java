package com.tourism.Servlet;

import com.tourism.DAO.PackageDAO;
import com.tourism.BST.PackageBST;
import com.tourism.model.TravelPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/searchPackage")
public class SearchPackageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String keyword = request.getParameter("keyword"); // Changed from "name" to "keyword" for clarity

        //String realPath = getServletContext().getRealPath("/WEB-INF/classes/packages.txt");
        PackageBST bst = PackageDAO.loadPackages();

        // Search by ID if provided
        if (id != null && !id.trim().isEmpty()) {
            TravelPackage found = bst.search(id);
            request.setAttribute("result", found);
            request.setAttribute("searchType", "id");
        }
        // Search by name or destination if keyword is provided
        else if (keyword != null && !keyword.trim().isEmpty()) {
            List<TravelPackage> foundList = bst.searchByNameOrDestination(keyword);
            request.setAttribute("resultList", foundList);
            request.setAttribute("searchType", "keyword");
        }

        request.getRequestDispatcher("/views/SearchPackage.jsp").forward(request, response);
    }
}