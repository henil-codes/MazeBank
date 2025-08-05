<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="admin-body">
    <%@ include file="../fragments/_sidebar.jspf" %>

	<div class="admin-main-content">
		<h2>Admin Dashboard</h2>
		<p>Welcome to the administrator control panel. Use the links below
			to manage the system.</p>

		<hr class="divider">

		<div class="admin-card-grid">
			<div class="section">
				<h3>Manage Users</h3>
				<p>View, edit, or delete all user accounts in the system.</p>
				<a href="${pageContext.request.contextPath}/app/admin/users"
					class="btn">Go to User Management</a>
			</div>
			<div class="section">
				<h3>Manage Accounts</h3>
				<p>Review and modify all bank accounts held by users.</p>
				<a href="${pageContext.request.contextPath}/app/admin/accounts"
					class="btn">Go to Account Management</a>
			</div>
		</div>
	</div>
</body>
</html>