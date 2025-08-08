<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.HolderType"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MazeBank - Register</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/styles.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/logins.css">
<style>
	.error-message {
		color: #dc3545;
		font-size: 0.875rem;
		margin-top: 5px;
		display: none;
	}
	
	.input-error {
		border: 2px solid #dc3545 !important;
	}
	
	.input-valid {
		border: 2px solid #28a745 !important;
	}
	
	.password-requirements {
		font-size: 0.8rem;
		margin-top: 5px;
		color: #6c757d;
	}
	
	.requirement {
		display: block;
		margin: 2px 0;
	}
	
	.requirement.valid {
		color: #28a745;
	}
	
	.requirement.invalid {
		color: #dc3545;
	}
</style>
</head>
<body>
	<div class="auth-container">
		<div class="auth-image-container register-image-container">
			<img src="${pageContext.request.contextPath}/img/register-image.png"
				alt="Registration illustration">
		</div>
		<div class="auth-card-container register-card-container">
			<div class="auth-card">
				<h2>Register for a new account</h2>

				<%
				if (request.getAttribute("message") != null) {
				%>
				<div class="alert alert-success"><%=request.getAttribute("message")%></div>
				<%
				}
				%>
				<%
				if (request.getAttribute("errorMessage") != null) {
				%>
				<div class="alert alert-error"><%=request.getAttribute("errorMessage")%></div>
				<%
				}
				%>

				<form id="registrationForm" action="${pageContext.request.contextPath}/app/register"
					method="post">
					<div class="form-group">
						<label for="username">Username</label> 
						<input type="text" id="username" name="username" required>
						<div id="usernameError" class="error-message"></div>
					</div>
					
					<div class="form-group">
						<label for="password">Password</label> 
						<input type="password" id="password" name="password" required>
						<div class="password-requirements">
							<span id="lengthReq" class="requirement">• At least 8 characters</span>
							<span id="upperReq" class="requirement">• At least 1 uppercase letter</span>
							<span id="lowerReq" class="requirement">• At least 1 lowercase letter</span>
							<span id="numberReq" class="requirement">• At least 1 number</span>
							<span id="specialReq" class="requirement">• At least 1 special character (!@#$%^&*)</span>
						</div>
						<div id="passwordError" class="error-message"></div>
					</div>
					
					<div class="form-group">
						<label for="email">Email</label> 
						<input type="email" id="email" name="email" required>
						<div id="emailError" class="error-message"></div>
					</div>
					
					<div class="form-group">
						<label for="firstName">First Name</label> 
						<input type="text" id="firstName" name="firstName" required>
						<div id="firstNameError" class="error-message"></div>
					</div>
					
					<div class="form-group">
						<label for="lastName">Last Name</label> 
						<input type="text" id="lastName" name="lastName" required>
						<div id="lastNameError" class="error-message"></div>
					</div>
					
					<div class="form-group">
						<label for="holderType">Holder Type</label> 
						<select id="holderType" name="holderType" required>
							<%
							for (HolderType holderType : HolderType.values()) {
							%>
							<option value="<%=holderType.name()%>"
								<%= (holderType == HolderType.PERSONAL) ? "selected" : ""%>><%=holderType.name()%></option>
							<%
							}
							%>
						</select>
						<div id="holderTypeError" class="error-message"></div>
					</div>
					
					<div class="form-group mt-4">
						<button type="submit" class="btn">Register</button>
					</div>
				</form>

				<p class="mt-4 text-center">
					Already have an account? <a
						href="${pageContext.request.contextPath}/app/login">Login
						here</a>.
				</p>
			</div>
		</div>
	</div>

	<script>
		// Validation functions
		function validateUsername(username) {
			if (username.length < 3) {
				return "Username must be at least 3 characters long";
			}
			if (username.length > 20) {
				return "Username must be no more than 20 characters long";
			}
			if (!/^[a-zA-Z0-9_]+$/.test(username)) {
				return "Username can only contain letters, numbers, and underscores";
			}
			return null;
		}

		function validatePassword(password) {
			const requirements = {
				length: password.length >= 8,
				upper: /[A-Z]/.test(password),
				lower: /[a-z]/.test(password),
				number: /\d/.test(password),
				special: /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)
			};

			// Update requirement indicators
			document.getElementById('lengthReq').className = 'requirement ' + (requirements.length ? 'valid' : 'invalid');
			document.getElementById('upperReq').className = 'requirement ' + (requirements.upper ? 'valid' : 'invalid');
			document.getElementById('lowerReq').className = 'requirement ' + (requirements.lower ? 'valid' : 'invalid');
			document.getElementById('numberReq').className = 'requirement ' + (requirements.number ? 'valid' : 'invalid');
			document.getElementById('specialReq').className = 'requirement ' + (requirements.special ? 'valid' : 'invalid');

			const allValid = Object.values(requirements).every(req => req);
			if (!allValid) {
				return "Password must meet all requirements above";
			}
			return null;
		}

		function validateEmail(email) {
			const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (!emailRegex.test(email)) {
				return "Please enter a valid email address";
			}
			return null;
		}

		function validateName(name, fieldName) {
			if (name.trim().length < 2) {
				return fieldName + " must be at least 2 characters long";
			}
			if (name.trim().length > 50) {
				return fieldName + " must be no more than 50 characters long";
			}
			if (!/^[a-zA-Z\s'-]+$/.test(name.trim())) {
				return fieldName + " can only contain letters, spaces, hyphens, and apostrophes";
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

		function validateField(fieldId, validationFunction, ...args) {
			const field = document.getElementById(fieldId);
			const error = validationFunction(field.value, ...args);
			return showError(fieldId, error);
		}

		// Real-time validation
		document.getElementById('username').addEventListener('input', function() {
			validateField('username', validateUsername);
		});

		document.getElementById('password').addEventListener('input', function() {
			validateField('password', validatePassword);
		});

		document.getElementById('email').addEventListener('input', function() {
			validateField('email', validateEmail);
		});

		document.getElementById('firstName').addEventListener('input', function() {
			validateField('firstName', validateName, 'First Name');
		});

		document.getElementById('lastName').addEventListener('input', function() {
			validateField('lastName', validateName, 'Last Name');
		});

		// Form submission validation
		document.getElementById('registrationForm').addEventListener('submit', function(e) {
			e.preventDefault();

			let isValid = true;

			// Validate all fields
			isValid &= validateField('username', validateUsername);
			isValid &= validateField('password', validatePassword);
			isValid &= validateField('email', validateEmail);
			isValid &= validateField('firstName', validateName, 'First Name');
			isValid &= validateField('lastName', validateName, 'Last Name');

			// Check if holder type is selected
			const holderType = document.getElementById('holderType');
			if (!holderType.value) {
				showError('holderType', 'Please select a holder type');
				isValid = false;
			} else {
				showError('holderType', null);
			}

			if (isValid) {
				// If all validations pass, submit the form
				this.submit();
			} else {
				// Scroll to first error
				const firstError = document.querySelector('.input-error');
				if (firstError) {
					firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
				}
			}
		});

		// Remove validation styling on focus
		document.querySelectorAll('input, select').forEach(function(field) {
			field.addEventListener('focus', function() {
				this.classList.remove('input-error', 'input-valid');
			});
		});
	</script>
</body>
</html>