<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Access Denied</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .unauthorized-container {
            max-width: 600px;
            margin: 4rem auto;
            padding: 2rem;
            background-color: var(--cibc-white);
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            text-align: center;
        }
        .unauthorized-message {
            font-size: 1.2rem;
            font-weight: bold;
            color: var(--cibc-red);
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <div class="unauthorized-container">
        <h2>Access Denied!</h2>
        <p class="unauthorized-message">
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