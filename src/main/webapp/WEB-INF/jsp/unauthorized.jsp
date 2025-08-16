<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Access Denied - MazeBank</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
        * {
            box-sizing: border-box;
        }
        
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .unauthorized-container {
            max-width: 500px;
            margin: 2rem;
            padding: 3rem 2.5rem;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 
                0 25px 50px rgba(0, 0, 0, 0.15),
                0 0 0 1px rgba(255, 255, 255, 0.2);
            text-align: center;
            position: relative;
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }
        
        .unauthorized-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ff6b6b, #4ecdc4, #45b7d1, #96ceb4, #ffeaa7);
            background-size: 300% 100%;
            animation: gradientMove 3s ease-in-out infinite;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes gradientMove {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }
        
        .error-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 30px rgba(238, 90, 82, 0.3);
            animation: pulse 2s ease-in-out infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        .error-icon svg {
            width: 40px;
            height: 40px;
            fill: white;
        }
        
        .main-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: #2d3436;
            margin-bottom: 1rem;
            letter-spacing: -0.5px;
        }
        
        .error-code {
            display: inline-block;
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);
            color: white;
            padding: 0.3rem 1rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            letter-spacing: 0.5px;
        }
        
        .unauthorized-message {
            font-size: 1.1rem;
            color: #636e72;
            margin-bottom: 2.5rem;
            line-height: 1.6;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 2rem;
        }
        
        .btn {
            display: inline-block;
            padding: 0.8rem 1.8rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            border: none;
            cursor: pointer;
            min-width: 140px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background: transparent;
            color: #636e72;
            border: 2px solid #ddd;
        }
        
        .btn-secondary:hover {
            background: #f8f9fa;
            border-color: #667eea;
            color: #667eea;
            transform: translateY(-1px);
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        
        .btn:hover::before {
            left: 100%;
        }
        
        .help-text {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e9ecef;
            color: #868e96;
            font-size: 0.9rem;
        }
        
        .floating-shapes {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -1;
        }
        
        .floating-shapes .shape {
            position: absolute;
            opacity: 0.1;
            animation: float 6s ease-in-out infinite;
        }
        
        .floating-shapes .shape:nth-child(1) {
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }
        
        .floating-shapes .shape:nth-child(2) {
            top: 60%;
            right: 10%;
            animation-delay: 2s;
        }
        
        .floating-shapes .shape:nth-child(3) {
            bottom: 20%;
            left: 20%;
            animation-delay: 4s;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-20px) rotate(120deg); }
            66% { transform: translateY(20px) rotate(240deg); }
        }
        
        /* Responsive design */
        @media (max-width: 768px) {
            .unauthorized-container {
                margin: 1rem;
                padding: 2rem 1.5rem;
            }
            
            .main-title {
                font-size: 1.8rem;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                min-width: 200px;
            }
        }
    </style>
</head>
<body>
    <!-- Floating background shapes -->
    <div class="floating-shapes">
        <div class="shape">
            <svg width="60" height="60" viewBox="0 0 60 60">
                <circle cx="30" cy="30" r="25" fill="rgba(255,255,255,0.1)"/>
            </svg>
        </div>
        <div class="shape">
            <svg width="40" height="40" viewBox="0 0 40 40">
                <rect x="5" y="5" width="30" height="30" rx="5" fill="rgba(255,255,255,0.1)"/>
            </svg>
        </div>
        <div class="shape">
            <svg width="50" height="50" viewBox="0 0 50 50">
                <polygon points="25,5 45,40 5,40" fill="rgba(255,255,255,0.1)"/>
            </svg>
        </div>
    </div>

    <div class="unauthorized-container">
        <!-- Error Icon -->
        <div class="error-icon">
            <svg viewBox="0 0 24 24">
                <path d="M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M12,4C16.41,4 20,7.59 20,12C20,16.41 16.41,20 12,20C7.59,20 4,16.41 4,12C7.59,4 12,4Z M11,7V13H13V7H11M11,15V17H13V15H11"/>
            </svg>
        </div>
        
        <h1 class="main-title">Access Denied</h1>
        <div class="error-code">ERROR 403</div>
        
        <p class="unauthorized-message">
            <% if (request.getAttribute("errorMessage") != null) { %>
                <%= request.getAttribute("errorMessage") %>
            <% } else { %>
                Sorry, you don't have the necessary permissions to access this page. Please contact your administrator if you believe this is an error.
            <% } %>
        </p>
        
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/app/dashboard" class="btn btn-primary">
                Go to Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary">
                Back to Login
            </a>
        </div>
        
        <div class="help-text">
            If you continue to experience issues, please contact support or try logging out and back in.
        </div>
    </div>
</body>
</html>