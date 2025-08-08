<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Maze Bank - Sign On</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/logins.css">
<style>
	.error-message {
		color: #dc3545;
		font-size: 0.875rem;
		margin-top: 5px;
		display: none;
	}
	
	.input-error {
		border: 2px solid #dc3545 !important;
		animation: shake 0.3s ease-in-out;
	}
	
	.input-valid {
		border: 2px solid #28a745 !important;
	}
	
	@keyframes shake {
		0%, 100% { transform: translateX(0); }
		25% { transform: translateX(-5px); }
		75% { transform: translateX(5px); }
	}
	
	.btn:disabled {
		opacity: 0.6;
		cursor: not-allowed;
	}
</style>
</head>
<body>
<div class="auth-container">
	<div class="auth-card-container login-form-container">
		<div class="auth-card">
			<h2>Sign On to Maze Bank</h2>
			<%
			String errorMessage = (String) request.getAttribute("errorMessage");
			if (errorMessage != null) {
			%>
			<div class="alert alert-error"><%=errorMessage%></div>
			<%
			}
			%>
			<form id="loginForm" action="${pageContext.request.contextPath}/app/login" method="post">
				<div class="form-group">
					<label for="username">Username</label>
					<input type="text" id="username" name="username" required>
					<div id="usernameError" class="error-message"></div>
				</div>
				
				<div class="form-group">
					<label for="password">Password</label>
					<input type="password" id="password" name="password" required>
					<div id="passwordError" class="error-message"></div>
				</div>
				
				<div class="form-group mt-4">
					<button type="submit" id="submitBtn" class="btn">Sign On</button>
				</div>
			</form>
			
			<p class="mt-4 text-center">
				Don't have an account? <a href="${pageContext.request.contextPath}/app/register">Register now</a>
			</p>
		</div>
	</div>
	<div class="auth-image-container login-image-container">
		<img src="${pageContext.request.contextPath}/img/login-image.png" alt="Secure login illustration">
	</div>
</div>

<script>
	// Validation functions
	function validateUsername(username) {
		username = username.trim();
		
		if (username.length === 0) {
			return "Username is required";
		}
		if (username.length < 3) {
			return "Username must be at least 3 characters";
		}
		if (username.length > 20) {
			return "Username is too long";
		}
		// Basic character validation (similar to registration)
		if (!/^[a-zA-Z0-9_]+$/.test(username)) {
			return "Username contains invalid characters";
		}
		return null;
	}

	function validatePassword(password) {
		if (password.length === 0) {
			return "Password is required";
		}
		if (password.length < 3) {
			return "Password is too short";
		}
		return null;
	}

	function showError(fieldId, message) {
		const field = document.getElementById(fieldId);
		const errorDiv = document.getElementById(fieldId + 'Error');
		
		if (message) {
			field.classList.add('input-error');
			field.classList.remove('input-valid');
			errorDiv.textContent = message;
			errorDiv.style.display = 'block';
			return false;
		} else {
			field.classList.remove('input-error');
			field.classList.add('input-valid');
			errorDiv.style.display = 'none';
			return true;
		}
	}

	function validateField(fieldId, validationFunction) {
		const field = document.getElementById(fieldId);
		const error = validationFunction(field.value);
		return showError(fieldId, error);
	}

	function updateSubmitButton() {
		const submitBtn = document.getElementById('submitBtn');
		const username = document.getElementById('username').value.trim();
		const password = document.getElementById('password').value;
		
		// Enable submit button only if both fields have some content
		if (username.length >= 3 && password.length >= 3) {
			submitBtn.disabled = false;
		} else {
			submitBtn.disabled = true;
		}
	}

	// Real-time validation (on blur to avoid being too aggressive)
	document.getElementById('username').addEventListener('blur', function() {
		validateField('username', validateUsername);
		updateSubmitButton();
	});

	document.getElementById('password').addEventListener('blur', function() {
		validateField('password', validatePassword);
		updateSubmitButton();
	});

	// Update submit button state on input
	document.getElementById('username').addEventListener('input', updateSubmitButton);
	document.getElementById('password').addEventListener('input', updateSubmitButton);

	// Form submission validation
	document.getElementById('loginForm').addEventListener('submit', function(e) {
		e.preventDefault();

		let isValid = true;

		// Validate both fields
		isValid &= validateField('username', validateUsername);
		isValid &= validateField('password', validatePassword);

		if (isValid) {
			// Show loading state
			const submitBtn = document.getElementById('submitBtn');
			const originalText = submitBtn.textContent;
			submitBtn.textContent = 'Signing In...';
			submitBtn.disabled = true;
			
			// Submit the form
			this.submit();
		} else {
			// Focus on first invalid field
			const firstError = document.querySelector('.input-error');
			if (firstError) {
				firstError.focus();
			}
		}
	});

	// Clear validation styling when user starts typing
	document.querySelectorAll('input').forEach(function(field) {
		field.addEventListener('focus', function() {
			this.classList.remove('input-error', 'input-valid');
			document.getElementById(this.id + 'Error').style.display = 'none';
		});
	});

	// Prevent form submission with Enter if validation fails
	document.addEventListener('keypress', function(e) {
		if (e.key === 'Enter') {
			const username = document.getElementById('username').value.trim();
			const password = document.getElementById('password').value;
			
			if (username.length < 3 || password.length < 3) {
				e.preventDefault();
				document.getElementById('loginForm').dispatchEvent(new Event('submit'));
			}
		}
	});

	// Initialize submit button state
	updateSubmitButton();
</script>
</body>
</html>