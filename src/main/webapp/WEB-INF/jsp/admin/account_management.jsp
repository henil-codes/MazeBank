<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mazebank.util.NumberUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Account Management</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../fragments/_sidebar.jspf" %>

    <div class="main-content">
        <h2>Account Management</h2>

        <%-- Display messages --%>
        <% String message = request.getParameter("message");
           if (message!= null) { %>
            <p style="color: blue;"><%= message %></p>
        <% } %>

        <h3>All Accounts</h3>
        <% List<Account> allAccounts = (List<Account>) request.getAttribute("allAccounts"); %>
        <% if (allAccounts!= null &&!allAccounts.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>Account ID</th>
                        <th>User ID</th>
                        <th>Account Number</th>
                        <th>Type</th>
                        <th>Balance</th>
                        <th>Overdraft Limit</th>
                        <th>Max Transaction</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Account account : allAccounts) { %>
                        <tr>
                            <td><%= account.getAccountId() %></td>
                            <td><%= account.getUserId() %></td>
                            <td><%= account.getAccountNumber() %></td>
                            <td><%= account.getAccountType().name() %></td>
                            <td><%= NumberUtils.formatCurrency(account.getBalance()) %></td>
                            <td><%= NumberUtils.formatCurrency(account.getOverdraftLimit()) %></td>
                            <td><%= NumberUtils.formatCurrency(account.getMaxTransactionAmount()) %></td>
                            <td><%= account.getStatus().name() %></td>
                            <td>
                                <%-- Example actions: View, Edit, Close (requires more servlets/logic) --%>
                                <a href="#">View</a> | <a href="#">Edit</a> |
                                <% if (account.getStatus().name().equals("ACTIVE") && account.getBalance().compareTo(java.math.BigDecimal.ZERO) == 0) { %>
                                    <a href="${pageContext.request.contextPath}/app/accounts/close?accountId=<%= account.getAccountId() %>">Close</a>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <p>No accounts found in the system.</p>
        <% } %>
    </div>
</body>
</html>