package com.mazebank.service;

import com.mazebank.dao.AccountDao;
import com.mazebank.dao.AccountDaoImpl;
import com.mazebank.dao.LogDao;
import com.mazebank.dao.LogDaoImpl;
import com.mazebank.dao.TransactionDao;
import com.mazebank.dao.TransactionDaoImpl;
import com.mazebank.dao.TransferDao;
import com.mazebank.dao.TransferDaoImpl;
import com.mazebank.dto.TransactionDTO;
import com.mazebank.exception.InsufficientFundsException;
import com.mazebank.exception.ResourceNotFoundException;
import com.mazebank.model.Account;
import com.mazebank.model.Log;
import com.mazebank.model.Transaction;
import com.mazebank.model.TransactionStatus;
import com.mazebank.model.TransactionType;
import com.mazebank.model.Transfer;
import com.mazebank.model.TransferStatus;
import com.mazebank.model.AccountStatus; // New Import
import com.mazebank.util.DBConnection;
import com.mazebank.util.NumberUtils;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;

public class TransactionServiceImpl implements TransactionService {

    private AccountDao accountDao;
    private TransactionDao transactionDao;
    private LogDao logDao;
    private TransferDao transferDao;

    public TransactionServiceImpl() {
        this.accountDao = new AccountDaoImpl();
        this.transactionDao = new TransactionDaoImpl();
        this.logDao = new LogDaoImpl();
        this.transferDao = new TransferDaoImpl();
    }

    public TransactionServiceImpl(AccountDao accountDao, TransactionDao transactionDao, LogDao logDao, TransferDao transferDao) {
        this.accountDao = accountDao;
        this.transactionDao = transactionDao;
        this.logDao = logDao;
        this.transferDao = transferDao;
    }

    @Override
    public void processDeposit(TransactionDTO transactionDTO) throws SQLException, ResourceNotFoundException, IllegalArgumentException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            Account account = accountDao.getById(transactionDTO.getAccountId()).orElseThrow(
                () -> new ResourceNotFoundException("Account not found with ID: " + transactionDTO.getAccountId()));

            if (account.getStatus() != AccountStatus.ACTIVE) {
                 throw new IllegalArgumentException("Account is not active and cannot accept deposits.");
            }

