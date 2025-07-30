<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User List</title>
<style>
table {
	width: 80%;
	border-collapse: collapse;
	margin: 20px 0;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

.message {
	color: green;
	font-weight: bold;
}

.error-message {
	color: red;
	font-weight: bold;
}
</style>
</head>
<body>
	<h1>All Users</h1>

	<c:if test="${not empty param.message}">
		<p class="message">${param.message}</p>
	</c:if>
	<c:if test="${not empty errorMessage}">
		<p class="error-message">${errorMessage}</p>
	</c:if>

	<p>
		<a href="register.jsp">Register New User</a>
	</p>

	<c:if test="${not empty users}">
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>Username</th>
					<th>Role</th>
					<th>Email</th>
					<th>Created At</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${users}">
					<tr>
						<td>${user.id}</td>
						<td>${user.username}</td>
						<td>${user.role}</td>
						<td>${user.email}</td>
						<td>${user.createdAt}</td>
						<td><a href="updateUser?id=${user.id}">Edit</a> | <a
							href="deleteUser?id=${user.id}"
							onclick="return confirm('Are you sure you want to delete ${user.username}?');">Delete</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${empty users}">
		<p>No users found.</p>
	</c:if>
</body>
</html>