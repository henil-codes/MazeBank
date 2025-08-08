<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account"%>
<%@ page import="java.util.List"%>
<%@ page import="com.mazebank.util.NumberUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Account Management</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/tables.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="admin-body">
	<%@ include file="../fragments/_admin_sidebar.jspf"%>

	<div class="admin-main-content">
		<h2>Account Management</h2>

		<%-- Display messages --%>
		<%
		String message = request.getParameter("message");
		if (message != null) {
		%>
		<p style="color: blue;"><%=message%></p>
		<%
		}
		%>

		<h3>All Accounts</h3>
		<%
		List<Account> allAccounts = (List<Account>) request.getAttribute("allAccounts");
		%>
		<%
		if (allAccounts != null && !allAccounts.isEmpty()) {
		%>
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
				<%
				for (Account account : allAccounts) {
				%>
				<tr>
					<td><%=account.getAccountId()%></td>
					<td><%=account.getUserId()%></td>
					<td><%=account.getAccountNumber()%></td>
					<td><%=account.getAccountType().name()%></td>
					<td><%=NumberUtils.formatCurrency(account.getBalance())%></td>
					<td><%=NumberUtils.formatCurrency(account.getOverdraftLimit())%></td>
					<td><%=NumberUtils.formatCurrency(account.getMaxTransactionAmount())%></td>
					<td><%=account.getStatus().name()%></td>
					<td><a
						href="${pageContext.request.contextPath}/app/admin/accounts/view?id=<%=account.getAccountId()%>">View</a>
						| <a
						href="${pageContext.request.contextPath}/app/admin/accounts/edit?accountId=<%=account.getAccountId()%>">Edit</a>
						| <%
					if (account.getStatus().name().equals("ACTIVE")) {
					%> <a
						href="${pageContext.request.contextPath}/app/accounts/close?accountId=<%=account.getAccountId()%>">Close</a>
						<%
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
		<p>No accounts found in the system.</p>
		<%
		}
		%>
	</div>
</body>
</html>