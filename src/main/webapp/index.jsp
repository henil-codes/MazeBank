<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to Maze Bank</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<%@ include file="WEB-INF/jsp/fragments/_header.jspf"%>
	<div class="main-content">
		<div class="hero">
			<h1>Your Financial Journey Starts Here.</h1>
			<p>Secure, seamless, and smarter banking solutions tailored for
				your life.</p>
			<div class="mt-4">
				<a href="${pageContext.request.contextPath}/app/register"
					class="btn">Open an Account Today</a>
			</div>
		</div>

		<div class="container section">
			<h2 class="text-center">Who We Are</h2>
			<p class="text-center">Maze Bank is committed to providing secure
				and innovative financial services that empower our customers. We
				believe in building lasting relationships by offering transparent,
				reliable, and accessible banking for everyone.</p>
			<div class="text-center mt-4">
				<a href="${pageContext.request.contextPath}/about.jsp"
					class="btn-secondary">Learn More</a>
			</div>
		</div>

		<div class="container section">
			<h2 class="text-center">Our Services</h2>
			<p class="text-center">Explore a wide range of products designed
				to fit your lifestyle and financial goals.</p>
			<div class="card-grid">
				<div class="card">
					<img src="${pageContext.request.contextPath}/img/icon-accounts.svg"
						alt="Accounts Icon">
					<h3>Checking & Savings</h3>
					<p>Manage your daily finances with our flexible and secure
						account options.</p>
				</div>
				<div class="card">
					<img
						src="${pageContext.request.contextPath}/img/icon-transfers.svg"
						alt="Transfers Icon">
					<h3>Easy Transfers</h3>
					<p>Send and receive money instantly with our seamless transfer
						services.</p>
				</div>
				<div class="card">
					<img src="${pageContext.request.contextPath}/img/icon-loans.svg"
						alt="Loans Icon">
					<h3>Loans & Mortgages</h3>
					<p>Achieve your dreams with competitive rates on loans and
						mortgages.</p>
				</div>
			</div>
			<div class="text-center mt-4">
				<a href="${pageContext.request.contextPath}/services.jsp"
					class="btn">View All Services</a>
			</div>
		</div>
	</div>
	<%@ include file="WEB-INF/jsp/fragments/_footer.jspf"%>
</body>
</html>