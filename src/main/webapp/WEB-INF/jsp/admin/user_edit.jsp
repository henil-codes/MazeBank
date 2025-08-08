<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.dto.UserResponseDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Edit User</title>
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
		<div class="header">
			<div class="breadcrumb">
				<a href="${pageContext.request.contextPath}/app/admin/users">User
					Management</a> <span> / Edit User</span>
			</div>
		</div>

		<div class="container">
			<%
			UserResponseDTO user = (UserResponseDTO) request.getAttribute("user");
			if (user != null) {
			%>

			<div class="section">
				<h2>
					<i class="fas fa-user-edit"></i> Edit User Details
				</h2>

				<%-- Display error messages --%>
				<%
				String errorMessage = (String) request.getAttribute("errorMessage");
				if (errorMessage != null) {
				%>
				<div class="alert alert-error">
					<p><%=errorMessage%></p>
				</div>
				<%
				}
				%>

				<div class="form-card">
					<form
						action="${pageContext.request.contextPath}/app/admin/users/edit"
						method="post">
						<input type="hidden" name="userId" value="<%=user.getUserId()%>">

						<div class="details-grid">
							<!-- Basic Information -->
							<div class="detail-card">
								<h3>
									<i class="card-icon"><i class="fas fa-user"></i></i> Basic
									Information
								</h3>

								<div class="form-group">
									<label for="username">Username *</label> <input type="text"
										id="username" name="username" value="<%=user.getUsername()%>"
										required>
								</div>

								<div class="form-group">
									<label for="email">Email *</label> <input type="email"
										id="email" name="email" value="<%=user.getEmail()%>" required>
								</div>

								<div class="form-group">
									<label for="firstName">First Name *</label> <input type="text"
										id="firstName" name="firstName"
										value="<%=user.getFirstName()%>" required>
								</div>

								<div class="form-group">
									<label for="lastName">Last Name *</label> <input type="text"
										id="lastName" name="lastName" value="<%=user.getLastName()%>"
										required>
								</div>
							</div>

							<!-- Password Change (Optional) -->
							<div class="detail-card">
								<h3>
									<i class="card-icon"><i class="fas fa-lock"></i></i> Change
									Password
								</h3>
								<p
									style="color: #666; margin-bottom: 1.5rem; font-size: 0.9rem;">
									Leave blank if you don't want to change the password</p>

								<div class="form-group">
									<label for="currentPassword">Current Password</label> <input
										type="password" id="currentPassword" name="currentPassword"
										placeholder="Enter current password"> <small
										style="color: #666;">Required only if changing
										password</small>
								</div>

								<div class="form-group">
									<label for="newPassword">New Password</label> <input
										type="password" id="newPassword" name="newPassword"
										placeholder="Enter new password"> <small
										style="color: #666;">Minimum 6 characters</small>
								</div>

								<div class="form-group">
									<label for="confirmPassword">Confirm New Password</label> <input
										type="password" id="confirmPassword" name="confirmPassword"
										placeholder="Confirm new password">
								</div>
							</div>

							<!-- Read-only Information -->
							<div class="detail-card">
								<h3>
									<i class="card-icon"><i class="fas fa-info-circle"></i></i>
									Account Information
								</h3>
								<p
									style="color: #666; margin-bottom: 1.5rem; font-size: 0.9rem;">
									These fields cannot be modified</p>

								<div class="detail-item">
									<span class="detail-label">User ID:</span> <span
										class="detail-value"><%=user.getUserId()%></span>
								</div>

								<div class="detail-item">
									<span class="detail-label">Role:</span> <span
										class="detail-value"><%=user.getRole().name()%></span>
								</div>

								<div class="detail-item">
									<span class="detail-label">Status:</span> <span
										class="detail-value"><%=user.getStatus().name()%></span>
								</div>

								<div class="detail-item">
									<span class="detail-label">Holder Type:</span> <span
										class="detail-value"><%=user.getHolderType().name()%></span>
								</div>

								<div class="detail-item">
									<span class="detail-label">Created At:</span> <span
										class="detail-value"><%=user.getCreatedAt()%></span>
								</div>
							</div>
						</div>

						<div class="actions-section">
							<div class="action-buttons">
								<button type="submit" class="btn btn-primary">
									<i class="fas fa-save"></i> Update User
								</button>
								<a href="${pageContext.request.contextPath}/app/admin/users"
									class="btn btn-secondary"> <i class="fas fa-arrow-left"></i>
									Back to User List
								</a>
							</div>
						</div>
					</form>
				</div>
			</div>

			<%
			} else {
			%>
			<div class="not-found">
				<div class="not-found-icon">
					<i class="fas fa-user-times"></i>
				</div>
				<h2>User Not Found</h2>
				<p>The requested user could not be found.</p>
				<a href="${pageContext.request.contextPath}/app/admin/users"
					class="btn btn-primary"> Back to User List </a>
			</div>
			<%
			}
			%>
		</div>
	</div>

	<script>
		// Password confirmation validation
		document
				.getElementById('confirmPassword')
				.addEventListener(
						'input',
						function() {
							const newPassword = document
									.getElementById('newPassword').value;
							const confirmPassword = this.value;

							if (newPassword !== confirmPassword
									&& confirmPassword !== '') {
								this
										.setCustomValidity('Passwords do not match');
								this.style.borderColor = '#D32F2F';
							} else {
								this.setCustomValidity('');
								this.style.borderColor = '';
							}
						});

		// Require current password if new password is entered
		document
				.getElementById('newPassword')
				.addEventListener(
						'input',
						function() {
							const currentPassword = document
									.getElementById('currentPassword');
							const confirmPassword = document
									.getElementById('confirmPassword');

							if (this.value.trim() !== '') {
								currentPassword.required = true;
								confirmPassword.required = true;
								currentPassword.parentElement
										.querySelector('label').innerHTML = 'Current Password *';
								confirmPassword.parentElement
										.querySelector('label').innerHTML = 'Confirm New Password *';
							} else {
								currentPassword.required = false;
								confirmPassword.required = false;
								currentPassword.parentElement
										.querySelector('label').innerHTML = 'Current Password';
								confirmPassword.parentElement
										.querySelector('label').innerHTML = 'Confirm New Password';
							}
						});
	</script>

</body>
</html>