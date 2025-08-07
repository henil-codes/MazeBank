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
<style>
/* Inline CSS for payments.jsp */
.payments-container {
	padding: 20px;
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.transaction-card {
	border: 1px solid #ddd;
	border-radius: 6px;
	padding: 20px;
	margin-bottom: 25px;
	background-color: #fcfcfc;
}

.transaction-card h4 {
	color: #333;
	margin-top: 0;
	margin-bottom: 15px;
	border-bottom: 1px solid #eee;
	padding-bottom: 10px;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
	color: #555;
}

.form-group input[type="text"], .form-group input[type="number"],
	.form-group select {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box; /* Ensures padding doesn't affect width */
	font-size: 16px;
}

input[type="submit"] {
	background-color: #dc3545;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
	background-color: #c82333;
}
</style>
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
		<p style="color: green;"><%=message%></p>
		<%
		}
		%>

		<div class="payments-container">
			<h3>Your Accounts for Transactions</h3>
			<%
			if (accounts != null && !accounts.isEmpty()) {
			%>
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
		</div>

		<hr>

		<div class="payments-container">
			<h3>Perform Transaction</h3>
			<div class="transaction-card">
				<form
					action="${pageContext.request.contextPath}/app/transactions/deposit"
					method="post">
					<h4>Deposit</h4>
					<div class="form-group">
						<label for="depositAccountNumber">Account ID:</label> <select
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
						</select>
					</div>
					<div class="form-group">
						<label for="depositAmount">Amount:</label> <input type="number"
							id="depositAmount" name="amount" step="0.01" min="0.01" required>
					</div>
					<div class="form-group">
						<label for="depositDesc">Description:</label> <input type="text"
							id="depositDesc" name="description">
					</div>
					<input type="submit" value="Deposit">
				</form>
			</div>

			<div class="transaction-card">
				<form
					action="${pageContext.request.contextPath}/app/transactions/withdrawal"
					method="post">
					<h4>Withdrawal</h4>
					<div class="form-group">
						<label for="withdrawAccountNumber">Account ID:</label> <select
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
						</select>
					</div>
					<div class="form-group">
						<label for="withdrawAmount">Amount:</label> <input type="number"
							id="withdrawAmount" name="amount" step="0.01" min="0.01" required>
					</div>
					<div class="form-group">
						<label for="withdrawDesc">Description:</label> <input type="text"
							id="withdrawDesc" name="description">
					</div>
					<input type="submit" value="Withdraw">
				</form>
			</div>

			<div class="transaction-card">
				<form
					action="${pageContext.request.contextPath}/app/transactions/transfer"
					method="post">
					<h4>Transfer</h4>
					<div class="form-group">
						<label for="sourceAccountNumber">Source Account ID:</label> <select
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
						</select>
					</div>
					<div class="form-group">
						<label for="targetAccountNumber">Target Account ID:</label> <select
							name="targetAccountNumber" id="targetAccountNumber" required>
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
						</select>
					</div>
					<div class="form-group">
						<label for="transferAmount">Amount:</label> <input type="number"
							id="transferAmount" name="amount" step="0.01" min="0.01" required>
					</div>
					<div class="form-group">
						<label for="transferDesc">Description:</label> <input type="text"
							id="transferDesc" name="description">
					</div>
					<input type="submit" value="Transfer">
				</form>
			</div>
		</div>
	</div>
</body>
</html>