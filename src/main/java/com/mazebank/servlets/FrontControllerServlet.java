package com.mazebank.servlets;

import com.mazebank.dto.UserLoginDTO;
import com.mazebank.exception.AuthException;
import com.mazebank.exception.ResourceNotFoundException;
import com.mazebank.model.User;
import com.mazebank.model.UserRole; // New import
import com.mazebank.service.AuthService;
import com.mazebank.service.AuthServiceImpl;
import com.mazebank.service.UserService;
import com.mazebank.service.UserServiceImpl;
import com.mazebank.service.WireTransferService;
import com.mazebank.service.WireTransferServiceImpl;
import com.mazebank.util.PasswordUtil;
import com.mazebank.dto.UserResponseDTO;
import com.mazebank.dto.WireTransferDTO;
import com.mazebank.dto.AccountCreationDTO;
import com.mazebank.dto.TransactionDTO;
import com.mazebank.dto.UserEditDTO;
import com.mazebank.exception.InsufficientFundsException;
import com.mazebank.exception.InvalidTransferException;
import com.mazebank.model.Account;
import com.mazebank.model.AccountStatus;
import com.mazebank.model.AccountType;
import com.mazebank.model.HolderType;
import com.mazebank.model.Transaction;
import com.mazebank.model.TransactionType;
import com.mazebank.model.UserStatus;
import com.mazebank.service.AccountService;
import com.mazebank.service.AccountServiceImpl;
import com.mazebank.service.TransactionService;
import com.mazebank.service.TransactionServiceImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; // Keep if you use @WebServlet for other servlets
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

// This servlet acts as the Front Controller, routing requests to appropriate logic.
// The @WebServlet annotation is removed here because it's now mapped in web.xml
// to ensure explicit order with filters.
public class FrontControllerServlet extends HttpServlet {

	private AuthService authService;
	private UserService userService;
	private AccountService accountService;
	private TransactionService transactionService;
	private WireTransferService wireTransferService;

