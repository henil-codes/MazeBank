<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="admin-body">
<%@ include file="../fragments/_admin_sidebar.jspf"%>
<div class="admin-main-content">
    <div class="dashboard-header">
        <h1>Admin Control Panel</h1>
        <p>Manage and monitor all system activities efficiently</p>
    </div>
    <div class="dashboard-stats">
        <div class="stat-card">
            <i class="fas fa-users stat-icon"></i>
            <div class="stat-info">
                <h3>Total Users</h3>
                <p class="stat-value">${totalUsers}</p>
            </div>
        </div>
        <div class="stat-card">
            <i class="fas fa-piggy-bank stat-icon"></i>
            <div class="stat-info">
                <h3>Total Accounts</h3>
                <p class="stat-value">${totalAccounts}</p>
            </div>
        </div>
        <div class="stat-card">
            <i class="fas fa-dollar-sign stat-icon"></i>
            <div class="stat-info">
                <h3>Total Transactions</h3>
                <p class="stat-value">${totalTransactions}</p>
            </div>
        </div>
    </div>
    <hr class="divider">
    <div class="admin-card-grid">
        <div class="admin-card">
            <div class="card-header">
                <h3><i class="fas fa-user-cog"></i> Manage Users</h3>
            </div>
            <div class="card-body">
                <p>View, edit, or delete user accounts with advanced controls and filters.</p>
                <a href="${pageContext.request.contextPath}/app/admin/users" class="btn btn-primary">Go to User Management</a>
            </div>
        </div>
        <div class="admin-card">
            <div class="card-header">
                <h3><i class="fas fa-university"></i> Manage Accounts</h3>
            </div>
            <div class="card-body">
                <p>Review and modify all bank accounts with detailed insights.</p>
                <a href="${pageContext.request.contextPath}/app/admin/accounts" class="btn btn-primary">Go to Account Management</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>