            BigDecimal amount = NumberUtils.scaleBigDecimal(transactionDTO.getAmount());
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Deposit amount must be positive.");
            }
            if (amount.compareTo(account.getMaxTransactionAmount()) > 0) {
                throw new IllegalArgumentException("Deposit amount exceeds maximum transaction limit (" + NumberUtils.formatCurrency(account.getMaxTransactionAmount()) + ").");
            }

            BigDecimal newBalance = account.getBalance().add(amount);
            accountDao.updateAccountBalance(account.getAccountId(), newBalance, conn); // Use account.getAccountId()

            // Record transaction
            Transaction transaction = new Transaction();
            transaction.setAccountId(account.getAccountId());
            transaction.setType(TransactionType.DEPOSIT); // Use enum
            transaction.setAmount(amount);
            // transaction_date handled by DB
            transaction.setDescription(transactionDTO.getDescription());
            transaction.setStatus(TransactionStatus.COMPLETED); // Use enum
            transactionDao.add(transaction);

            // Log the action
            Log log = new Log();
            log.setUserId(account.getUserId());
            log.setAction("DEPOSIT");
            log.setDescription(String.format("Deposit of %s to account %s. New balance: %s.",
                                            NumberUtils.formatCurrency(amount), account.getAccountNumber(), NumberUtils.formatCurrency(newBalance)));
            logDao.add(log, conn);

            conn.commit(); // Commit transaction
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback on error
                } catch (SQLException rbEx) {
                    rbEx.printStackTrace(); // Log rollback error
                }
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Reset auto-commit
                    conn.close();
                } catch (SQLException closeEx) {
                    closeEx.printStackTrace(); // Log close error
                }
            }
        }
    }

    @Override
    public void processWithdrawal(TransactionDTO transactionDTO) throws SQLException, ResourceNotFoundException, InsufficientFundsException, IllegalArgumentException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            Account account = accountDao.getById(transactionDTO.getAccountId()).orElseThrow(
                () -> new ResourceNotFoundException("Account not found with ID: " + transactionDTO.getAccountId()));

            if (account.getStatus() != AccountStatus.ACTIVE) {
                 throw new IllegalArgumentException("Account is not active and cannot process withdrawals.");
            }

            BigDecimal amount = NumberUtils.scaleBigDecimal(transactionDTO.getAmount());
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Withdrawal amount must be positive.");
            }
            if (amount.compareTo(account.getMaxTransactionAmount()) > 0) {
                throw new IllegalArgumentException("Withdrawal amount exceeds maximum transaction limit (" + NumberUtils.formatCurrency(account.getMaxTransactionAmount()) + ").");
            }

            BigDecimal availableBalance = account.getBalance().add(account.getOverdraftLimit());
            if (availableBalance.compareTo(amount) < 0) {
                throw new InsufficientFundsException("Insufficient funds. Available: " + NumberUtils.formatCurrency(availableBalance) + ". Requested: " + NumberUtils.formatCurrency(amount) + ".");
            }

            BigDecimal newBalance = account.getBalance().subtract(amount);
            accountDao.updateAccountBalance(account.getAccountId(), newBalance, conn); // Use account.getAccountId()

            // Record transaction
            Transaction transaction = new Transaction();
            transaction.setAccountId(account.getAccountId());
            transaction.setType(TransactionType.WITHDRAWAL); // Use enum
            transaction.setAmount(amount);
            // transaction_date handled by DB
            transaction.setDescription(transactionDTO.getDescription());
            transaction.setStatus(TransactionStatus.COMPLETED); // Use enum
            transactionDao.add(transaction);

            // Log the action
            Log log = new Log();
            log.setUserId(account.getUserId());
            log.setAction("WITHDRAWAL");
            log.setDescription(String.format("Withdrawal of %s from account %s. New balance: %s.",
                                            NumberUtils.formatCurrency(amount), account.getAccountNumber(), NumberUtils.formatCurrency(newBalance)));
            logDao.add(log, conn);

            conn.commit(); // Commit transaction
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
                    conn.setAutoCommit(true); // Reset auto-commit
                    conn.close();
                } catch (SQLException closeEx) {
                    closeEx.printStackTrace();
                }
            }
        }
    }

    @Override
    public void processTransfer(TransactionDTO transactionDTO) throws SQLException, ResourceNotFoundException, InsufficientFundsException, IllegalArgumentException {
        if (transactionDTO.getTargetAccountId() == null) {
            throw new IllegalArgumentException("Target account ID is required for transfers.");
        }
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            Account sourceAccount = accountDao.getById(transactionDTO.getAccountId()).orElseThrow(
                () -> new ResourceNotFoundException("Source account not found with ID: " + transactionDTO.getAccountId()));
            Account targetAccount = accountDao.getById(transactionDTO.getTargetAccountId()).orElseThrow(
                () -> new ResourceNotFoundException("Target account not found with ID: " + transactionDTO.getTargetAccountId()));

            if (sourceAccount.getAccountId() == targetAccount.getAccountId()) {
                throw new IllegalArgumentException("Cannot transfer to the same account.");
            }
            if (sourceAccount.getStatus() != AccountStatus.ACTIVE || targetAccount.getStatus() != AccountStatus.ACTIVE) {
                throw new IllegalArgumentException("Both source and target accounts must be active for a transfer.");
            }

            BigDecimal amount = NumberUtils.scaleBigDecimal(transactionDTO.getAmount());
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Transfer amount must be positive.");
            }
            if (amount.compareTo(sourceAccount.getMaxTransactionAmount()) > 0) {
                throw new IllegalArgumentException("Transfer amount exceeds source account's maximum transaction limit (" + NumberUtils.formatCurrency(sourceAccount.getMaxTransactionAmount()) + ").");
            }
            if (amount.compareTo(targetAccount.getMaxTransactionAmount()) > 0) {
                throw new IllegalArgumentException("Transfer amount exceeds target account's maximum transaction limit (" + NumberUtils.formatCurrency(targetAccount.getMaxTransactionAmount()) + ").");
            }


            BigDecimal sourceAvailableBalance = sourceAccount.getBalance().add(sourceAccount.getOverdraftLimit());
            if (sourceAvailableBalance.compareTo(amount) < 0) {
                throw new InsufficientFundsException("Insufficient funds in source account. Available: " + NumberUtils.formatCurrency(sourceAvailableBalance) + ". Requested: " + NumberUtils.formatCurrency(amount) + ".");
            }

            // Debit source account
            BigDecimal newSourceBalance = sourceAccount.getBalance().subtract(amount);
            accountDao.updateAccountBalance(sourceAccount.getAccountId(), newSourceBalance, conn);

            // Credit target account
            BigDecimal newTargetBalance = targetAccount.getBalance().add(amount);
            accountDao.updateAccountBalance(targetAccount.getAccountId(), newTargetBalance, conn);

            // Record transfer record first to get transfer_id
            Transfer transfer = new Transfer();
            transfer.setSourceAccountId(sourceAccount.getAccountId());
            transfer.setTargetAccountId(targetAccount.getAccountId());
            transfer.setAmount(amount);
            // transfer_date handled by DB
            transfer.setDescription(transactionDTO.getDescription());
            transfer.setStatus(TransferStatus.COMPLETED); // Default to completed immediately for simple transfers
            transferDao.add(transfer); // This will populate transfer.getTransferId() if DAO handles generated keys

            // It's crucial here that transfer.getTransferId() is populated by the add method.
            // If not, you'd need a mechanism to get the last inserted ID.
            // Assuming BaseDaoImpl/TransferDaoImpl's add correctly populates it for auto-increment IDs.

            // Record source transaction
            Transaction sourceTxn = new Transaction();
            sourceTxn.setAccountId(sourceAccount.getAccountId());
            sourceTxn.setType(TransactionType.TRANSFER_OUT);
            sourceTxn.setAmount(amount);
            // transaction_date handled by DB
            sourceTxn.setDescription("Transfer to " + targetAccount.getAccountNumber() + ": " + transactionDTO.getDescription());
            sourceTxn.setStatus(TransactionStatus.COMPLETED);
            sourceTxn.setTransferId(transfer.getTransferId()); // Link to transfer record
            transactionDao.add(sourceTxn);

            // Record target transaction
            Transaction targetTxn = new Transaction();
            targetTxn.setAccountId(targetAccount.getAccountId());
            targetTxn.setType(TransactionType.TRANSFER_IN);
            targetTxn.setAmount(amount);
            // transaction_date handled by DB
            targetTxn.setDescription("Transfer from " + sourceAccount.getAccountNumber() + ": " + transactionDTO.getDescription());
            targetTxn.setStatus(TransactionStatus.COMPLETED);
            targetTxn.setTransferId(transfer.getTransferId()); // Link to transfer record
            transactionDao.add(targetTxn);

            // Log the action
            Log log = new Log();
            log.setUserId(sourceAccount.getUserId()); // Log from source user's perspective
            log.setAction("TRANSFER");
            log.setDescription(String.format("Transfer of %s from account %s (new balance: %s) to account %s (new balance: %s).",
                                NumberUtils.formatCurrency(amount), sourceAccount.getAccountNumber(),
                                NumberUtils.formatCurrency(newSourceBalance), targetAccount.getAccountNumber(),
                                NumberUtils.formatCurrency(newTargetBalance)));
            logDao.add(log, conn);

            conn.commit(); // Commit transaction
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