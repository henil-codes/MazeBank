<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MazeBank - Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h2>Welcome to MazeBank!</h2>
        
        <%-- Display messages --%>
        <% if (request.getAttribute("message")!= null) { %>
            <p style="color: green;"><%= request.getAttribute("message") %></p>
        <% } %>
        <% if (request.getAttribute("errorMessage")!= null) { %>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>

        <h3>Login</h3>
        <form action="${pageContext.request.contextPath}/app/login" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br><br>
            <input type="submit" value="Login">
        </form>

        <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>.</p>
    </div>
</body>
</html>