	@Override
	public void init() throws ServletException {
		super.init();
		authService = new AuthServiceImpl();
		userService = new UserServiceImpl();
		accountService = new AccountServiceImpl();
		transactionService = new TransactionServiceImpl();
		wireTransferService = new WireTransferServiceImpl();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Get all path information for debugging
		String pathInfo = request.getPathInfo();
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String servletPath = request.getServletPath();
		String queryString = request.getQueryString();

		// Enhanced debug logging
		System.out.println("=== SERVLET DEBUG INFO ===");
		System.out.println("Full Request URL: " + request.getRequestURL().toString());
		System.out.println("Request URI: " + requestURI);
		System.out.println("Context Path: " + contextPath);
		System.out.println("Servlet Path: " + servletPath);
		System.out.println("Path Info: " + pathInfo);
		System.out.println("Query String: " + queryString);
		System.out.println("Method: " + request.getMethod());

		// Check if servlet is being called at all
		System.out.println("FrontControllerServlet.doPost() called successfully!");
		System.out.println("========================");

		// Ensure pathInfo is not null
		if (pathInfo == null) {
			System.out.println("PathInfo is null, checking servlet path...");
			if (servletPath != null && !servletPath.isEmpty()) {
				pathInfo = servletPath;
				System.out.println("Using servlet path as pathInfo: " + pathInfo);
			} else {
				System.out.println("Both pathInfo and servletPath are null/empty!");
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request path");
				return;
			}
		}

		try {
			// Check for method override (e.g., for PUT/DELETE via POST)
			String methodOverride = request.getParameter("_method");
			if ("PUT".equalsIgnoreCase(methodOverride)) {
				doPut(request, response);
				return;
			}

			System.out.println("Attempting to match pathInfo: '" + pathInfo + "'");

			switch (pathInfo) {
			case "/login":
				System.out.println("Matched: /login");
				handleLogin(request, response);
				break;
			case "/transactions/deposit":
				System.out.println("Matched: /transactions/deposit - Handling deposit request");
				handleDeposit(request, response);
				break;
			case "/transactions/withdrawal":
				System.out.println("Matched: /transactions/withdrawal");
				handleWithdrawal(request, response);
				break;
			case "/transactions/transfer":
				System.out.println("Matched: /transactions/transfer");
				handleTransfer(request, response);
				break;
			case "/customer/wire_transfer":
				handleProcessWireTransfer(request, response);
				break;

			// admin functionality

			case "/admin/accounts/create/one":
				System.out.println("Matched: /accounts/create");
				handleAccountCreation(request, response);
				break;
			case "/admin/accounts/edit":
			    System.out.println("Matched: /admin/accounts/edit");
			    handleUpdateAccount(request, response);
			    break;
			case "/admin/users/approve":
				System.out.println("Matched: /admin/users/approve");
				handleApproveUser(request, response);
				break;
			case "/admin/users/edit":
				System.out.println("Matched: /admin/users/edit");
				handleUpdateUser(request, response);
				break;
			case "/admin/users/delete":
				System.out.println("Matched: /admin/users/delete");
				handleDeleteUser(request, response);
				break;
			case "/customer/profile":
			    handleProfileUpdate(request, response);
			    break;
			case "/test":
				System.out.println("Test endpoint reached!");
				response.getWriter().write("Servlet is working!");
				break;
			default:
				System.out.println("NO MATCH FOUND for pathInfo: '" + pathInfo + "'");
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "Path not found: " + pathInfo);
				break;
			}
		} catch (AuthException | ResourceNotFoundException | InsufficientFundsException e) {
			System.out.println("Business logic exception: " + e.getMessage());
			request.setAttribute("errorMessage", e.getMessage());
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (IllegalArgumentException e) {
			System.out.println("Validation exception: " + e.getMessage());
			request.setAttribute("errorMessage", "Invalid input: " + e.getMessage());
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (SQLException e) {
			System.out.println("Database exception: " + e.getMessage());
			request.setAttribute("errorMessage", "Database error: " + e.getMessage());
			e.printStackTrace();
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println("Unexpected exception: " + e.getMessage());
			request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
			e.printStackTrace();
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		System.out.println("DO GET Request PathInfo: " + pathInfo);

		try {
			switch (pathInfo) {
			case "/dashboard":
				handleDashboardRedirect(request, response); // New handler for role-based dashboard
				break;
			case "/login":
				RequestDispatcher login = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
				login.forward(request, response);
				break;
			case "/logout":
				handleLogout(request, response);
				break;
			// Customer-specific GET routes
			case "/customer/payments":
				showCustomerPaymentsPage(request, response);
				break;
			case "/customer/accounts":
				showCustomerAccounts(request, response);
				break;
			case "/customer/accounts/view":
				showCustomerAccountDetails(request, response);
				break;
			case "/customer/wire_transfer":
				handleWireTransferPage(request, response);
				break;
			case "/customer/profile":
			    showCustomerProfile(request, response);
			    break;
			    
			// Admin-specific GET routes
			case "/admin/users":
				showAdminUserManagementPage(request, response);
				break;
			case "/admin/users/edit":
				showEditUserPage(request, response);
				break;
			case "/admin/accounts":
				showAdminAccountManagementPage(request, response);
				break;
			case "/admin/accounts/create":
				showAdminAccountCreatePage(request, response);
				break;
			case "/admin/accounts/view":
				RequestDispatcher accountView = request
						.getRequestDispatcher("/WEB-INF/jsp/customer/account_details.jsp");
				accountView.forward(request, response);
				break;
			case "/admin/accounts/edit":
			    showEditAccountPage(request, response);
			    break;
			case "/accounts/close": // This is a GET to show the form, actual close is PUT
				showCloseAccountForm(request, response);
				break;
			default:
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				break;
			}
		} catch (ResourceNotFoundException e) {
			request.setAttribute("errorMessage", e.getMessage());
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (IllegalArgumentException e) {
			request.setAttribute("errorMessage", "Invalid input: " + e.getMessage());
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (SQLException e) {
			request.setAttribute("errorMessage", "Database error: " + e.getMessage());
			e.printStackTrace();
			request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (Exception e) {
			request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
			e.printStackTrace();
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		System.out.println("DO PUT Request PathInfo: " + pathInfo);

		try {
			switch (pathInfo) {
			case "/accounts/close":
				handleCloseAccount(request, response);
				break;
			// Add other PUT operations here (e.g., updating user profile, account status by
			// admin)
			default:
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				break;
			}
		} catch (ResourceNotFoundException | InsufficientFundsException e) {
			request.setAttribute("errorMessage", e.getMessage());
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (IllegalArgumentException e) {
			request.setAttribute("errorMessage", "Invalid input: " + e.getMessage());
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (SQLException e) {
			request.setAttribute("errorMessage", "Database error: " + e.getMessage());
			e.printStackTrace();
			request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (Exception e) {
			request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
			e.printStackTrace();
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		}
	}

	// --- Authentication & Authorization Handlers ---

	private void handleLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, AuthException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		UserLoginDTO loginDTO = new UserLoginDTO();
		loginDTO.setUsername(username);
		loginDTO.setPassword(password);

		Optional<User> authenticatedUser = authService.authenticate(loginDTO);

		if (authenticatedUser.isPresent()) {
			HttpSession session = request.getSession(true);
			session.setAttribute("loggedInUser", authenticatedUser.get());
			session.setMaxInactiveInterval(30 * 60); // Session timeout 30 minutes
			response.sendRedirect(request.getContextPath() + "/app/dashboard"); // Redirect to dashboard entry point
		} else {
			request.setAttribute("errorMessage", "Invalid username or password.");
			request.getRequestDispatcher("/app/login").forward(request, response);
		}
	}

	private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate(); // Invalidate the session
		}
		response.sendRedirect(request.getContextPath() + "/app/login"); // Redirect to login page
	}

	private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {

		// Check admin authorization
		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		if (loggedInUser == null || loggedInUser.getRole() != UserRole.ADMIN) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
			return;
		}

		try {
			// Get parameters
			String userIdStr = request.getParameter("userId");
			if (userIdStr == null || userIdStr.isEmpty()) {
				throw new IllegalArgumentException("User ID is required.");
			}

			int userId = Integer.parseInt(userIdStr);
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String currentPassword = request.getParameter("currentPassword");
			String newPassword = request.getParameter("newPassword");
			String confirmPassword = request.getParameter("confirmPassword");

			// Let service handle all the business logic and validation
			userService.updateUserWithPasswordValidation(userId, username, email, firstName, lastName, currentPassword,
					newPassword, confirmPassword);

			// Redirect with success message
			response.sendRedirect(request.getContextPath() + "/app/admin/users?message=User updated successfully");

		} catch (IllegalArgumentException e) {
			// Handle validation errors - stay on the form page
			int userId = Integer.parseInt(request.getParameter("userId"));
			UserResponseDTO userResponse = userService.getUserById(userId);

			// Create UserEditDTO from UserResponseDTO
			UserEditDTO userEdit = new UserEditDTO(userResponse);

			// Preserve form data that user entered
			userEdit.setCurrentPassword(request.getParameter("currentPassword"));
			userEdit.setNewPassword(request.getParameter("newPassword"));
			userEdit.setConfirmPassword(request.getParameter("confirmPassword"));

			request.setAttribute("user", userEdit);
			request.setAttribute("errorMessage", e.getMessage());
			request.getRequestDispatcher("/WEB-INF/jsp/admin/user_edit.jsp").forward(request, response);
		}
	}
	
	private void handleProfileUpdate(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException, SQLException, ResourceNotFoundException {
	    HttpSession session = request.getSession(false);
	    User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
	    if (loggedInUser == null || loggedInUser.getRole() != UserRole.CUSTOMER) {
	        response.sendRedirect(request.getContextPath() + "/app/login");
	        return;
	    }

	    String email = request.getParameter("email");
	    String firstName = request.getParameter("firstName");
	    String lastName = request.getParameter("lastName");

	    if (email == null || firstName == null || lastName == null || 
	        email.trim().isEmpty() || firstName.trim().isEmpty() || lastName.trim().isEmpty()) {
	        response.sendRedirect(request.getContextPath() + "/app/customer/profile?message=ProfileError");
	        return;
	    }

	    try {
	        User updatedUser = new User();
	        updatedUser.setUserId(loggedInUser.getUserId());
	        updatedUser.setUsername(loggedInUser.getUsername()); // Keep unchanged
	        updatedUser.setEmail(email);
	        updatedUser.setFirstName(firstName);
	        updatedUser.setLastName(lastName);
	        updatedUser.setCreatedAt(loggedInUser.getCreatedAt());
	        updatedUser.setUpdatedAt(LocalDateTime.now());
	        updatedUser.setRole(loggedInUser.getRole());
	        updatedUser.setStatus(loggedInUser.getStatus());
	        updatedUser.setHolderType(loggedInUser.getHolderType());

	        userService.updateUser(updatedUser);

	        // Refresh the session with the updated user
	        UserResponseDTO updatedDto = userService.getUserById(updatedUser.getUserId());
	        User refreshedUser = convertToUser(updatedDto);
	        session.setAttribute("loggedInUser", refreshedUser);

	        response.sendRedirect(request.getContextPath() + "/app/customer/profile?message=ProfileUpdated");
	    } catch (SQLException e) {
	        e.printStackTrace();
	        response.sendRedirect(request.getContextPath() + "/app/customer/profile?message=ProfileError");
	    } catch (ResourceNotFoundException e) {
	        e.printStackTrace();
	        response.sendRedirect(request.getContextPath() + "/app/customer/profile?message=ProfileError");
	    }
		// TODO Auto-generated method stub
	
}

	// Example converter method
	private User convertToUser(UserResponseDTO dto) {
		User user = new User();
		user.setUserId(dto.getUserId());
		user.setUsername(dto.getUsername());
		user.setEmail(dto.getEmail());
		user.setFirstName(dto.getFirstName());
		user.setLastName(dto.getLastName());
		user.setRole(dto.getRole());

		user.setStatus(dto.getStatus());
		user.setHolderType(dto.getHolderType());
		user.setCreatedAt(dto.getCreatedAt());
		return user;
	}

	private void handleDashboardRedirect(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {
		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

		if (loggedInUser == null) {
			response.sendRedirect(request.getContextPath() + "/app/login");
			return;
		}

		// Check if the user's status is PENDING
		if (loggedInUser.getStatus() == UserStatus.PENDING) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/customer/account_pending.jsp");
			dispatcher.forward(request, response);
			return;
		}

		// Safely fetch latest user data
		UserResponseDTO userResponseDTO = userService.getUserById(loggedInUser.getUserId());

		Optional<User> userOptional;
		if (userResponseDTO != null) {
			User updatedUser = convertToUser(userResponseDTO);
			userOptional = Optional.of(updatedUser);
			session.setAttribute("loggedInUser", updatedUser);

			if (updatedUser.getRole() == UserRole.ADMIN) {
				// Fetch counts for admin dashboard
			    int totalUsers = userService.getTotalUsers();
			    int totalAccounts = accountService.getTotalAccounts();
			    int totalTransactions = transactionService.getTotalTransactions();

			    // Set attributes for JSP
			    request.setAttribute("totalUsers", totalUsers);
			    request.setAttribute("totalAccounts", totalAccounts);
			    request.setAttribute("totalTransactions", totalTransactions);

			    List<UserResponseDTO> allUsers = userService.getAllUsers();
			    request.setAttribute("allUsers", allUsers);
			    request.getRequestDispatcher("/WEB-INF/jsp/admin/dashboard.jsp").forward(request, response);
			} else if (updatedUser.getRole() == UserRole.CUSTOMER) {
				// Customer dashboard requires specific data loading
				List<Account> userAccounts = accountService.getAccountsByUserId(updatedUser.getUserId());
				request.setAttribute("userAccounts", userAccounts);
				request.getRequestDispatcher("/WEB-INF/jsp/customer/dashboard.jsp").forward(request, response);
			} else {
				// Handle other roles or default to unauthorized
				request.setAttribute("errorMessage",
						"Your role (" + updatedUser.getRole().name() + ") does not have an assigned dashboard.");
				request.getRequestDispatcher("/WEB-INF/jsp/unauthorized.jsp").forward(request, response);
			}
		} else {
			userOptional = Optional.empty();
		}

		if (userOptional.isEmpty()) {
			// This means the user record was not found in the database.
			// Invalidate the session as it holds invalid user data and redirect to login.
			if (session != null) {
				session.invalidate();
			}
			request.setAttribute("errorMessage", "Your user account could not be found. Please log in again.");
			request.getRequestDispatcher("/app/login").forward(request, response);
			return; // Important: return after forwarding/redirecting
		}

	}

	// --- Customer Functionality Handlers (GET) ---

	private void showCustomerPaymentsPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {
		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		if (loggedInUser == null) {
			response.sendRedirect(request.getContextPath() + "/app/login");
			return;
		}

		// Fetch accounts for the current user to populate forms
		List<Account> userAccounts = accountService.getAccountsByUserId(loggedInUser.getUserId());
		request.setAttribute("userAccounts", userAccounts);

		request.getRequestDispatcher("/WEB-INF/jsp/customer/payments.jsp").forward(request, response);
	}

	private void showCustomerAccounts(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {
		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		if (loggedInUser == null) {
			response.sendRedirect(request.getContextPath() + "/app/login");
			return;
		}

		// Fetch and set the list of all accounts for the current user
		List<Account> userAccounts = accountService.getAccountsByUserId(loggedInUser.getUserId());
		request.setAttribute("userAccounts", userAccounts);

		// Forward to a new JSP that lists all accounts
		request.getRequestDispatcher("/WEB-INF/jsp/customer/accounts_list.jsp").forward(request, response);
	}

	private void showCustomerAccountDetails(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {
		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		if (loggedInUser == null) {
			response.sendRedirect(request.getContextPath() + "/app/login");
			return;
		}

		String accountIdStr = request.getParameter("id");
		if (accountIdStr == null || accountIdStr.isEmpty()) {
			throw new IllegalArgumentException("Account ID is required to view details.");
		}
		int accountId = Integer.parseInt(accountIdStr);

		Account account = accountService.getAccountById(accountId);
		// Basic authorization: ensure the account belongs to the logged-in user
		if (account.getUserId() != loggedInUser.getUserId() && loggedInUser.getRole() != UserRole.ADMIN) {
			request.setAttribute("errorMessage", "Access Denied: You do not own this account.");
			request.getRequestDispatcher("/WEB-INF/jsp/unauthorized.jsp").forward(request, response);
			return;
		}

		request.setAttribute("account", account);

		List<Transaction> transactions = transactionService.getTransactionsByAccountId(accountId);
		request.setAttribute("transactions", transactions);

		request.getRequestDispatcher("/WEB-INF/jsp/customer/account_details.jsp").forward(request, response);
	}
	
	private void showEditAccountPage(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException, SQLException, ResourceNotFoundException {
	    
	    // Check admin authorization
	    HttpSession session = request.getSession(false);
	    User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
	    if (loggedInUser == null || loggedInUser.getRole() != UserRole.ADMIN) {
	        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
	        return;
	    }

	    String accountIdStr = request.getParameter("accountId");
	    if (accountIdStr == null || accountIdStr.isEmpty()) {
	        throw new IllegalArgumentException("Account ID is required to edit account.");
	    }

	    try {
	        int accountId = Integer.parseInt(accountIdStr);
	        Account account = accountService.getAccountById(accountId);
	        
	        if (account == null) {
	            throw new ResourceNotFoundException("Account not found with ID: " + accountId);
	        }
	        
	        UserResponseDTO userDto = userService.getUserById(account.getUserId());
	        
	        request.setAttribute("account", account);
	        request.setAttribute("user", userDto);
	        request.getRequestDispatcher("/WEB-INF/jsp/admin/account_edit.jsp").forward(request, response);
	        
	    } catch (NumberFormatException e) {
	        throw new IllegalArgumentException("Invalid account ID format: " + accountIdStr);
	    }
	}
	
	// check check
	private void showCustomerProfile(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException, SQLException, ResourceNotFoundException {
	    HttpSession session = request.getSession(false);
	    User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
	    if (loggedInUser == null) {
	        response.sendRedirect(request.getContextPath() + "/app/login");
	        return;
	    }

	    // Fetch the latest user data from the database
	    UserResponseDTO userResponseDTO = userService.getUserById(loggedInUser.getUserId());
	    if (userResponseDTO != null) {
	        User updatedUser = convertToUser(userResponseDTO); // Use the existing convertToUser method
	        session.setAttribute("loggedInUser", updatedUser); // Update session with fresh data
	    }

	    request.getRequestDispatcher("/WEB-INF/jsp/customer/profile.jsp").forward(request, response);
	}
	
	private void handleUpdateAccount(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException, SQLException, ResourceNotFoundException {
	    
	    // Check admin authorization
	    HttpSession session = request.getSession(false);
	    User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
	    if (loggedInUser == null || loggedInUser.getRole() != UserRole.ADMIN) {
	        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
	        return;
	    }

	    try {
	        // Get parameters from the form
	        String accountIdStr = request.getParameter("accountId");
	        if (accountIdStr == null || accountIdStr.isEmpty()) {
	            throw new IllegalArgumentException("Account ID is required.");
	        }

	        int accountId = Integer.parseInt(accountIdStr);
	        String accountTypeStr = request.getParameter("accountType");
	        String balanceStr = request.getParameter("balance");
	        String statusStr = request.getParameter("status");

	        // Validate required fields
	        if (accountTypeStr == null || accountTypeStr.isEmpty()) {
	            throw new IllegalArgumentException("Account type is required.");
	        }
	        if (balanceStr == null || balanceStr.isEmpty()) {
	            throw new IllegalArgumentException("Balance is required.");
	        }
	        if (statusStr == null || statusStr.isEmpty()) {
	            throw new IllegalArgumentException("Status is required.");
	        }

	        // Parse and validate values
	        AccountType accountType = AccountType.valueOf(accountTypeStr);
	        BigDecimal balance = new BigDecimal(balanceStr);
	        AccountStatus status = AccountStatus.valueOf(statusStr);

	        // Validate balance is not negative
	        if (balance.compareTo(BigDecimal.ZERO) < 0) {
	            throw new IllegalArgumentException("Balance cannot be negative.");
	        }

	        // Get the existing account to ensure it exists and preserve other fields
	        Account existingAccount = accountService.getAccountById(accountId);
	        if (existingAccount == null) {
	            throw new ResourceNotFoundException("Account not found with ID: " + accountId);
	        }

	        // Update only the editable fields, preserve others
	        existingAccount.setAccountType(accountType);
	        existingAccount.setBalance(balance);
	        existingAccount.setStatus(status);
	        // Keep original: userId, accountNumber, overdraftLimit, maxTransactionAmount, createdAt

	        // Call existing service method to update account
	        accountService.updateAccount(existingAccount);

	        // Redirect with success message
	        response.sendRedirect(request.getContextPath() + 
	            "/app/admin/accounts?message=Account updated successfully");

	    } catch (IllegalArgumentException e) {
	        // Handle validation errors - stay on the form page
	        String accountIdStr = request.getParameter("accountId");
	        if (accountIdStr != null && !accountIdStr.isEmpty()) {
	            int accountId = Integer.parseInt(accountIdStr);
	            Account account = accountService.getAccountById(accountId);
	            request.setAttribute("account", account);
	        }
	        
	        request.setAttribute("errorMessage", e.getMessage());
	        request.getRequestDispatcher("/WEB-INF/jsp/admin/account_edit.jsp").forward(request, response);
	        
	    }
	}

	private void handleWireTransferPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loggedInUser") == null) {
			response.sendRedirect(request.getContextPath() + "/app/login");
			return;
		}
		User currentUser = (User) session.getAttribute("loggedInUser");

		try {
			List<Account> userAccounts = accountService.getAccountsByUserId(currentUser.getUserId());
			request.setAttribute("userAccounts", userAccounts);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/customer/wire_transfer.jsp");
			dispatcher.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
		}
	}

	private void handleProcessWireTransfer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loggedInUser") == null) {
			response.sendRedirect(request.getContextPath() + "/app/login");
			return;
		}
		User currentUser = (User) session.getAttribute("loggedInUser");

		WireTransferDTO transferDto = new WireTransferDTO();
		transferDto.setUserId(currentUser.getUserId());
		transferDto.setSenderAccountNumber(request.getParameter("senderAccountNumber"));
		transferDto.setRecipientAccountNumber(request.getParameter("recipientAccountNumber"));
		transferDto.setDescription(request.getParameter("description"));
		try {
			transferDto.setAmount(new BigDecimal(request.getParameter("amount")));
		} catch (NumberFormatException e) {
			response.sendRedirect(
					request.getContextPath() + "/app/customer/wire_transfer?error=Invalid amount format.");
			return;
		}

		try {
			wireTransferService.processWireTransfer(transferDto);
			response.sendRedirect(request.getContextPath() + "/app/dashboard?message=WireTransferSuccessful");
		} catch (InvalidTransferException | ResourceNotFoundException e) {
			response.sendRedirect(request.getContextPath() + "/app/customer/wire_transfer?error=" + e.getMessage());
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect(
					request.getContextPath() + "/app/customer/wire_transfer?error=Database error. Please try again.");
		}
	}

	// --- Admin Functionality Handlers (GET) ---

	private void showAdminUserManagementPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// AuthFilter should already handle role check for /admin/* paths
		List<UserResponseDTO> allUsers = userService.getAllUsers();
		request.setAttribute("allUsers", allUsers);
		request.getRequestDispatcher("/WEB-INF/jsp/admin/user_management.jsp").forward(request, response);
	}

	private void showEditUserPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {

		// Check admin authorization
		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		if (loggedInUser == null || loggedInUser.getRole() != UserRole.ADMIN) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
			return;
		}

		String userIdStr = request.getParameter("userId");
		if (userIdStr == null || userIdStr.isEmpty()) {
			throw new IllegalArgumentException("User ID is required to edit user.");
		}

		int userId = Integer.parseInt(userIdStr);
		UserResponseDTO user = userService.getUserById(userId);

		request.setAttribute("user", user);
		request.getRequestDispatcher("/WEB-INF/jsp/admin/user_edit.jsp").forward(request, response);
	}

	private void showAdminAccountManagementPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// AuthFilter should already handle role check for /admin/* paths
		List<Account> allAccounts = accountService.getAllAccounts(); // Assuming a new method in AccountService
		request.setAttribute("allAccounts", allAccounts);
		request.getRequestDispatcher("/WEB-INF/jsp/admin/account_management.jsp").forward(request, response);
	}

	private void handleApproveUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException, IllegalArgumentException {
		// Ensure only an admin can perform this action (redundant with AuthFilter, but
		// good practice)
		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

		if (loggedInUser == null || loggedInUser.getRole() != UserRole.ADMIN) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied. Admins only.");
			return;
		}

		String userIdStr = request.getParameter("userId");
		if (userIdStr == null || userIdStr.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required to approve an account.");
		}

		int userId = Integer.parseInt(userIdStr);
		userService.approveUser(userId);

		// Redirect back to the user management page with a success message
		response.sendRedirect(request.getContextPath() + "/app/admin/users?message=UserApproved");
	}

	// --- Common Account/Transaction Handlers (POST/PUT) ---

	private void showAdminAccountCreatePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {

		// 1. Read the userId parameter from the URL
		String userIdParam = request.getParameter("userId");
		if (userIdParam == null || userIdParam.isEmpty()) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing userId parameter");
			return;
		}

		// 2. Convert it to int
		int userId;
		try {
			userId = Integer.parseInt(userIdParam);
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid userId format");
			return;
		}

		// 3. Fetch the user from the database using the ID
		UserResponseDTO userDTO = userService.getUserById(userId); // <-- Make sure this method exists
		if (userDTO == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
			return;
		}

		// 4. Set the user object in request or session scope
		request.setAttribute("userDTO", userDTO); // or session.setAttribute if needed

		request.getRequestDispatcher("/WEB-INF/jsp/admin/account_create.jsp").forward(request, response);
	}

	private void handleAccountCreation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {
		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

		if (loggedInUser == null || loggedInUser.getRole() != UserRole.ADMIN) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied. Admins only.");
			return;
		}

		String username = request.getParameter("username");
		if (username == null || username.isEmpty()) {
			throw new IllegalArgumentException("Username is missing from the request.");
		}

		UserResponseDTO currentUser = userService.getUserByUsername(username);

		AccountCreationDTO accountDto = new AccountCreationDTO();
		accountDto.setUserId(currentUser.getUserId());

		String accountTypeStr = request.getParameter("accountType");
		if (accountTypeStr != null && !accountTypeStr.isEmpty()) {
			accountDto.setAccountType(AccountType.fromString(accountTypeStr));
		} else {
			throw new IllegalArgumentException("Account type is required.");
		}

		String initialBalanceStr = request.getParameter("initialBalance");
		try {
			accountDto.setInitialBalance(new BigDecimal(initialBalanceStr));
		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("Invalid initial balance format.");
		}

		String overdraftLimitStr = request.getParameter("overdraftLimit");
		accountDto.setOverdraftLimit(
				overdraftLimitStr != null && !overdraftLimitStr.isEmpty() ? new BigDecimal(overdraftLimitStr)
						: BigDecimal.ZERO);

		String maxTransactionAmountStr = request.getParameter("maxTransactionAmount");
		accountDto.setMaxTransactionAmount(maxTransactionAmountStr != null && !maxTransactionAmountStr.isEmpty()
				? new BigDecimal(maxTransactionAmountStr)
				: BigDecimal.ZERO);

		if (accountService.hasAccountOfType(currentUser.getUserId(), accountDto.getAccountType().name())) {
			// Redirect with an error message parameter in the URL.
			response.sendRedirect(request.getContextPath() + "/app/dashboard?error=An account of type "
					+ accountDto.getAccountType().name() + " already exists.");
			throw new IllegalArgumentException("Same Account type already exists.");
		}
		accountService.createAccount(accountDto);
		response.sendRedirect(request.getContextPath() + "/app/admin/users");
	}

	private void handleDeposit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException, InsufficientFundsException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		if (loggedInUser == null) {
			response.sendRedirect(request.getContextPath() + "/app/login");
			return;
		}

		String accountNumber = request.getParameter("accountNumber");
		String amountStr = request.getParameter("amount");

		if (accountNumber == null || accountNumber.trim().isEmpty() || amountStr == null
				|| amountStr.trim().isEmpty()) {
			throw new IllegalArgumentException("Account number and amount are required for deposit.");
		}

		try {
			Account account = accountService.getAccountByAccountNumber(accountNumber);

			// Authorization check
			if (account.getUserId() != loggedInUser.getUserId() && loggedInUser.getRole() != UserRole.ADMIN) {
				throw new IllegalArgumentException("Access Denied: You can only deposit to your own accounts.");
			}

			if (account.getStatus() != AccountStatus.ACTIVE) {
				throw new IllegalArgumentException("Cannot deposit to an inactive account.");
			}

			BigDecimal amount = new BigDecimal(amountStr);
			if (amount.compareTo(BigDecimal.ZERO) <= 0) {
				throw new IllegalArgumentException("Deposit amount must be positive.");
			}

			TransactionDTO transactionDTO = new TransactionDTO();
			transactionDTO.setAccountId(account.getAccountId());
			transactionDTO.setAmount(amount);
			transactionDTO.setDescription(request.getParameter("description"));
			transactionDTO.setType(TransactionType.DEPOSIT);

			transactionService.processDeposit(transactionDTO);
			response.sendRedirect(request.getContextPath() + "/app/dashboard?message=DepositSuccess");
		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("Invalid amount format.");
		}
	}

