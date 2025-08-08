<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account" %>
<%@ page import="com.mazebank.util.NumberUtils" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Accounts</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/account_list.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="dashboard-container">
        <%@ include file="../fragments/_sidebar.jspf" %>
        <div class="main-content">
            <h2>Your Accounts</h2>
            
            <% List<Account> accounts = (List<Account>) request.getAttribute("userAccounts"); %>
            
            <% if (accounts != null && !accounts.isEmpty()) { %>
                <div class="table-card">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Account Number</th>
                                <th>Account Type</th>
                                <th>Balance</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Account account : accounts) { %>
                                <tr>
                                    <td><%= account.getAccountNumber() %></td>
                                    <td><%= account.getAccountType().name() %></td>
                                    <td><%= NumberUtils.formatCurrency(account.getBalance()) %></td>
                                    <td><%= account.getStatus().name() %></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/app/customer/accounts/view?id=<%= account.getAccountId() %>" class="btn btn-view">View Details</a>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div class="alert alert-info">
                    <p>You have no accounts to display.</p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>