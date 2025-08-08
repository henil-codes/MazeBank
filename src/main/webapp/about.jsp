<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About Maze Bank</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/styles.css">
	 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/logo.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	
	<header class="site-header">
        <div class="header-container">
            <!-- Logo -->
            <div class="logo">
                <a href="${pageContext.request.contextPath}/index.jsp">
                    <img src="${pageContext.request.contextPath}/img/logo.png" alt="Maze Bank Logo">
                    <span>Maze Bank</span>
                </a>
            </div>

            <!-- Navigation -->
            <nav class="nav-links">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/index.jsp" >Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/about.jsp" class="active">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/app/login" class="btn-small">Login</a></li>
                </ul>
            </nav>
        </div>
    </header>
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
                        <p>We operate with the highest standards of ethics and honesty. Your trust is our most valuable asset, and we work hard every day to earn and keep it.</p>
                    </div>
                    <div class="card">
                        <i class="fas fa-lightbulb" aria-hidden="true"></i>
                        <h3>Innovation</h3>
                        <p>We embrace technology to provide smarter, faster, and more convenient banking solutions. We are always looking for new ways to serve you better.</p>
                    </div>
                    <div class="card">
                        <i class="fas fa-users" aria-hidden="true"></i>
                        <h3>Community</h3>
                        <p>We are dedicated to the communities we serve. We invest in local initiatives and support our neighbors to help everyone prosper.</p>
                    </div>
                </div>
		</div>
	</div>
	<footer class="site-footer">
        <div class="footer-container">
            <div class="footer-about">
                <h4>Maze Bank</h4>
                <p>Empowering your financial journey with secure, innovative, and seamless banking solutions.</p>
            </div>
            <div class="footer-links">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/app/register">Open Account</a></li>
                </ul>
            </div>
            <div class="footer-social">
                <h4>Follow Us</h4>
                <div class="social-icons">
    <a href="#"><i class="fab fa-facebook-f" aria-hidden="true"></i></a>
    <a href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a>
    <a href="#"><i class="fab fa-linkedin-in" aria-hidden="true"></i></a>
</div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 Maze Bank. All Rights Reserved.</p>
        </div>
    </footer>
</body>
</html>