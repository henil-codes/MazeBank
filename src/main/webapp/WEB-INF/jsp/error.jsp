<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
<style>
.error-container {
	max-width: 600px;
	margin: 4rem auto;
	padding: 2rem;
	background-color: var(--cibc-white);
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
	text-align: center;
}
</style>
</head>
<body>
	<div class="error-container">
		<h2>An Error Occurred</h2>
		<div class="alert alert-error">
			<p>
				<%
				String errorMessage = (String) request.getAttribute("errorMessage");
				if (errorMessage != null) {
				%>
				<%=errorMessage%><br />
				<%
				} else {
				%>
				An unexpected error occurred.<br />
				<%
				}
				%>
				Please try again or contact support.
			</p>
		</div>
		<p class="mt-4">
			<a href="javascript:history.back()">Go Back</a> | <a
				href="${pageContext.request.contextPath}/app/login">Home</a>
		</p>
	</div>
</body>
</html>