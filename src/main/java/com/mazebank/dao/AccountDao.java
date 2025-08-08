package com.mazebank.dao;

import com.mazebank.model.Account;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface AccountDao extends BaseDao<Account> {
    List<Account> findAccountsByUserId(int userId) throws SQLException;
    Optional<Account> getById(int id, Connection conn) throws SQLException;
    Optional<Account> findByAccountNumber(String accountNumber) throws SQLException; 
    Optional<Account> findByAccountNumber(String accountNumber, Connection conn) throws SQLException; 
    void updateAccountBalance(int accountId, BigDecimal newBalance, Connection conn) throws SQLException;
    boolean hasAccountOfType(int userId, String accountType, Connection conn) throws SQLException;
    // Method to update account balance and status (e.g., for closing)
    void updateAccountBalanceAndStatus(int accountId, BigDecimal newBalance, String status, Connection conn) throws SQLException;
}