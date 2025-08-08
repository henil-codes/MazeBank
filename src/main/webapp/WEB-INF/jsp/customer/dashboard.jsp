<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.User"%>
<%@ page import="java.util.List"%>
<%@ page import="com.mazebank.model.Account"%>
<%@ page import="com.mazebank.model.AccountType"%>
<%@ page import="com.mazebank.util.NumberUtils"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="dashboard-body">
    <div class="dashboard-container">
        <%-- Include the sidebar fragment --%>
        <%@ include file="../fragments/_sidebar.jspf"%>

        <main class="main-content">
            <section class="welcome-section">
                <h1>Hello, <%=loggedInUser.getFirstName()%>!</h1>
                <p>Welcome to your Maze Bank Account</p>
                <p class="user-role">Role: <%=loggedInUser.getRole().name()%></p>
            </section>

            <%-- Display success messages --%>
            <%
            String message = request.getParameter("message");
            if (message != null) {
            %>
            <div class="alert alert-success">
                <%
                if ("AccountCreated".equals(message)) {
                %>
                Account created successfully!
                <%
                } else if ("DepositSuccess".equals(message)) {
                %>
                Deposit successful!
                <%
                } else if ("WithdrawalSuccess".equals(message)) {
                %>
                Withdrawal successful!
                <%
                } else if ("TransferSuccess".equals(message)) {
                %>
                Transfer successful!
                <%
                } else if ("AccountClosed".equals(message)) {
                %>
                Account closed successfully!
                <%
                }
                %>
            </div>
            <%
            }
            %>

            <section class="section accounts-section">
                <h2 class="section-heading">
                    <i class="fas fa-piggy-bank"></i> Your Accounts
                </h2>
                <%
                List<Account> accounts = (List<Account>) request.getAttribute("userAccounts");
                if (accounts != null && !accounts.isEmpty()) {
                %>
                <div class="table-container">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Account ID</th>
                                <th>Account Number</th>
                                <th>Type</th>
                                <th>Balance</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            for (Account account : accounts) {
                            %>
                            <tr>
                                <td><%=account.getAccountId()%></td>
                                <td><%=account.getAccountNumber()%></td>
                                <td><%=account.getAccountType().name()%></td>
                                <td><%=NumberUtils.formatCurrency(account.getBalance())%></td>
                                <td><%=account.getStatus().name()%></td>
                                <td class="account-actions">
                                    <a href="${pageContext.request.contextPath}/app/customer/accounts/view?id=<%= account.getAccountId() %>" class="btn btn-view">View Details</a>
                                    <%
                                    if (account.getStatus().name().equals("ACTIVE") && account.getBalance().compareTo(java.math.BigDecimal.ZERO) == 0) {
                                    %>
                                    <a href="${pageContext.request.contextPath}/app/accounts/close?accountId=<%= account.getAccountId() %>" class="btn btn-close-account">Close Account</a>
                                    <%
                                    }
                                    %>
                                </td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                </div>
                <%
                } else {
                %>
                <div class="alert alert-info">
                    <p>No accounts found. Create one below!</p>
                </div>
                <%
                }
                %>
            </section>

            <hr class="divider">

            <section class="section quick-actions-section">
                <h2 class="section-heading">
                    <i class="fas fa-bolt"></i> Quick Actions
                </h2>
                <div class="quick-actions-grid">
                    
                    <div class="form-card">
                        <h3>Wire Transfer</h3>
                        <p>Transfer funds to another account securely.</p>
                        <a href="${pageContext.request.contextPath}/app/customer/wire_transfer" class="btn btn-secondary">Perform Wire Transfer</a>
                    </div>
                </div>
            </section>
        </main>
    </div>
</body>
</html>