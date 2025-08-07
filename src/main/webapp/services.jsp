<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Our Services</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<%@ include file="WEB-INF/jsp/fragments/_header.jspf"%>
	<div class="main-content">
		<div class="container">
			<div class="section">
				<h2 class="text-center">Our Services</h2>
				<p class="text-center">At Maze Bank, we offer a comprehensive
					suite of banking products designed to meet all your financial
					needs. Whether you're saving for the future, managing daily
					expenses, or planning a major purchase, we have a solution for you.</p>
				<div class="card-grid">
					<div class="card">
						<img
							src="${pageContext.request.contextPath}/img/icon-checking.svg"
							alt="Checking Account Icon">
						<h3>Checking Accounts</h3>
						<p>Our checking accounts provide secure and convenient access
							to your money for everyday transactions. Choose from a variety of
							options with no monthly fees and great benefits.</p>
						<a href="#">Learn More</a>
					</div>
					<div class="card">
						<img src="${pageContext.request.contextPath}/img/savings.jpg"
							alt="Savings Account Icon">
						<h3>Savings Accounts</h3>
						<p>Grow your wealth with our high-interest savings accounts.
							We offer flexible options to help you reach your financial goals,
							big or small.</p>
						<a href="#">Learn More</a>
					</div>
					<div class="card">
						<img src="${pageContext.request.contextPath}/img/load.jpg"
							alt="Loan Icon">
						<h3>Personal Loans</h3>
						<p>Get the funds you need with a personal loan from Maze Bank.
							We offer competitive rates and flexible repayment plans to help
							you consolidate debt or finance a major life event.</p>
						<a href="#">Learn More</a>
					</div>
					<div class="card">
						<img
							src="${pageContext.request.contextPath}/img/icon-mortgage.svg"
							alt="Mortgage Icon">
						<h3>Mortgages</h3>
						<p>Buying a home is one of life's biggest decisions. Our
							expert team will guide you through the process, offering a wide
							range of mortgage products to find the best fit for you.</p>
						<a href="#">Learn More</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="WEB-INF/jsp/fragments/_footer.jspf"%>
</body>
</html>