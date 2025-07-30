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

            <%-- Role and Status are typically set by the system for new registrations,
                 but if you want to allow selection, uncomment and adjust.
                 For a customer registration, these would usually be fixed (e.g., CUSTOMER, PENDING). --%>
            <%--
            <label for="role">Role:</label>
            <select id="role" name="role">
                <% for (UserRole role : UserRole.values()) { %>
                    <option value="<%= role.name() %>" <%= (role == UserRole.CUSTOMER)? "selected" : "" %>><%= role.name() %></option>
                <% } %>
            </select><br><br>

            <label for="status">Status:</label>
            <select id="status" name="status">
                <% for (UserStatus status : UserStatus.values()) { %>
                    <option value="<%= status.name() %>" <%= (status == UserStatus.PENDING)? "selected" : "" %>><%= status.name() %></option>
                <% } %>
            </select><br><br>
            --%>

            <input type="submit" value="Register">
        </form>

        <p>Already have an account? <a href="${pageContext.request.contextPath}/index.jsp">Login here</a>.</p>
    </div>
</body>
</html>