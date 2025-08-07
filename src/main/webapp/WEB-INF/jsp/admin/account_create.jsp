<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mazebank.model.AccountType"%>
<%@ page import="com.mazebank.dto.UserResponseDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Create Account</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="admin-body">
	<%@ include file="../fragments/_admin_sidebar.jspf"%>
	<%
	UserResponseDTO userDTO = (UserResponseDTO) request.getAttribute("userDTO");
	%>

	<div class="admin-main-content">
		<h2>Create New Account</h2>
		<div class="form-card">
			<form
				action="${pageContext.request.contextPath}/app/admin/accounts/create/one"
				method="post">

				<div class="form-group">
					<label for="userId">Account Holder (Username)</label> <input
						type="text" name="username" value="<%=userDTO.getUsername()%>"
						readonly="readonly">
				</div>
				<div class="form-group">
					<label for="accountType">Account Type:</label> <select
						id="accountType" name="accountType" required>
						<%
						for (AccountType type : AccountType.values()) {
						%>
						<option value="<%=type.name()%>"><%=type.name()%></option>
						<%
						}
						%>
					</select>
				</div>
				<div class="form-group">
					<label for="initialBalance">Initial Balance</label> <input
						type="number" id="initialBalance" name="initialBalance" min="0"
						step="0.01" value="0.00" required>
				</div>
				<div class="form-group">
					<label for="overdraftLimit">Overdraft Limit:</label> <input
						type="number" id="overdraftLimit" name="overdraftLimit"
						step="0.01" min="0" value="0.00" required>
				</div>
				<div class="form-group">
					<label for="maxTransactionAmount">Max Transaction Amount:</label> <input
						type="number" id="maxTransactionAmount"
						name="maxTransactionAmount" step="0.01" min="0" value="10000.00"
						required>
				</div>
				<div class="form-group mt-4">
					<button type="submit" class="btn">Create
						Account</button>
					<a href="${pageContext.request.contextPath}/app/admin/accounts"
						class="btn-secondary">Cancel</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>