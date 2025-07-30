<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account" %>
<%@ page import="com.mazebank.util.NumberUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Close Account</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/close_account.css">
</head>
<body>
    <div class="container">
        <h2>Close Account</h2>
        <% Account account = (Account) request.getAttribute("account"); %>
        <% if (account != null) { %>
            <p>You are about to close account: <strong><%= account.getAccountNumber() %> (ID: <%= account.getAccountId() %>)</strong>.</p>
            <p>Current Balance: <strong><%= NumberUtils.formatCurrency(account.getBalance()) %></strong></p>
            <p style="color: red;"><strong>Warning:</strong> The account balance must be zero to proceed with closing.</p>

            <% if (account.getBalance().compareTo(java.math.BigDecimal.ZERO) == 0) { %>
                <form action="${pageContext.request.contextPath}/app/accounts/close" method="post">
                    <input type="hidden" name="_method" value="PUT"> <%-- Simulating PUT with POST --%>
                    <input type="hidden" name="accountId" value="<%= account.getAccountId() %>">
                    <p>Are you sure you want to close this account?</p>
                    <input type="submit" value="Confirm Close Account">
                </form>
            <% } else { %>
                <p style="color: red;">Cannot close account. Please ensure the balance is zero.</p>
            <% } %>
            <p><a href="${pageContext.request.contextPath}/app/dashboard">Cancel and Go Back to Dashboard</a></p>
        <% } else { %>
            <p>Account not found for closing.</p>
            <p><a href="${pageContext.request.contextPath}/app/dashboard">Back to Dashboard</a></p>
        <% } %>
    </div>
</body>
</html>