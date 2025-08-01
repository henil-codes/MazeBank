<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.HolderType" %>
<%@ page import="com.mazebank.model.UserRole" %>
<%@ page import="com.mazebank.model.UserStatus" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MazeBank - Register</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h2>Register New User</h2>

        <%-- Display messages --%>
        <% if (request.getAttribute("message")!= null) { %>
            <p style="color: green;"><%= request.getAttribute("message") %></p>
        <% } %>
        <% if (request.getAttribute("errorMessage")!= null) { %>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br><br>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br><br>
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" required><br><br>
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" required><br><br>
            
            <label for="holderType">Holder Type:</label>
            <select id="holderType" name="holderType" required>
                <% for (HolderType holderType : HolderType.values()) { %>
                    <option value="<%= holderType.name() %>" <%= (holderType == HolderType.PERSONAL)? "selected" : "" %>><%= holderType.name() %></option>
                <% } %>
            </select><br><br>

            <input type="submit" value="Register">
        </form>

        <p>Already have an account? <a href="${pageContext.request.contextPath}/index.jsp">Login here</a>.</p>
    </div>
</body>
</html>