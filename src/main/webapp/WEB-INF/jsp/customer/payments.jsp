<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account"%>
<%@ page import="java.util.List"%>
<%@ page import="com.mazebank.util.NumberUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payments</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/payment.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
	<%@ include file="../fragments/_sidebar.jspf"%>

	<%
	List<Account> accounts = (List<Account>) request.getAttribute("userAccounts");
	%>

	<div class="main-content">
		<h2>Payments & Transfers</h2>

		<%-- Display messages --%>
		<%
		String message = request.getParameter("message");
		if (message != null) {
		%>
		<p class="alert alert-success"><%=message%></p>
		<%
		}
		%>

		<h3>Your Accounts for Transactions</h3>

		<%
		if (accounts != null && !accounts.isEmpty()) {
		%>
		<p>Select an account for transactions:</p>
		<ul class="account-card">
			<%
			for (Account account : accounts) {
			%>
			<li><%=account.getAccountNumber()%> (<%=account.getAccountType().name()%>)
				- Balance: <%=NumberUtils.formatCurrency(account.getBalance())%></li>
			<%
			}
			%>
		</ul>
		<%
		} else {
		%>
		<p class="alert alert-info">No active accounts available for transactions.</p>
		<%
		}
		%>

		<hr class="divider">

		<h3>Perform Transaction</h3>
		<div class="transaction-grid">
			<form class="form-card"
				action="${pageContext.request.contextPath}/app/transactions/deposit"
				method="post">
				<h4>Deposit</h4>
				<label for="depositAccountNumber">Account ID:</label> <br> <select
					name="accountNumber" id="depositAccountNumber" required>
					<%
					if (accounts != null && !accounts.isEmpty()) {
					%>
					<%
					for (Account account : accounts) {
					%>
					<option value="<%=account.getAccountNumber()%>"><%=account.getAccountNumber()%>
						-
						<%=account.getAccountType().name()%> (Balance: $<%=account.getBalance()%>)
					</option>
					<%
					}
					%>
					<%
					} else {
					%>
					<option value="" disabled>No accounts available</option>
					<%
					}
					%>
				</select> <br> <label for="depositAmount">Amount:</label> <input
					type="number" id="depositAmount" name="amount" step="0.01"
					min="0.01" required><br> <br> <label
					for="depositDesc">Description:</label> <input type="text"
					id="depositDesc" name="description"><br> <br> <input
					type="submit" value="Deposit" class="btn btn-primary">
			</form>
			<form class="form-card"
				action="${pageContext.request.contextPath}/app/transactions/withdrawal"
				method="post">
				<h4>Withdrawal</h4>
				<label for="withdrawAccountNumber">Account ID:</label> <br>
				<select
					name="accountNumber" id="withdrawAccountNumber" required>
					<%
					if (accounts != null && !accounts.isEmpty()) {
					%>
					<%
					for (Account account : accounts) {
					%>
					<option value="<%=account.getAccountNumber()%>"><%=account.getAccountNumber()%>
						-
						<%=account.getAccountType().name()%> (Balance: $<%=account.getBalance()%>)
					</option>
					<%
					}
					%>
					<%
					} else {
					%>
					<option value="" disabled>No accounts available</option>
					<%
					}
					%>
				</select> <br> <label for="withdrawAmount">Amount:</label> <input
					type="number" id="withdrawAmount" name="amount" step="0.01"
					min="0.01" required><br> <br> <label
					for="withdrawDesc">Description:</label> <input type="text"
					id="withdrawDesc" name="description"><br> <br> <input
					type="submit" value="Withdraw" class="btn btn-primary">
			</form>
			<form class="form-card"
				action="${pageContext.request.contextPath}/app/transactions/transfer"
				method="post">
				<h4>Transfer</h4>
				<label for="sourceAccountNumber">Source Account ID:</label> <br> <select
					name="sourceAccountNumber" id="sourceAccountNumber" required>
					<%
					if (accounts != null && !accounts.isEmpty()) {
					%>
					<%
					for (Account account : accounts) {
					%>
					<option value="<%=account.getAccountNumber()%>"><%=account.getAccountNumber()%>
						-
						<%=account.getAccountType().name()%> (Balance: $<%=account.getBalance()%>)
					</option>
					<%
					}
					%>
					<%
					} else {
					%>
					<option value="" disabled>No accounts available</option>
					<%
					}
					%>
				</select> <br> <label for="targetAccountNumber">Target Account ID:</label> <br>
				<select name="targetAccountNumber" id="targetAccountNumber" required>
					<%
					if (accounts != null && !accounts.isEmpty()) {
					%>
					<%
					for (Account account : accounts) {
					%>
					<option value="<%=account.getAccountNumber()%>"><%=account.getAccountNumber()%>
						-
						<%=account.getAccountType().name()%> (Balance: $<%=account.getBalance()%>)
					</option>
					<%
					}
					%>
					<%
					} else {
					%>
					<option value="" disabled>No accounts available</option>
					<%
					}
					%>
				</select> <br> <label for="transferAmount">Amount:</label> <input
					type="number" id="transferAmount" name="amount" step="0.01"
					min="0.01" required><br> <br> <label
					for="transferDesc">Description:</label> <input type="text"
					id="transferDesc" name="description"><br> <br> <input
					type="submit" value="Transfer" class="btn btn-primary">
			</form>
		</div>
	</div>
</body>
</html>