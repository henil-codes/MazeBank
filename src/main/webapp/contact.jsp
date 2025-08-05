<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact Us</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
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
	<%@ include file="WEB-INF/jsp/fragments/_header.jspf"%>
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
	<%@ include file="WEB-INF/jsp/fragments/_footer.jspf"%>
</body>
</html>