<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account"%>
<%@ page import="java.util.List"%>
<%@ page import="com.mazebank.util.NumberUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payments</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
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
		<p style="color: blue;"><%=message%></p>
		<%
		}
		%>

		<h3>Your Accounts for Transactions</h3>

		<%
		if (accounts != null && !accounts.isEmpty()) {
		%>
		<p>Select an account for transactions:</p>
		<ul>
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
		<p>No active accounts available for transactions.</p>
		<%
		}
		%>

		<hr>

		<h3>Perform Transaction</h3>
		<form
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
				type="submit" value="Deposit">
		</form>
		<hr>
		<form
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
				type="submit" value="Withdraw">
		</form>
		<hr>
		<form
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
				type="submit" value="Transfer">
		</form>
	</div>
</body>
</html>