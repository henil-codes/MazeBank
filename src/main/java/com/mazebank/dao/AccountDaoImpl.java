package com.mazebank.dao;

import com.mazebank.model.Account;
import com.mazebank.model.AccountStatus;
import com.mazebank.model.AccountType;
import com.mazebank.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class AccountDaoImpl extends BaseDaoImpl<Account> implements AccountDao {

    @Override
    protected String getTableName() {
        return "accounts";
    }

    @Override
    protected String getIdColumnName() {
        return "account_id"; // Corrected ID column name
    }

    @Override
    protected Account mapResultSetToEntity(ResultSet rs) throws SQLException {
        Account account = new Account();
        account.setAccountId(rs.getInt("account_id"));
        account.setUserId(rs.getInt("user_id"));
        account.setAccountNumber(rs.getString("account_number"));
        account.setAccountType(AccountType.fromString(rs.getString("account_type"))); // Map to enum
        account.setBalance(rs.getBigDecimal("balance"));
        account.setOverdraftLimit(rs.getBigDecimal("overdraft_limit")); // New field
        account.setMaxTransactionAmount(rs.getBigDecimal("max_transaction_amount")); // New field
        account.setCreatedAt(rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null);
        account.setUpdatedAt(rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null);
        account.setStatus(AccountStatus.fromString(rs.getString("status"))); // Map to enum
        return account;
    }

    @Override
    protected PreparedStatement prepareStatementForAdd(Connection conn, Account account) throws SQLException {
        String sql = "INSERT INTO accounts (user_id, account_number, account_type, balance, overdraft_limit, max_transaction_amount, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setInt(1, account.getUserId());
        stmt.setString(2, account.getAccountNumber());
        stmt.setString(3, account.getAccountType().name()); // Convert enum to string
        stmt.setBigDecimal(4, account.getBalance());
        stmt.setBigDecimal(5, account.getOverdraftLimit());
        stmt.setBigDecimal(6, account.getMaxTransactionAmount());
        stmt.setString(7, account.getStatus().name()); // Convert enum to string
        return stmt;
    }

    @Override
    protected PreparedStatement prepareStatementForUpdate(Connection conn, Account account) throws SQLException {
        String sql = "UPDATE accounts SET user_id = ?, account_number = ?, account_type = ?, balance = ?, overdraft_limit = ?, max_transaction_amount = ?, status = ? WHERE account_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, account.getUserId());
        stmt.setString(2, account.getAccountNumber());
        stmt.setString(3, account.getAccountType().name());
        stmt.setBigDecimal(4, account.getBalance());
        stmt.setBigDecimal(5, account.getOverdraftLimit());
        stmt.setBigDecimal(6, account.getMaxTransactionAmount());
        stmt.setString(7, account.getStatus().name());
        stmt.setInt(8, account.getAccountId()); // Use accountId for WHERE clause
        return stmt;
    }

    @Override
    public List<Account> findAccountsByUserId(int userId) throws SQLException {
        List<Account> accounts = new ArrayList<>();
        String sql = "SELECT * FROM " + getTableName() + " WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    accounts.add(mapResultSetToEntity(rs));
                }
            }
        }
        return accounts;
    }

    @Override
    public Optional<Account> findByAccountNumber(String accountNumber) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            return findByAccountNumber(accountNumber, conn);
        }
    }

    @Override
    public Optional<Account> findByAccountNumber(String accountNumber, Connection conn) throws SQLException {
        String sql = "SELECT * FROM " + getTableName() + " WHERE account_number = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, accountNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToEntity(rs));
                }
            }
        }
        return Optional.empty();
    }
    
    @Override
    public boolean hasAccountOfType(int userId, String accountType, Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Accounts WHERE user_id = ? AND account_type = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, accountType);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    @Override
    public void updateAccountBalance(int accountId, BigDecimal newBalance, Connection conn) throws SQLException {
        String sql = "UPDATE " + getTableName() + " SET balance = ?, updated_at = CURRENT_TIMESTAMP WHERE account_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBigDecimal(1, newBalance);
            stmt.setInt(2, accountId);
            stmt.executeUpdate();
        }
    }

    @Override
    public void updateAccountBalanceAndStatus(int accountId, BigDecimal newBalance, String status, Connection conn) throws SQLException {
        String sql = "UPDATE " + getTableName() + " SET balance = ?, status = ?, updated_at = CURRENT_TIMESTAMP WHERE account_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBigDecimal(1, newBalance);
            stmt.setString(2, status);
            stmt.setInt(3, accountId);
            stmt.executeUpdate();
        }
    }
}