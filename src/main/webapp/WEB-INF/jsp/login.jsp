<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Maze Bank - Sign On</title>
<style type="text/css">
.auth-image-container {
        background-color: red; /* Ensures the red background is visible behind the transparent image */
    }
    .auth-image-container img {
        background: none; /* Removes any default background from the image container */
    }
</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
	<div class="auth-container">
		<div class="auth-card-container login-card-container">
			<div class="auth-card">
				<h2>Sign On to Maze Bank</h2>
				<%
				String errorMessage = (String) request.getAttribute("errorMessage");
				if (errorMessage != null) {
				%>
				<div class="alert alert-error"><%=errorMessage%></div>
				<%
				}
				%>
				<form action="${pageContext.request.contextPath}/app/login"
					method="post">
					<div class="form-group">
						<label for="username">Username</label> <input type="text"
							id="username" name="username" required>
					</div>
					<div class="form-group">
						<label for="password">Password</label> <input type="password"
							id="password" name="password" required>
					</div>
					<div class="form-group mt-4">
						<button type="submit" class="btn">Sign On</button>
					</div>
				</form>
				<p class="mt-4 text-center">
					Don't have an account? <a
						href="${pageContext.request.contextPath}/app/register">Register
						now</a>
				</p>
			</div>
		</div>
		<div class="auth-image-container login-image-container">
			<img src="${pageContext.request.contextPath}/img/bank.jpg"
				alt="Secure login illustration">
		</div>
	</div>
</body>
</html>