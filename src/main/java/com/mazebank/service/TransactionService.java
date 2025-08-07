package com.mazebank.service;

import com.mazebank.dto.TransactionDTO;
import com.mazebank.exception.InsufficientFundsException;
import com.mazebank.exception.ResourceNotFoundException;
import com.mazebank.model.Transaction;

import java.sql.SQLException;
import java.util.List;

public interface TransactionService {
    void processDeposit(TransactionDTO transactionDTO) throws SQLException, ResourceNotFoundException, IllegalArgumentException;
    void processWithdrawal(TransactionDTO transactionDTO) throws SQLException, ResourceNotFoundException, InsufficientFundsException, IllegalArgumentException;
    void processTransfer(TransactionDTO transactionDTO) throws SQLException, ResourceNotFoundException, InsufficientFundsException, IllegalArgumentException;
    List<Transaction> getTransactionsByAccountId(int accountId) throws SQLException, ResourceNotFoundException;
}