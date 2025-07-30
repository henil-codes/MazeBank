package com.mazebank.service;

import com.mazebank.dto.TransactionDTO;
import com.mazebank.exception.InsufficientFundsException;
import com.mazebank.exception.ResourceNotFoundException;
import java.sql.SQLException;

public interface TransactionService {
    void processDeposit(TransactionDTO transactionDTO) throws SQLException, ResourceNotFoundException, IllegalArgumentException;
    void processWithdrawal(TransactionDTO transactionDTO) throws SQLException, ResourceNotFoundException, InsufficientFundsException, IllegalArgumentException;
    void processTransfer(TransactionDTO transactionDTO) throws SQLException, ResourceNotFoundException, InsufficientFundsException, IllegalArgumentException;
}