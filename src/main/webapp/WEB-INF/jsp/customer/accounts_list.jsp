<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account"%>
<%@ page import="com.mazebank.util.NumberUtils"%>
<%@ page import="java.util.List"%>
<%@ include file="../fragments/_sidebar.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Accounts</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/tables.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<div class="main-content">
		<h2>Your Accounts</h2>

		<%
		List<Account> accounts = (List<Account>) request.getAttribute("userAccounts");
		%>

		<%
		if (accounts != null && !accounts.isEmpty()) {
		%>
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
				<%
				for (Account account : accounts) {
				%>
				<tr>
					<td><%=account.getAccountNumber()%></td>
					<td><%=account.getAccountType().name()%></td>
					<td><%=NumberUtils.formatCurrency(account.getBalance())%></td>
					<td><%=account.getStatus().name()%></td>
					<td><a
						href="${pageContext.request.contextPath}/app/customer/accounts/view?id=<%= account.getAccountId() %>">View
							Details</a></td>
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
			<p>You have no accounts to display.</p>
		</div>
		<%
		}
		%>
	</div>
</body>
</html>