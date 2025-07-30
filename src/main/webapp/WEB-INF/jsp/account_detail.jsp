<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account" %>
<%@ page import="com.mazebank.util.NumberUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Account Details</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/account_details.css">
</head>
<body>
    <div class="container">
        <h2>Account Details</h2>
        <% Account account = (Account) request.getAttribute("account"); %>
        <% if (account != null) { %>
            <p><strong>Account ID:</strong> <%= account.getAccountId() %></p>
            <p><strong>Account Number:</strong> <%= account.getAccountNumber() %></p>
            <p><strong>Account Type:</strong> <%= account.getAccountType().name() %></p>
            <p><strong>Balance:</strong> <%= NumberUtils.formatCurrency(account.getBalance()) %></p>
            <p><strong>Overdraft Limit:</strong> <%= NumberUtils.formatCurrency(account.getOverdraftLimit()) %></p>
            <p><strong>Max Transaction Amount:</strong> <%= NumberUtils.formatCurrency(account.getMaxTransactionAmount()) %></p>
            <p><strong>Status:</strong> <%= account.getStatus().name() %></p>
            <p><strong>Created At:</strong> <%= account.getCreatedAt() %></p>
            <p><strong>Last Updated:</strong> <%= account.getUpdatedAt() %></p>
            <p><a href="${pageContext.request.contextPath}/app/dashboard">Back to Dashboard</a></p>
        <% } else { %>
            <p>Account not found.</p>
        <% } %>
    </div>
</body>
</html>