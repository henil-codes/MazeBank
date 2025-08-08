<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="dashboard-body">
	<%@ include file="../jsp/fragments/_sidebar.jspf"%>
	<div class="main-content">
		<h2>Edit User: ${user.username}</h2>

		<c:if test="${not empty errorMessage}">
			<div class="alert alert-error">
				<p>${errorMessage}</p>
			</div>
		</c:if>

		<div class="form-card">
			<form action="updateUser" method="post">
				<input type="hidden" name="id" value="${user.id}" />
				<div class="form-group">
					<label for="username">Username:</label> <input type="text"
						id="username" name="username" value="${user.username}" required />
				</div>
				<div class="form-group">
					<label for="password">Password:</label> <input type="password"
						id="password" name="password" value="${user.password}" required />
				</div>
				<div class="form-group">
					<label for="email">Email:</label> <input type="email" id="email"
						name="email" value="${user.email}" required />
				</div>
				<div class="form-group">
					<label for="role">Role:</label> <select id="role" name="role"
						required>
						<option value="CUSTOMER"
							<c:if test="${user.role eq 'CUSTOMER'}">selected</c:if>>Customer</option>
						<option value="ADMIN"
							<c:if test="${user.role eq 'ADMIN'}">selected</c:if>>Admin</option>
					</select>
				</div>
				<div class="form-group mt-4">
					<button type="submit" class="btn">Update User</button>
				</div>
			</form>
		</div>

		<p class="mt-4">
			<a href="viewUsers">Back to User List</a>
		</p>
	</div>
</body>
</html>