	private void handleWithdrawal(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException, InsufficientFundsException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		if (loggedInUser == null) {
			response.sendRedirect(request.getContextPath() + "/app/login");
			return;
		}

		String accountNumber = request.getParameter("accountNumber");
		String amountStr = request.getParameter("amount");

		if (accountNumber == null || accountNumber.trim().isEmpty() || amountStr == null
				|| amountStr.trim().isEmpty()) {
			throw new IllegalArgumentException("Account number and amount are required for withdrawal.");
		}

		try {
			Account account = accountService.getAccountByAccountNumber(accountNumber);

			// Authorization check
			if (account.getUserId() != loggedInUser.getUserId() && loggedInUser.getRole() != UserRole.ADMIN) {
				throw new IllegalArgumentException("Access Denied: You can only withdraw from your own accounts.");
			}

			if (account.getStatus() != AccountStatus.ACTIVE) {
				throw new IllegalArgumentException("Cannot withdraw from an inactive account.");
			}

			BigDecimal amount = new BigDecimal(amountStr);
			if (amount.compareTo(BigDecimal.ZERO) <= 0) {
				throw new IllegalArgumentException("Withdrawal amount must be positive.");
			}

			TransactionDTO transactionDTO = new TransactionDTO();
			transactionDTO.setAccountId(account.getAccountId());
			transactionDTO.setAmount(amount);
			transactionDTO.setDescription(request.getParameter("description"));
			transactionDTO.setType(TransactionType.WITHDRAWAL);

			transactionService.processWithdrawal(transactionDTO);
			response.sendRedirect(request.getContextPath() + "/app/dashboard?message=WithdrawalSuccess");
		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("Invalid amount format.");
		}
	}

