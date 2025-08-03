package com.mazebank.service;

import com.mazebank.dao.AccountDao;
import com.mazebank.dao.AccountDaoImpl;
import com.mazebank.dao.LogDao;
import com.mazebank.dao.LogDaoImpl;
import com.mazebank.dao.UserDao;
import com.mazebank.dao.UserDaoImpl;
import com.mazebank.dto.AccountCreationDTO;
import com.mazebank.exception.ResourceNotFoundException;
import com.mazebank.model.Account;
import com.mazebank.model.AccountStatus;
import com.mazebank.model.Log;
import com.mazebank.model.User;
import com.mazebank.util.AccountGenerator;
import com.mazebank.util.DBConnection;
import com.mazebank.util.NumberUtils; // New import

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class AccountServiceImpl implements AccountService {

	private AccountDao accountDao;
	private UserDao userDao; // To verify user existence
	private LogDao logDao; // For logging account creation

	public AccountServiceImpl() {
		this.accountDao = new AccountDaoImpl();
		this.userDao = new UserDaoImpl();
		this.logDao = new LogDaoImpl();
	}

	public AccountServiceImpl(AccountDao accountDao, UserDao userDao, LogDao logDao) {
		this.accountDao = accountDao;
		this.userDao = userDao;
		this.logDao = logDao;
	}

	@Override
	public Account createAccount(AccountCreationDTO accountDto)
			throws SQLException, ResourceNotFoundException, IllegalArgumentException {
		// Validate user exists
		Optional<User> userOptional = userDao.getById(accountDto.getUserId());
		if (userOptional.isEmpty()) {
			throw new ResourceNotFoundException(
					"User not found with ID: " + accountDto.getUserId() + ". Cannot create account.");
		}
		User user = userOptional.get();

		// Business rules for initial balance, overdraft, max transaction
		BigDecimal initialBalance = NumberUtils.scaleBigDecimal(accountDto.getInitialBalance());
		if (initialBalance.compareTo(BigDecimal.ZERO) < 0) {
			throw new IllegalArgumentException("Initial balance cannot be negative.");
		}

		BigDecimal overdraftLimit = NumberUtils.scaleBigDecimal(accountDto.getOverdraftLimit());
		if (overdraftLimit.compareTo(BigDecimal.ZERO) < 0) {
			throw new IllegalArgumentException("Overdraft limit cannot be negative.");
		}

		BigDecimal maxTransactionAmount = NumberUtils.scaleBigDecimal(accountDto.getMaxTransactionAmount());
		if (maxTransactionAmount.compareTo(BigDecimal.ZERO) < 0) {
			throw new IllegalArgumentException("Max transaction amount cannot be negative.");
		}

		Account account = new Account();
		account.setUserId(accountDto.getUserId());
		account.setAccountNumber(AccountGenerator.generateAccountNumber(accountDto.getUserId())); // Generate unique
																									// account number
		account.setAccountType(accountDto.getAccountType());
		account.setBalance(initialBalance);
		account.setOverdraftLimit(overdraftLimit);
		account.setMaxTransactionAmount(maxTransactionAmount);
		account.setStatus(AccountStatus.ACTIVE); // Default status for new accounts
		// created_at and updated_at handled by DB

		Connection conn = null;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false); // Start transaction

			accountDao.add(account);

			// Log account creation
			Log log = new Log();
			log.setUserId(user.getUserId());
			log.setAction("ACCOUNT_CREATE");
			log.setDescription(
					String.format("New %s account created for user %s with initial balance %s. Account Number: %s",
							account.getAccountType().name(), user.getUsername(),
							NumberUtils.formatCurrency(account.getBalance()), account.getAccountNumber()));
			logDao.add(log, conn); // Use the connection within the transaction

			conn.commit();
			return account;
		} catch (SQLException e) {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException rbEx) {
					rbEx.printStackTrace();
				}
			}
			throw e;
		} finally {
			if (conn != null) {
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (SQLException closeEx) {
					closeEx.printStackTrace();
				}
			}
		}
	}

	@Override
	public Account getAccountById(int accountId) throws SQLException, ResourceNotFoundException {
		return accountDao.getById(accountId)
				.orElseThrow(() -> new ResourceNotFoundException("Account not found with ID: " + accountId));
	}

	@Override
	public Account getAccountByAccountNumber(String accountNumber) throws SQLException, ResourceNotFoundException {
		return accountDao.findByAccountNumber(accountNumber)
				.orElseThrow(() -> new ResourceNotFoundException("Account not found with number: " + accountNumber));
	}

	@Override
	public List<Account> getAccountsByUserId(int userId) throws SQLException {
		return accountDao.findAccountsByUserId(userId);
	}

	@Override
	public List<Account> getAllAccounts() throws SQLException {
		return accountDao.getAll(); // Uses the generic getAll from BaseDao
	}

	@Override
	public void updateAccount(Account account) throws SQLException, ResourceNotFoundException {
		Optional<Account> existingAccount = accountDao.getById(account.getAccountId());
		if (existingAccount.isEmpty()) {
			throw new ResourceNotFoundException("Account not found for update with ID: " + account.getAccountId());
		}
		// DB handles updated_at
		accountDao.update(account);
	}

	@Override
	public boolean hasAccountOfType(int userId, String accountType) throws SQLException {
		Connection conn = null;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);

			Log log = new Log();
			log.setUserId(userId);
			log.setAction("ACCOUNT_TYPE_ALREADY_EXIST");
			logDao.add(log, conn);
			return accountDao.hasAccountOfType(userId, accountType, conn);
		}

		catch (SQLException e) {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException rbEx) {
					rbEx.printStackTrace();
				}
			}
			throw e;
		} finally {
			if (conn != null) {
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (SQLException closeEx) {
					closeEx.printStackTrace();
				}
			}
		}
	}

	@Override
	public void closeAccount(int accountId) throws SQLException, ResourceNotFoundException {
		Connection conn = null;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);

			Account account = accountDao.getById(accountId)
					.orElseThrow(() -> new ResourceNotFoundException("Account not found with ID: " + accountId));

			if (account.getStatus() == AccountStatus.CLOSED) {
				throw new IllegalArgumentException("Account is already closed.");
			}

			// Business rule: Account must have zero balance to be closed
			if (account.getBalance().compareTo(BigDecimal.ZERO) != 0) {
				throw new IllegalArgumentException("Account balance must be zero to close account.");
			}

			accountDao.updateAccountBalanceAndStatus(accountId, BigDecimal.ZERO, AccountStatus.CLOSED.name(), conn);

			Log log = new Log();
			log.setUserId(account.getUserId());
			log.setAction("ACCOUNT_CLOSE");
			log.setDescription("Account " + account.getAccountNumber() + " closed.");
			logDao.add(log, conn);

			conn.commit();
		} catch (SQLException e) {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException rbEx) {
					rbEx.printStackTrace();
				}
			}
			throw e;
		} finally {
			if (conn != null) {
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (SQLException closeEx) {
					closeEx.printStackTrace();
				}
			}
		}
	}
}