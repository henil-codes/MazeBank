<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to Maze Bank</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/logo.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

    <!-- Header -->
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
                    <li><a href="${pageContext.request.contextPath}/index.jsp" class="active">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/app/login" class="btn-small">Login</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <div class="hero">
        <h1 class="fade-in">Your Financial Journey Starts Here.</h1>
        <p class="fade-in delay-1">Secure, seamless, and smarter banking solutions tailored for your life.</p>
        <div class="mt-4 fade-in delay-2">
            <a href="${pageContext.request.contextPath}/app/register" class="btn">Open an Account Today</a>
        </div>
    </div>

    <!-- Who We Are Section -->
    <div class="container section">
        <h2 class="text-center slide-up">Who We Are</h2>
        <p class="text-center fade-in delay-1">
            Maze Bank is committed to providing secure and innovative financial services that empower our customers.
            We believe in building lasting relationships by offering transparent, reliable, and accessible banking
            for everyone.
        </p>
        <div class="text-center mt-4 fade-in delay-2">
            <a href="${pageContext.request.contextPath}/about.jsp" class="btn-secondary">Learn More</a>
        </div>
    </div>

    <!-- Our Services Section -->
    <div class="container section">
        <h2 class="text-center slide-up">Our Services</h2>
        <p class="text-center fade-in delay-1">
            Explore a wide range of products designed to fit your lifestyle and financial goals.
        </p>
        <div class="card-grid">
            <div class="card">
                <i class="fas fa-piggy-bank" aria-hidden="true"></i>
                <h3>Checking & Savings</h3>
                <p>Manage your daily finances with our flexible and secure account options.</p>
            </div>
            <div class="card">
                <i class="fas fa-exchange-alt" aria-hidden="true"></i>
                <h3>Easy Transfers</h3>
                <p>Send and receive money instantly with our seamless transfer services.</p>
            </div>
            <div class="card">
                <i class="fas fa-home" aria-hidden="true"></i>
                <h3>Loans & Mortgages</h3>
                <p>Achieve your dreams with competitive rates on loans and mortgages.</p>
            </div>
        </div>
        <div class="text-center mt-4 fade-in delay-2">
            <a href="${pageContext.request.contextPath}/services.jsp" class="btn">View All Services</a>
        </div>
    </div>

    <!-- Footer -->
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