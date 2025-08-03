<%-- File: WEB-INF/jsp/customer/wire_transfer.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.Account" %>
<%@ page import="java.util.List" %>
<%@ include file="../fragments/_sidebar.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Wire Transfer</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="main-content">
        <h2>Wire Transfer</h2>
        
        <%-- Displaying error message from URL parameter --%>
        <% if (request.getParameter("error") != null) { %>
            <p class="error-message"><%= request.getParameter("error") %></p>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/app/customer/wire_transfer" method="post">
            <label for="senderAccountNumber">Your Account:</label>
            <select name="senderAccountNumber" id="senderAccountNumber" required>
                <% List<Account> userAccounts = (List<Account>) request.getAttribute("userAccounts"); %>
                <% if (userAccounts != null && !userAccounts.isEmpty()) { %>
                    <% for (Account account : userAccounts) { %>
                        <option value="<%= account.getAccountNumber() %>"><%= account.getAccountNumber() %> - <%= account.getAccountType().name() %> (Balance: $<%= account.getBalance() %>)</option>
                    <% } %>
                <% } else { %>
                    <option value="" disabled>No accounts available</option>
                <% } %>
            </select>
            <br/>
            
            <label for="recipientAccountNumber">Recipient's Account Number:</label>
            <input type="text" id="recipientAccountNumber" name="recipientAccountNumber" required>
            <br/>
            
            <label for="amount">Amount:</label>
            <input type="number" id="amount" name="amount" step="0.01" required min="0.01">
            <br/>
            
            <label for="description">Description (Optional):</label>
            <textarea id="description" name="description"></textarea>
            <br/>
            
            <button type="submit" class="button">Submit Transfer</button>
        </form>
    </div>
</body>
</html>