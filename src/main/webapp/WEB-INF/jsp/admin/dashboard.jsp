<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mazebank.model.Account" %>
<%@ page import="com.mazebank.model.AccountType" %>
<%@ page import="com.mazebank.util.NumberUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
    <div class="container">
        <h2>Welcome to Your Dashboard!</h2>
        <%
            User loggedInUser = (User) session.getAttribute("loggedInUser");
            if (loggedInUser != null) {
        %>
            <p>Hello, <%= loggedInUser.getFirstName() %> <%= loggedInUser.getLastName() %> (<%= loggedInUser.getUsername() %>)!</p>
            <p>
                Your Role: <%= loggedInUser.getRole() != null ? loggedInUser.getRole().name() : "N/A"%>,
                Status: <%= loggedInUser.getStatus() != null ? loggedInUser.getStatus().name() : "N/A"%>,
                Holder Type: <%= loggedInUser.getHolderType() != null ? loggedInUser.getHolderType().name() : "N/A"%>
            </p>
            <p><a href="${pageContext.request.contextPath}/app/logout">Logout</a></p>

            <%-- Display messages --%>
            <%
                String message = request.getParameter("message");
                if (message != null) {
            %>
                <p style="color: blue;">
                    <% if ("AccountCreated".equals(message)) { %>
                        Account created successfully!
                    <% } else if ("DepositSuccess".equals(message)) { %>
                        Deposit successful!
                    <% } else if ("WithdrawalSuccess".equals(message)) { %>
                        Withdrawal successful!
                    <% } else if ("TransferSuccess".equals(message)) { %>
                        Transfer successful!
                    <% } else if ("AccountClosed".equals(message)) { %>
                        Account closed successfully!
                    <% } %>
                </p>
            <%
                }
            %>

            <h3>Your Accounts</h3>
            <%
                List<Account> accounts = (List<Account>) request.getAttribute("userAccounts");
                if (accounts != null && !accounts.isEmpty()) {
            %>
                <table>
                    <thead>
                        <tr>
                            <th>Account ID</th>
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
                        <% for (Account account : accounts) { %>
                            <tr>
                                <td><%= account.getAccountId() %></td>
                                <td><%= account.getAccountNumber() %></td>
                                <td><%= account.getAccountType().name() %></td>
                                <td><%= NumberUtils.formatCurrency(account.getBalance()) %></td>
                                <td><%= NumberUtils.formatCurrency(account.getOverdraftLimit()) %></td>
                                <td><%= NumberUtils.formatCurrency(account.getMaxTransactionAmount()) %></td>
                                <td><%= account.getStatus().name() %></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/app/accounts/view?id=<%= account.getAccountId() %>">View</a>
                                    <% if (account.getStatus().name().equals("ACTIVE") && account.getBalance().compareTo(java.math.BigDecimal.ZERO) == 0) { %>
                                        | <a href="${pageContext.request.contextPath}/app/accounts/close?accountId=<%= account.getAccountId() %>">Close</a>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <p>No accounts found. Create one below!</p>
            <% } %>

            <h3>Create New Account</h3>
            <form action="${pageContext.request.contextPath}/app/accounts/create" method="post">
                <label for="accountType">Account Type:</label>
                <select id="accountType" name="accountType" required>
                    <% for (AccountType type : AccountType.values()) { %>
                        <option value="<%= type.name() %>"><%= type.name() %></option>
                    <% } %>
                </select><br><br>
                <label for="initialBalance">Initial Balance:</label>
                <input type="number" id="initialBalance" name="initialBalance" step="0.01" min="0" value="0.00" required><br><br>
                <label for="overdraftLimit">Overdraft Limit:</label>
                <input type="number" id="overdraftLimit" name="overdraftLimit" step="0.01" min="0" value="0.00" required><br><br>
                <label for="maxTransactionAmount">Max Transaction Amount:</label>
                <input type="number" id="maxTransactionAmount" name="maxTransactionAmount" step="0.01" min="0" value="10000.00" required><br><br>
                <input type="submit" value="Create Account">
            </form>

            <h3>Perform Transaction</h3>
            <form action="${pageContext.request.contextPath}/app/transactions/deposit" method="post">
                <h4>Deposit</h4>
                <label for="depositAccountId">Account ID:</label>
                <input type="number" id="depositAccountId" name="accountId" required><br><br>
                <label for="depositAmount">Amount:</label>
                <input type="number" id="depositAmount" name="amount" step="0.01" min="0.01" required><br><br>
                <label for="depositDesc">Description:</label>
                <input type="text" id="depositDesc" name="description"><br><br>
                <input type="submit" value="Deposit">
            </form>
            <hr>
            <form action="${pageContext.request.contextPath}/app/transactions/withdrawal" method="post">
                <h4>Withdrawal</h4>
                <label for="withdrawAccountId">Account ID:</label>
                <input type="number" id="withdrawAccountId" name="accountId" required><br><br>
                <label for="withdrawAmount">Amount:</label>
                <input type="number" id="withdrawAmount" name="amount" step="0.01" min="0.01" required><br><br>
                <label for="withdrawDesc">Description:</label>
                <input type="text" id="withdrawDesc" name="description"><br><br>
                <input type="submit" value="Withdraw">
            </form>
            <hr>
            <form action="${pageContext.request.contextPath}/app/transactions/transfer" method="post">
                <h4>Transfer</h4>
                <label for="sourceAccountId">Source Account ID:</label>
                <input type="number" id="sourceAccountId" name="sourceAccountId" required><br><br>
                <label for="targetAccountId">Target Account ID:</label>
                <input type="number" id="targetAccountId" name="targetAccountId" required><br><br>
                <label for="transferAmount">Amount:</label>
                <input type="number" id="transferAmount" name="amount" step="0.01" min="0.01" required><br><br>
                <label for="transferDesc">Description:</label>
                <input type="text" id="transferDesc" name="description"><br><br>
                <input type="submit" value="Transfer">
            </form>

        <% } else { %>
            <p>You are not logged in. Please <a href="${pageContext.request.contextPath}/index.jsp">login</a>.</p>
        <% } %>
    </div>
</body>
</html>