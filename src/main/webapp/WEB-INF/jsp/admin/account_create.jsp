<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

	<div class="admin-main-content">
		<h2>Create New Account</h2>
		<div class="form-card">
			<form
				action="${pageContext.request.contextPath}/app/admin/accounts/create"
				method="post">
				<div class="form-group">
					<label for="userId">Account Holder (User ID)</label>
					<c:choose>
						<c:when test="${not empty users}">
							<select id="userId" name="userId" required>
								<option value="">-- Select a User --</option>
								<c:forEach var="user" items="${users}">
									<option value="${user.userId}">${user.username} (ID:
										${user.userId})</option>
								</c:forEach>
							</select>
						</c:when>
						<c:otherwise>
							<p class="alert alert-info">No users available to create an account for. Please create a user first.</p>
							<input type="hidden" name="userId" value="">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="form-group">
					<label for="accountType">Account Type</label> <select
						id="accountType" name="accountType" required>
						<option value="CHECKING">Checking</option>
						<option value="SAVINGS">Savings</option>
					</select>
				</div>
				<div class="form-group">
					<label for="initialBalance">Initial Balance</label> <input
						type="number" id="initialBalance" name="initialBalance" min="0"
						step="0.01" value="0.00" required>
				</div>
				<div class="form-group mt-4">
					<button type="submit" class="btn" ${empty users ? 'disabled' : ''}>Create
						Account</button>
					<a href="${pageContext.request.contextPath}/app/admin/accounts"
						class="btn-secondary">Cancel</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>