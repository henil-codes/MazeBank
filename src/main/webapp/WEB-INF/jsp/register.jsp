<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.HolderType"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MazeBank - Register</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/styles.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/logins.css">
</head>
<body>
	<div class="auth-container">
		<div class="auth-image-container register-image-container">
			<img src="${pageContext.request.contextPath}/img/register-image.png"
				alt="Registration illustration">
		</div>
		<div class="auth-card-container register-card-container">
			<div class="auth-card">
				<h2>Register for a new account</h2>

				<%
				if (request.getAttribute("message") != null) {
				%>
				<div class="alert alert-success"><%=request.getAttribute("message")%></div>
				<%
				}
				%>
				<%
				if (request.getAttribute("errorMessage") != null) {
				%>
				<div class="alert alert-error"><%=request.getAttribute("errorMessage")%></div>
				<%
				}
				%>

				<form action="${pageContext.request.contextPath}/app/register"
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
						<label for="holderType">Holder Type</label> <select
							id="holderType" name="holderType" required>
							<%
							for (HolderType holderType : HolderType.values()) {
							%>
							<option value="<%=holderType.name()%>"
								<%= (holderType == HolderType.PERSONAL) ? "selected" : ""%>><%=holderType.name()%></option>
							<%
							}
							%>
						</select>
					</div>
					<div class="form-group mt-4">
						<button type="submit" class="btn">Register</button>
					</div>
				</form>

				<p class="mt-4 text-center">
					Already have an account? <a
						href="${pageContext.request.contextPath}/app/login">Login
						here</a>.
				</p>
			</div>
		</div>
	</div>
</body>
</html>