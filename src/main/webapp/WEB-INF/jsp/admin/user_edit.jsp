<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Edit User</title>
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
		<h2>Edit User: ${user.username}</h2>
		<div class="form-card">
			<form action="${pageContext.request.contextPath}/app/admin/users/edit"
				method="post">
				<input type="hidden" name="userId" value="${user.userId}">
				<div class="form-group">
					<label for="username">Username</label> <input type="text"
						id="username" name="username" value="${user.username}">
				</div>
				<div class="form-group">
					<label for="email">Email</label> <input type="email" id="email"
						name="email" value="${user.email}">
				</div>
				<div class="form-group">
					<label for="firstName">First Name</label> <input type="text"
						id="firstName" name="firstName" value="${user.firstName}">
				</div>
				<div class="form-group">
					<label for="lastName">Last Name</label> <input type="text"
						id="lastName" name="lastName" value="${user.lastName}">
				</div>
				<div class="form-group">
					<label for="role">Role</label> <select id="role" name="role"
					>
						<option value="CUSTOMER"
							${user.userRole.name() eq 'CUSTOMER' ? 'selected' : ''}>Customer</option>
						<option value="ADMIN"
							${user.userRole.name() eq 'ADMIN' ? 'selected' : ''}>Admin</option>
					</select>
				</div>
				<div class="form-group mt-4">
					<button type="submit" class="btn">Save Changes</button>
					<a href="${pageContext.request.contextPath}/app/admin/users"
						class="btn-secondary">Cancel</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>