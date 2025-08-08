<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.mazebank.dto.UserResponseDTO"%>
<%@ page import="com.mazebank.model.AccountType"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Create User</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css">
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
			<form
				action="${pageContext.request.contextPath}/app/admin/accounts/create"
				method="post">
				<div class="form-card form-section">
					<h3>Create New Account</h3>

					<div class="form-group">
						<%
						List<UserResponseDTO> allUsers = (List<UserResponseDTO>) request.getAttribute("allUsers");
						%>

						<label for="newuser">Account ID:</label> <br> <select
							name="newuser" id="newuser" required>
							<%
							if (allUsers != null && !allUsers.isEmpty()) {
							%>

							<%
							for (UserResponseDTO user : allUsers) {
							%>
							<option value="<%=user.getUsername()%>"><%=user.getUsername()%></option>
							<%
							}
							} else {
							%>
							<option value="" disabled>No User available</option>
							<%
							}
							%>

						</select> <br>
					</div>

					<div class="form-group">
						<label for="initialBalance">Initial Balance:</label> <input
							type="number" id="initialBalance" name="initialBalance"
							step="0.01" min="0" value="0.00" required>
					</div>
					<div class="form-group">
						<label for="overdraftLimit">Overdraft Limit:</label> <input
							type="number" id="overdraftLimit" name="overdraftLimit"
							step="0.01" min="0" value="0.00" required>
					</div>
					<div class="form-group">
						<label for="maxTransactionAmount">Max Transaction Amount:</label>
						<input type="number" id="maxTransactionAmount"
							name="maxTransactionAmount" step="0.01" min="0" value="10000.00"
							required>
					</div>
					<div class="form-group">
						<label for="role">Role</label> <select id="role" name="role"
							required>
							<option value="CUSTOMER">Customer</option>
							<option value="ADMIN">Admin</option>
						</select>
					</div>
					<button type="submit" class="btn">Create Account</button>
			</form>
		</div>
	</div>
</body>
</html>