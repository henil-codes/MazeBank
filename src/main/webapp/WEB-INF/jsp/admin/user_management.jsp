<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.dto.UserResponseDTO"%>
<%@ page import="com.mazebank.model.UserStatus"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - User Management</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/tables.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

</head>
<body class="admin-body">
	<%@ include file="../fragments/_admin_sidebar.jspf"%>

	<div class="admin-main-content">
		<h2>User Management</h2>

		<%-- Display messages --%>
		<%
		String message = request.getParameter("message");
		if (message != null) {
		%>
		<p style="color: blue;"><%=message%></p>
		<%
		}
		%>

		<h3>All Users</h3>
		<%
		List<UserResponseDTO> allUsers = (List<UserResponseDTO>) request.getAttribute("allUsers");
		%>
		<%
		if (allUsers != null && !allUsers.isEmpty()) {
		%>
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
				<%
				for (UserResponseDTO user : allUsers) {
				%>
				<tr>
					<td><%=user.getUserId()%></td>
					<td><%=user.getUsername()%></td>
					<td><%=user.getEmail()%></td>
					<td><%=user.getFirstName()%></td>
					<td><%=user.getLastName()%></td>
					<td><%=user.getRole().name()%></td>
					<td><%=user.getStatus().name()%></td>
					<td><%=user.getHolderType().name()%></td>
					<td><%=user.getCreatedAt()%></td>
					<td>
						<%-- Example actions: View, Edit, Delete (requires more servlets/logic) --%>
						<a href="${pageContext.request.contextPath}/app/admin/users/edit?userId=<%=user.getUserId()%>">Edit</a>
						| <aF
						href="<%=request.getContextPath()%>/app/admin/accounts/create?userId=<%=user.getUserId()%>">Create
							Account</a> | <a href="#"
						onclick="confirmDelete(<%=user.getUserId()%>, '<%=user.getUsername()%>')">Delete</a>
						<%
						if (user.getStatus() == UserStatus.PENDING) {
						%>
						<form
							action="${pageContext.request.contextPath}/app/admin/users/approve"
							method="post" style="display: inline;">
							<input type="hidden" name="userId" value="<%=user.getUserId()%>">
							<button type="submit" class="btn">Approve</button>
						</form> <%
 }
 %>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		} else {
		%>
		<p>No users found in the system.</p>
		<%
		}
		%>
	</div>

	<script>
function confirmDelete(userId, username) {
    if (confirm('Are you sure you want to delete user "' + username + '"? This action cannot be undone.')) {
        // Create a form and submit it
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/app/admin/users/delete';
        
        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'userId';
        input.value = userId;
        
        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
}
</script>
</body>
</html>