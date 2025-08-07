<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account"%>
<%@ page import="com.mazebank.model.Transaction"%>
<%@ page import="com.mazebank.util.NumberUtils"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account Details</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="dashboard-body">
	<%@ include file="../fragments/_sidebar.jspf"%>
	<div class="main-content">
		<%
		Account account = (Account) request.getAttribute("account");
		if (account != null) {
		%>
		<div class="account-details-container">
			<div class="section">
				<h2>Account Details</h2>
				<div class="account-card">
					<p>
						<strong>Account Number:</strong> <%=account.getAccountNumber()%></p>
					<p>
						<strong>Account Type:</strong> <%=account.getAccountType().name()%></p>
					<p>
						<strong>Current Balance:</strong> <span class="balance"><%=NumberUtils.formatCurrency(account.getBalance())%></span>
					</p>
					<p>
						<strong>Status:</strong> <%=account.getStatus().name()%></p>
					<p>
						<strong>Overdraft Limit:</strong> <%=NumberUtils.formatCurrency(account.getOverdraftLimit())%></p>
					<p>
						<strong>Max Transaction Amount:</strong> <%=NumberUtils.formatCurrency(account.getMaxTransactionAmount())%></p>
				</div>
			</div>

			<div class="section">
				<h2>Transaction History</h2>
				<%
				List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
				if (transactions != null && !transactions.isEmpty()) {
				%>
				<table class="data-table transaction-table">
					<thead>
						<tr>
							<th>Transaction ID</th>
							<th>Type</th>
							<th>Amount</th>
							<th>Date</th>
							<th>Description</th>
							<th>Status</th>
						</tr>	
					</thead>
					<tbody>
						<%
						for (Transaction transaction : transactions) {
						%>
						<tr>
							<td><%=transaction.getTransactionId()%></td>
							<td><%=transaction.getType().name()%></td>
							<td><%=NumberUtils.formatCurrency(transaction.getAmount())%></td>
							<td><%=transaction.getTransactionDate()%></td>
							<td><%=transaction.getDescription()%></td>
							<td><%=transaction.getStatus().name()%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<%
				} else {
				%>
				<div class="alert alert-info">
					<p>No transactions found for this account.</p>
				</div>
				<%
				}
				%>
			</div>
		</div>
		<%
		} else {
		%>
		<div class="alert alert-error">
			<p>Account not found.</p>
		</div>
		<p>
			<a href="${pageContext.request.contextPath}/app/dashboard">Back to
				Dashboard</a>
		</p>
		<%
		}
		%>
	</div>
</body>
</html>