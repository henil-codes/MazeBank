<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact Us</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
	 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/logo.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
.contact-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 2rem;
}

.map-placeholder {
	background-color: var(--cibc-light-grey);
	height: 300px;
	width: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: var(--cibc-grey);
	border-radius: 8px;
}
</style>
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
                    <li><a href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact.jsp" class="active">Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/app/login" class="btn-small">Login</a></li>
                </ul>
            </nav>
        </div>
    </header>
	<div class="main-content">
		<div class="container">
			<div class="section">
				<h2 class="text-center">Get in Touch with Us</h2>
				<p class="text-center">Whether you have a question, a comment,
					or a concern, we're here to help. Fill out the form below or find
					our contact details.</p>
				<div class="contact-grid mt-4">
					<div class="form-card">
						<form action="#" method="post">
							<div class="form-group">
								<label for="name">Your Name</label> <input type="text"
									id="name" name="name" required>
							</div>
							<div class="form-group">
								<label for="email">Your Email</label> <input type="email"
									id="email" name="email" required>
							</div>
							<div class="form-group">
								<label for="subject">Subject</label> <input type="text"
									id="subject" name="subject" required>
							</div>
							<div class="form-group">
								<label for="message">Message</label>
								<textarea id="message" name="message" rows="5" required></textarea>
							</div>
							<button type="submit" class="btn">Send Message</button>
						</form>
					</div>
					<div class="card">
						<h3>Our Details</h3>
						<p>
							<strong>Address:</strong><br>123 Banking Street, Suite 400<br>Metropolis, ON A1B 2C3
						</p>
						<p>
							<strong>Phone:</strong><br>1-800-555-MAZE (6293)
						</p>
						<p>
							<strong>Email:</strong><br>support@mazebank.com
						</p>
						<div class="mt-4">
							<h4>Find Us on a Map</h4>
							<div class="map-placeholder">
								<p>[Map Placeholder]</p>
							</div>
						</div>
					</div>
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