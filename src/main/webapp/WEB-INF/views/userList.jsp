<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User List</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
<style>
.action-link-delete {
	color: #dc3545;
	font-weight: bold;
}

.action-link-delete:hover {
	text-decoration: underline;
}
</style>
</head>
<body class="dashboard-body">
	<%@ include file="../jsp/fragments/_sidebar.jspf"%>
	<div class="main-content">
		<h2>All Users</h2>

		<c:if test="${not empty param.message}">
			<div class="alert alert-success">
				<p>${param.message}</p>
			</div>
		</c:if>
		<c:if test="${not empty errorMessage}">
			<div class="alert alert-error">
				<p>${errorMessage}</p>
			</div>
		</c:if>

		<p class="mb-2">
			<a href="${pageContext.request.contextPath}/app/register"
				class="btn btn-secondary">Register New User</a>
		</p>

		<c:if test="${not empty users}">
			<table class="data-table">
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
								href="deleteUser?id=${user.id}" class="action-link-delete"
								onclick="return confirm('Are you sure you want to delete ${user.username}?');">Delete</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${empty users}">
			<div class="alert alert-info">
				<p>No users found.</p>
			</div>
		</c:if>
	</div>
</body>
</html>