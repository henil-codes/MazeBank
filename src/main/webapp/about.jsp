<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About Maze Bank</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<%@ include file="WEB-INF/jsp/fragments/_header.jspf"%>
	<div class="main-content">
		<div class="container">
			<div class="section">
				<h2 class="text-center">Our Story</h2>
				<p>Maze Bank was founded on the principle that banking should be
					simple, transparent, and accessible to everyone. We started as a
					small community bank with a big vision: to use technology to
					streamline financial services and empower our customers to take
					control of their financial futures. Over the years, we have grown
					into a trusted partner for thousands of individuals and businesses,
					but our core values remain the same.</p>
				<p>Our journey is defined by our commitment to innovation and
					customer service. We are constantly evolving to meet the changing
					needs of the modern world while staying true to our roots of
					community and trust. At Maze Bank, you're not just a customer;
					you're part of our family.</p>
			</div>
			<div class="section">
				<h2 class="text-center">Our Values</h2>
				<div class="card-grid">
					<div class="card">
						<i class="fas fa-balance-scale" aria-hidden="true"></i>
						<h3>Integrity</h3>
						<p>We operate with the highest standards of ethics and
							honesty. Your trust is our most valuable asset, and we work hard
							every day to earn and keep it.</p>
					</div>
					<div class="card">
						<i class="fas fa-lightbulb" aria-hidden="true"></i>
						<h3>Innovation</h3>
						<p>We embrace technology to provide smarter, faster, and more
							convenient banking solutions. We are always looking for new ways
							to serve you better.</p>
					</div>
					<div class="card">
						<i class="fas fa-users" aria-hidden="true"></i>
						<h3>Community</h3>
						<p>We are dedicated to the communities we serve. We invest in
							local initiatives and support our neighbors to help everyone
							prosper.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="WEB-INF/jsp/fragments/_footer.jspf"%>
</body>
</html>