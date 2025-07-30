<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>User Registration</title>
</head>
<body>
	<h2>Register</h2>
	<form action="regiser" method="post">
		<label>Username:</label> <input type="text" name="username" required /><br />
		<br /> <label>Password:</label> <input type="password" name="password"
			required /><br />
		<br /> <label>Role:</label> <select name="role">
			<option value="customer">Customer</option>
			<option value="admin">Admin</option>
		</select><br />
		<br /> <label>Email:</label> <input type="email" name="email" required /><br />
		<br /> <input type="submit" value="Register" />
	</form>

	<p>
		Already have an account? <a href="login.jsp">Login here</a>
	</p>
	
	<p>
		<a href="ViewUsersServlet"> View users </a>
	</p>
</body>
</html>
