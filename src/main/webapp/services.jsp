<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Our Services</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
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
                    <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/services.jsp" class="active">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/app/login" class="btn-small">Login</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <div class="main-content">
        <div class="container">
            <div class="section">
                <h2 class="text-center">Our Services</h2>
                <p class="text-center">At Maze Bank, we offer a comprehensive suite of banking products designed to meet all your financial needs. Whether you're saving for the future, managing daily expenses, or planning a major purchase, we have a solution for you.</p>
                <div class="card-grid">
                    <div class="card">
                        <i class="fas fa-university" aria-hidden="true"></i>
                        <h3>Checking Accounts</h3>
                        <p>Our checking accounts provide secure and convenient access to your money for everyday transactions. Choose from a variety of options with no monthly fees and great benefits.</p>
                        <a href="#" class="btn-secondary">Learn More</a>
                    </div>
                    <div class="card">
                        <i class="fas fa-piggy-bank" aria-hidden="true"></i>
                        <h3>Savings Accounts</h3>
                        <p>Grow your wealth with our high-interest savings accounts. We offer flexible options to help you reach your financial goals, big or small.</p>
                        <a href="#" class="btn-secondary">Learn More</a>
                    </div>
                    <div class="card">
                        <i class="fas fa-hand-holding-usd" aria-hidden="true"></i>
                        <h3>Personal Loans</h3>
                        <p>Get the funds you need with a personal loan from Maze Bank. We offer competitive rates and flexible repayment plans to help you consolidate debt or finance a major life event.</p>
                        <a href="#" class="btn-secondary">Learn More</a>
                    </div>
                    <div class="card">
                        <i class="fas fa-home" aria-hidden="true"></i>
                        <h3>Mortgages</h3>
                        <p>Buying a home is one of life's biggest decisions. Our expert team will guide you through the process, offering a wide range of mortgage products to find the best fit for you.</p>
                        <a href="#" class="btn-secondary">Learn More</a>
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