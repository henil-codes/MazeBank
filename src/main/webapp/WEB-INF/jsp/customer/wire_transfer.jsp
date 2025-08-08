<%-- File: WEB-INF/jsp/customer/wire_transfer.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Wire Transfer</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/wire_transfer.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="dashboard-body">
	<div class="dashboard-container">
		<%@ include file="../fragments/_sidebar.jspf"%>
		<div class="main-content">
			<h2>Wire Transfer</h2>

			<%-- Displaying error message from URL parameter --%>
			<%
			if (request.getParameter("error") != null) {
			%>
			<div class="alert alert-error">
				<%=request.getParameter("error")%>
			</div>
			<%
			}
			%>

			<form class="form-card"
				action="${pageContext.request.contextPath}/app/customer/wire_transfer"
				method="post">
				<div class="form-group">
					<label for="senderAccountNumber">Your Account:</label> <select
						name="senderAccountNumber" id="senderAccountNumber" required>
						<%
						List<Account> userAccounts = (List<Account>) request.getAttribute("userAccounts");
						%>
						<%
						if (userAccounts != null && !userAccounts.isEmpty()) {
						%>
						<%
						for (Account account : userAccounts) {
						%>
						<option value="<%=account.getAccountNumber()%>"><%=account.getAccountNumber()%>
							- <%=account.getAccountType().name()%> (Balance: $<%=account.getBalance()%>)</option>
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
					<label for="recipientAccountNumber">Recipient's Account Number:</label>
					<input type="text" id="recipientAccountNumber"
						name="recipientAccountNumber" required>
				</div>

				<div class="form-group">
					<label for="amount">Amount:</label> <input type="number" id="amount"
						name="amount" step="0.01" required min="0.01">
				</div>

				<div class="form-group">
					<label for="description">Description (Optional):</label>
					<textarea id="description" name="description"></textarea>
				</div>

				<div class="form-group">
					<button type="submit" class="btn btn-primary">Submit Transfer</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>