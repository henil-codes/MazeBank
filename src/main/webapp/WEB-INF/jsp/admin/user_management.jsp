<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.dto.UserResponseDTO" %>
<%@ page import="com.mazebank.model.UserStatus" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - User Management</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../fragments/_sidebar.jspf" %>

    <div class="main-content">
        <h2>User Management</h2>

        <%-- Display messages --%>
        <% String message = request.getParameter("message");
           if (message!= null) { %>
            <p style="color: blue;"><%= message %></p>
        <% } %>

        <h3>All Users</h3>
        <% List<UserResponseDTO> allUsers = (List<UserResponseDTO>) request.getAttribute("allUsers"); %>
        <% if (allUsers!= null &&!allUsers.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Holder Type</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (UserResponseDTO user : allUsers) { %>
                        <tr>
                            <td><%= user.getUserId() %></td>
                            <td><%= user.getUsername() %></td>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getFirstName() %></td>
                            <td><%= user.getLastName() %></td>
                            <td><%= user.getRole().name() %></td>
                            <td><%= user.getStatus().name() %></td>
                            <td><%= user.getHolderType().name() %></td>
                            <td><%= user.getCreatedAt() %></td>
                            <td>
                                <%-- Example actions: View, Edit, Delete (requires more servlets/logic) --%>
                                <a href="#">View</a> | <a href="#">Edit</a> | <a href="#">Delete</a>
                                <% if (user.getStatus() == UserStatus.PENDING) { %>
                                    |
                                    <form action="${pageContext.request.contextPath}/app/admin/users/approve" method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                                        <button type="submit" class="approve-btn">Approve</button>
                                    </form>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <p>No users found in the system.</p>
        <% } %>
    </div>
</body>
</html>