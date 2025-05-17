<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // send anyone hitting "/" directly to your history servlet
    response.sendRedirect(request.getContextPath() + "/PackageListServlet");
%>
