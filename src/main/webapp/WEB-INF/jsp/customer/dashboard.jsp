<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.User"%>
<%@ page import="java.util.List"%>
<%@ page import="com.mazebank.model.Account"%>
<%@ page import="com.mazebank.model.AccountType"%>
<%@ page import="com.mazebank.util.NumberUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Dashboard</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<%-- Include the sidebar fragment --%>
	<%@ include file="../fragments/_sidebar.jspf"%>

	<div class="main-content">
		<h2>Your Dashboard</h2>
		<p>
			Hello,
			<%=loggedInUser.getFirstName()%>
			<%=loggedInUser.getLastName()%>!
		</p>
		<p>
			Your Role:
			<%=loggedInUser.getRole().name()%>, Status:
			<%=loggedInUser.getStatus().name()%>, Holder Type:
			<%=loggedInUser.getHolderType().name()%></p>

		<%-- Display messages --%>
		<%
		String message = request.getParameter("message");
		if (message != null) {
		%>
		<p style="color: blue;">
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
		</p>
		<%
		}
		%>
		
		<%-- Add the new link for wire transfer --%>
        <h3>Quick Actions</h3>
        <a href="${pageContext.request.contextPath}/app/customer/wire_transfer" class="button">Perform Wire Transfer</a>
        

		<h3>Your Accounts</h3>
		<%
		List<Account> accounts = (List<Account>) request.getAttribute("userAccounts");
		%>
		<%
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
				<%
				for (Account account : accounts) {
				%>
				<tr>
					<td><%=account.getAccountId()%></td>
					<td><%=account.getAccountNumber()%></td>
					<td><%=account.getAccountType().name()%></td>
					<td><%=NumberUtils.formatCurrency(account.getBalance())%></td>
					<td><%=NumberUtils.formatCurrency(account.getOverdraftLimit())%></td>
					<td><%=NumberUtils.formatCurrency(account.getMaxTransactionAmount())%></td>
					<td><%=account.getStatus().name()%></td>
					<td><a
						href="${pageContext.request.contextPath}/app/customer/accounts/view?id=<%= account.getAccountId() %>">View
							Details</a> <%
 if (account.getStatus().name().equals("ACTIVE") && account.getBalance().compareTo(java.math.BigDecimal.ZERO) == 0) {
 %> | <a
						href="${pageContext.request.contextPath}/app/accounts/close?accountId=<%= account.getAccountId() %>">Close
							Account</a> <%
 }
 %></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		} else {
		%>
		<p>No accounts found. Create one below!</p>
		<%
		}
		%>

		<h3>Create New Account</h3>
		<form action="${pageContext.request.contextPath}/app/accounts/create"
			method="post">
			<label for="accountType">Account Type:</label> <select
				id="accountType" name="accountType" required>
				<%
				for (AccountType type : AccountType.values()) {
				%>
				<option value="<%=type.name()%>"><%=type.name()%></option>
				<%
				}
				%>
			</select><br> <br> <label for="initialBalance">Initial
				Balance:</label> <input type="number" id="initialBalance"
				name="initialBalance" step="0.01" min="0" value="0.00" required><br>
			<br> <label for="overdraftLimit">Overdraft Limit:</label> <input
				type="number" id="overdraftLimit" name="overdraftLimit" step="0.01"
				min="0" value="0.00" required><br> <br> <label
				for="maxTransactionAmount">Max Transaction Amount:</label> <input
				type="number" id="maxTransactionAmount" name="maxTransactionAmount"
				step="0.01" min="0" value="10000.00" required><br> <br>
			<input type="submit" value="Create Account">
		</form>
	</div>
</body>
</html>