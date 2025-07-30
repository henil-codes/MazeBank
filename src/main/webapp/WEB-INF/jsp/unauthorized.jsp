<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Access Denied</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h2>Access Denied!</h2>
        <p style="color: red;">
            <% if (request.getAttribute("errorMessage")!= null) { %>
                <%= request.getAttribute("errorMessage") %>
            <% } else { %>
                You do not have the necessary permissions to view this page.
            <% } %>
        </p>
        <p><a href="${pageContext.request.contextPath}/app/dashboard">Go to Dashboard</a></p>
        <p><a href="${pageContext.request.contextPath}/index.jsp">Go to Login Page</a></p>
    </div>
</body>
</html>