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
import com.mazebank.dto.UserResponseDTO;
import com.mazebank.dto.AccountCreationDTO;
import com.mazebank.dto.TransactionDTO;
import com.mazebank.exception.InsufficientFundsException;
import com.mazebank.model.Account;
import com.mazebank.model.AccountType;
import com.mazebank.model.HolderType;
import com.mazebank.model.UserStatus;
import com.mazebank.service.AccountService;
import com.mazebank.service.AccountServiceImpl;
import com.mazebank.service.TransactionService;
import com.mazebank.service.TransactionServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet; // Keep if you use @WebServlet for other servlets
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
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

	@Override
	public void init() throws ServletException {
		super.init();
		authService = new AuthServiceImpl();
		userService = new UserServiceImpl();
		accountService = new AccountServiceImpl();
		transactionService = new TransactionServiceImpl();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		System.out.println("DO POST Request PathInfo: " + pathInfo);

		try {
			// Check for method override (e.g., for PUT/DELETE via POST)
			String methodOverride = request.getParameter("_method");
			if ("PUT".equalsIgnoreCase(methodOverride)) {
				doPut(request, response);
				return;
			}
			// Add other methods (e.g., DELETE) if needed

			switch (pathInfo) {
			case "/login":
				handleLogin(request, response);
				break;
			case "/accounts/create":
				handleAccountCreation(request, response);
				break;
			case "/transactions/deposit":
				handleDeposit(request, response);
				break;
			case "/transactions/withdrawal":
				handleWithdrawal(request, response);
				break;
			case "/transactions/transfer":
				handleTransfer(request, response);
				break;
			// New cases for admin/customer specific POST actions will go here
			default:
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				break;
			}
		} catch (AuthException | ResourceNotFoundException | InsufficientFundsException e) {
			request.setAttribute("errorMessage", e.getMessage());
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (IllegalArgumentException e) {
			request.setAttribute("errorMessage", "Invalid input: " + e.getMessage());
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (SQLException e) {
			request.setAttribute("errorMessage", "Database error: " + e.getMessage());
			e.printStackTrace(); // Log the full stack trace for debugging
			request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
			request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
		} catch (Exception e) {
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
			case "/logout":
				handleLogout(request, response);
				break;
			// Customer-specific GET routes
			case "/customer/payments":
				showCustomerPaymentsPage(request, response);
				break;
			case "/customer/accounts/view":
				showCustomerAccountDetails(request, response);
				break;
			// Admin-specific GET routes
			case "/admin/users":
				showAdminUserManagementPage(request, response);
				break;
			case "/admin/accounts":
				showAdminAccountManagementPage(request, response);
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
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}
	}

	private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate(); // Invalidate the session
		}
		response.sendRedirect(request.getContextPath() + "/index.jsp"); // Redirect to login page
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
			response.sendRedirect(request.getContextPath() + "/index.jsp"); // Not logged in, redirect to login
			return;
		}
		
		// Safely fetch latest user data
		UserResponseDTO userResponseDTO = userService.getUserById(loggedInUser.getUserId());

		Optional<User> userOptional;
		if (userResponseDTO != null) {
		    User updatedUser = convertToUser(userResponseDTO); // You'll need to implement this conversion method
		    userOptional = Optional.of(updatedUser);
		    session.setAttribute("loggedInUser", updatedUser); // Update session with fresh data
		    
			if (updatedUser.getRole() == UserRole.ADMIN) {
				// Admin dashboard requires specific data loading
				List<UserResponseDTO> allUsers = userService.getAllUsers(); // Example data for admin dashboard
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
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return; // Important: return after forwarding/redirecting
        }

	}

	// --- Customer Functionality Handlers (GET) ---

	private void showCustomerPaymentsPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {
		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		if (loggedInUser == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}

		// Fetch accounts for the current user to populate forms
		List<Account> userAccounts = accountService.getAccountsByUserId(loggedInUser.getUserId());
		request.setAttribute("userAccounts", userAccounts);

		request.getRequestDispatcher("/WEB-INF/jsp/customer/payments.jsp").forward(request, response);
	}

	private void showCustomerAccountDetails(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {
		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		if (loggedInUser == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
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
		// Optionally fetch transactions for this account
		// List<Transaction> transactions =
		// transactionService.getTransactionsByAccountId(accountId);
		// request.setAttribute("transactions", transactions);

		request.getRequestDispatcher("/WEB-INF/jsp/customer/account_details.jsp").forward(request, response);
	}

	// --- Admin Functionality Handlers (GET) ---

	private void showAdminUserManagementPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// AuthFilter should already handle role check for /admin/* paths
		List<UserResponseDTO> allUsers = userService.getAllUsers();
		request.setAttribute("allUsers", allUsers);
		request.getRequestDispatcher("/WEB-INF/jsp/admin/user_management.jsp").forward(request, response);
	}

	private void showAdminAccountManagementPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// AuthFilter should already handle role check for /admin/* paths
		List<Account> allAccounts = accountService.getAllAccounts(); // Assuming a new method in AccountService
		request.setAttribute("allAccounts", allAccounts);
		request.getRequestDispatcher("/WEB-INF/jsp/admin/account_management.jsp").forward(request, response);
	}

	// --- Common Account/Transaction Handlers (POST/PUT) ---

	private void handleAccountCreation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loggedInUser") == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
		User currentUser = (User) session.getAttribute("loggedInUser");

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

		accountService.createAccount(accountDto);
		response.sendRedirect(request.getContextPath() + "/app/dashboard?message=AccountCreated");
	}

	private void handleDeposit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException, InsufficientFundsException {
		TransactionDTO transactionDTO = new TransactionDTO();
		transactionDTO.setAccountId(Integer.parseInt(request.getParameter("accountId")));
		transactionDTO.setAmount(new BigDecimal(request.getParameter("amount")));
		transactionDTO.setDescription(request.getParameter("description"));
		transactionDTO.setType(com.mazebank.model.TransactionType.DEPOSIT);

		transactionService.processDeposit(transactionDTO);
		response.sendRedirect(request.getContextPath() + "/app/dashboard?message=DepositSuccess");
	}

	private void handleWithdrawal(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException, InsufficientFundsException {
		TransactionDTO transactionDTO = new TransactionDTO();
		transactionDTO.setAccountId(Integer.parseInt(request.getParameter("accountId")));
		transactionDTO.setAmount(new BigDecimal(request.getParameter("amount")));
		transactionDTO.setDescription(request.getParameter("description"));
		transactionDTO.setType(com.mazebank.model.TransactionType.WITHDRAWAL);

		transactionService.processWithdrawal(transactionDTO);
		response.sendRedirect(request.getContextPath() + "/app/dashboard?message=WithdrawalSuccess");
	}

	private void handleTransfer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ResourceNotFoundException, InsufficientFundsException {
		TransactionDTO transactionDTO = new TransactionDTO();
		transactionDTO.setAccountId(Integer.parseInt(request.getParameter("sourceAccountId")));
		transactionDTO.setTargetAccountId(Integer.parseInt(request.getParameter("targetAccountId")));
		transactionDTO.setAmount(new BigDecimal(request.getParameter("amount")));
		transactionDTO.setDescription(request.getParameter("description"));
		transactionDTO.setType(com.mazebank.model.TransactionType.TRANSFER_OUT);

		transactionService.processTransfer(transactionDTO);
		response.sendRedirect(request.getContextPath() + "/app/dashboard?message=TransferSuccess");
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