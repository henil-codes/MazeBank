<%-- File: WEB-INF/jsp/account_pending.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.UserStatus" %>
<%@ page import="com.mazebank.model.User" %>
<%@ include file="../fragments/_sidebar.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Account Pending</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="main-content">
        <h2>Account Under Review</h2>
        <p>Hello, <%= ((User) session.getAttribute("loggedInUser")).getFirstName() %>!</p>
        <p>Your account is currently under review by our staff. You will receive an email notification once your account has been approved.</p>
        <p>Please check back later.</p>
    </div>
</body>
</html>