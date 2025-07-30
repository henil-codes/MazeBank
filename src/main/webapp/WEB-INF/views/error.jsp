<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
<style>
.error-message {
	color: red;
	font-weight: bold;
}
</style>
</head>
<body>
	<h1>An Error Occurred</h1>
	<p class="error-message">
		<c:out value="${errorMessage}" />
		<br /> Please try again or contact support.
	</p>
	<p>
		<a href="javascript:history.back()">Go Back</a> | <a href="index.jsp">Home</a>
	</p>
</body>
</html>