	private void handleTransfer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException, InsufficientFundsException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		if (loggedInUser == null) {
			response.sendRedirect(request.getContextPath() + "/app/login");
			return;
		}

		String sourceAccountNumber = request.getParameter("sourceAccountNumber");
		String targetAccountNumber = request.getParameter("targetAccountNumber");
		String amountStr = request.getParameter("amount");

		if (sourceAccountNumber == null || sourceAccountNumber.trim().isEmpty() || targetAccountNumber == null
				|| targetAccountNumber.trim().isEmpty() || amountStr == null || amountStr.trim().isEmpty()) {
			throw new IllegalArgumentException(
					"Source account number, target account number, and amount are required for a transfer.");
		}

		try {
			Account sourceAccount = accountService.getAccountByAccountNumber(sourceAccountNumber);
			Account targetAccount = accountService.getAccountByAccountNumber(targetAccountNumber);

			// Authorization check for source account
			if (sourceAccount.getUserId() != loggedInUser.getUserId() && loggedInUser.getRole() != UserRole.ADMIN) {
				throw new IllegalArgumentException("Access Denied: You can only transfer from your own accounts.");
			}

			if (sourceAccount.getStatus() != AccountStatus.ACTIVE) {
				throw new IllegalArgumentException("Cannot transfer from an inactive source account.");
			}
			if (targetAccount.getStatus() != AccountStatus.ACTIVE) {
				throw new IllegalArgumentException("Cannot transfer to an inactive target account.");
			}

			BigDecimal amount = new BigDecimal(amountStr);
			if (amount.compareTo(BigDecimal.ZERO) <= 0) {
				throw new IllegalArgumentException("Transfer amount must be positive.");
			}

			TransactionDTO transactionDTO = new TransactionDTO();
			transactionDTO.setAccountId(sourceAccount.getAccountId()); // This is the source account
			transactionDTO.setTargetAccountId(targetAccount.getAccountId());
			transactionDTO.setAmount(amount);
			transactionDTO.setDescription(request.getParameter("description"));
			transactionDTO.setType(TransactionType.TRANSFER_OUT);

			transactionService.processTransfer(transactionDTO);
			response.sendRedirect(request.getContextPath() + "/app/dashboard?message=TransferSuccess");
		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("Invalid amount format.");
		}
	}

	private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {

		String userIdStr = request.getParameter("userId");
		if (userIdStr == null || userIdStr.isEmpty()) {
			throw new IllegalArgumentException("User ID is required for deletion.");
		}

		int userId = Integer.parseInt(userIdStr);

		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		if (loggedInUser == null || loggedInUser.getRole() != UserRole.ADMIN) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
			return;
		}

		try {
			// Check if user has any accounts first
			List<Account> userAccounts = accountService.getAccountsByUserId(userId);
			if (!userAccounts.isEmpty()) {
				// Use 'error' parameter instead of 'message' to clearly indicate this is an
				// error
				response.sendRedirect(request.getContextPath() + "/app/admin/users?error=Cannot delete user: User has "
						+ userAccounts.size()
						+ " active account(s). Please close all accounts before deleting the user.");
				return;
			}

			// Only delete if no accounts exist
			userService.deleteUser(userId);

			// Redirect back to user management page with success message
			response.sendRedirect(request.getContextPath() + "/app/admin/users?message=User deleted successfully");

		} catch (ResourceNotFoundException e) {
			// User not found
			response.sendRedirect(request.getContextPath() + "/app/admin/users?error=User not found");
		} catch (Exception e) {
			// Any other error during deletion
			response.sendRedirect(
					request.getContextPath() + "/app/admin/users?error=Failed to delete user: " + e.getMessage());
		}
	}

	private void showCloseAccountForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {
		String accountIdStr = request.getParameter("accountId");
		if (accountIdStr != null && !accountIdStr.isEmpty()) {
			int accountId = Integer.parseInt(accountIdStr);
			Account account = accountService.getAccountById(accountId);
			request.setAttribute("account", account);
		}
		request.getRequestDispatcher("/WEB-INF/jsp/close_account.jsp").forward(request, response);
	}

	private void handleCloseAccount(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException, InsufficientFundsException {
		String accountIdStr = request.getParameter("accountId");
		if (accountIdStr == null || accountIdStr.isEmpty()) {
			throw new IllegalArgumentException("Account ID is required to close an account.");
		}
		int accountId = Integer.parseInt(accountIdStr);

		accountService.closeAccount(accountId);
		response.sendRedirect(request.getContextPath() + "/app/dashboard?message=AccountClosed");
	}
}