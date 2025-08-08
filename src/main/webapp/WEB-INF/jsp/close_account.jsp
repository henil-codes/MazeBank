<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account" %>
<%@ page import="com.mazebank.util.NumberUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Close Account</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .close-account-container {
            max-width: 600px;
            margin: 4rem auto;
            padding: 2rem;
            background-color: var(--cibc-white);
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            text-align: center;
        }
        .warning-message {
            color: #dc3545;
            font-weight: bold;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 1rem;
            border-radius: 4px;
            margin-bottom: 1.5rem;
        }
        .btn-confirm-close {
            background-color: #dc3545;
        }
        .btn-confirm-close:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="close-account-container">
        <h2>Close Account</h2>
        <% Account account = (Account) request.getAttribute("account"); %>
        <% if (account != null) { %>
            <p>You are about to close account: <strong><%= account.getAccountNumber() %></strong>.</p>
            <p>Current Balance: <strong><%= NumberUtils.formatCurrency(account.getBalance()) %></strong></p>

            <% if (account.getBalance().compareTo(java.math.BigDecimal.ZERO) == 0) { %>
                <form action="${pageContext.request.contextPath}/app/accounts/close" method="post">
                    <input type="hidden" name="_method" value="PUT">
                    <input type="hidden" name="accountId" value="<%= account.getAccountId() %>">
                    <p>Are you sure you want to close this account?</p>
                    <button type="submit" class="btn btn-confirm-close">Confirm Close Account</button>
                </form>
            <% } else { %>
                <div class="warning-message">
                    <p>Cannot close account. Please ensure the balance is zero.</p>
                </div>
            <% } %>
            <p class="mt-4"><a href="${pageContext.request.contextPath}/app/dashboard">Cancel and Go Back to Dashboard</a></p>
        <% } else { %>
            <div class="alert alert-error">
                <p>Account not found for closing.</p>
            </div>
            <p><a href="${pageContext.request.contextPath}/app/dashboard">Back to Dashboard</a></p>
        <% } %>
    </div>
</body>
</html>