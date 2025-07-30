<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User</title>
<style>
.error-message {
	color: red;
	font-weight: bold;
}

form {
	margin-top: 20px;
}

label {
	display: block;
	margin-bottom: 5px;
}

input[type="text"], input[type="password"], input[type="email"], select
	{
	width: 300px;
	padding: 8px;
	margin-bottom: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

input[type="submit"] {
	padding: 10px 15px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #45a049;
}
</style>
</head>
<body>
	<h1>Edit User: ${user.username}</h1>

	<c:if test="${not empty errorMessage}">
		<p class="error-message">${errorMessage}</p>
	</c:if>

	<form action="updateUser" method="post">
		<input type="hidden" name="id" value="${user.id}" /> <label
			for="username">Username:</label> <input type="text" id="username"
			name="username" value="${user.username}" required /><br /> <label
			for="password">Password:</label> <input type="password" id="password"
			name="password" value="${user.password}" required /><br />
		<%-- NOTE: For production, you'd never pre-fill a password field.
                   Users would either leave it blank to keep current, or enter a new one.
                   This is simplified for demonstration. --%>

		<label for="role">Role:</label> <select id="role" name="role" required>
			<option value="customer"
				<c:if test="${user.role eq 'customer'}">selected</c:if>>Customer</option>
			<option value="employee"
				<c:if test="${user.role eq 'employee'}">selected</c:if>>Employee</option>
			<option value="admin"
				<c:if test="${user.role eq 'admin'}">selected</c:if>>Admin</option>
			<%-- Add other ENUM values if they exist --%>
		</select><br /> <label for="email">Email:</label> <input type="email"
			id="email" name="email" value="${user.email}" required /><br /> <input
			type="submit" value="Update User" />
	</form>
	<p>
		<a href="viewUsers">Back to User List</a>
	</p>
</body>
</html>