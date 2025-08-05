<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Create User</title>
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
		<h2>Create New User</h2>
		<div class="form-card">
			<form action="${pageContext.request.contextPath}/app/admin/users/create"
				method="post">
				<div class="form-group">
					<label for="username">Username</label> <input type="text"
						id="username" name="username" required>
				</div>
				<div class="form-group">
					<label for="password">Password</label> <input type="password"
						id="password" name="password" required>
				</div>
				<div class="form-group">
					<label for="email">Email</label> <input type="email" id="email"
						name="email" required>
				</div>
				<div class="form-group">
					<label for="firstName">First Name</label> <input type="text"
						id="firstName" name="firstName" required>
				</div>
				<div class="form-group">
					<label for="lastName">Last Name</label> <input type="text"
						id="lastName" name="lastName" required>
				</div>
				<div class="form-group">
					<label for="role">Role</label> <select id="role" name="role"
						required>
						<option value="CUSTOMER">Customer</option>
						<option value="ADMIN">Admin</option>
					</select>
				</div>
				<div class="form-group mt-4">
					<button type="submit" class="btn">Create User</button>
					<a href="${pageContext.request.contextPath}/app/admin/users"
						class="btn-secondary">Cancel</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>