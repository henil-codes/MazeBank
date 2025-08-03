package com.mazebank.service;

import com.mazebank.dto.AccountCreationDTO;
import com.mazebank.exception.ResourceNotFoundException;
import com.mazebank.model.Account;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface AccountService {
    Account createAccount(AccountCreationDTO accountDto) throws SQLException, ResourceNotFoundException, IllegalArgumentException;
    Account getAccountById(int accountId) throws SQLException, ResourceNotFoundException;
    Account getAccountByAccountNumber(String accountNumber) throws SQLException, ResourceNotFoundException;
    List<Account> getAccountsByUserId(int userId) throws SQLException;
    List<Account> getAllAccounts() throws SQLException; // New method for admin view
    void updateAccount(Account account) throws SQLException, ResourceNotFoundException;
    void closeAccount(int accountId) throws SQLException, ResourceNotFoundException;
    boolean hasAccountOfType(int userId, String accountType) throws SQLException; // Updated method
}