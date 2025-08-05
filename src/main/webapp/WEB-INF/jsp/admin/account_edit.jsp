<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Edit Account</title>
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
		<h2>Edit Account: ${account.accountNumber}</h2>
		<div class="form-card">
			<form
				action="${pageContext.request.contextPath}/app/admin/accounts/edit"
				method="post">
				<input type="hidden" name="accountId" value="${account.accountId}">
				<div class="form-group">
					<label for="accountNumber">Account Number</label> <input
						type="text" id="accountNumber" name="accountNumber"
						value="${account.accountNumber}" disabled>
				</div>
				<div class="form-group">
					<label for="user">Account Holder</label> <input type="text"
						id="user" name="user" value="${account.user.username}" disabled>
				</div>
				<div class="form-group">
					<label for="accountType">Account Type</label> <select
						id="accountType" name="accountType" required>
						<option value="CHECKING"
							${account.accountType.name() eq 'CHECKING' ? 'selected' : ''}>Checking</option>
						<option value="SAVINGS"
							${account.accountType.name() eq 'SAVINGS' ? 'selected' : ''}>Savings</option>
					</select>
				</div>
				<div class="form-group">
					<label for="balance">Balance</label> <input type="number"
						id="balance" name="balance" min="0" step="0.01"
						value="${account.balance}" required>
				</div>
				<div class="form-group">
					<label for="status">Status</label> <select id="status"
						name="status" required>
						<option value="ACTIVE"
							${account.status.name() eq 'ACTIVE' ? 'selected' : ''}>Active</option>
						<option value="INACTIVE"
							${account.status.name() eq 'INACTIVE' ? 'selected' : ''}>Inactive</option>
					</select>
				</div>
				<div class="form-group mt-4">
					<button type="submit" class="btn">Save Changes</button>
					<a href="${pageContext.request.contextPath}/app/admin/accounts"
						class="btn-secondary">Cancel</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>