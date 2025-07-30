package com.mazebank.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Account implements Serializable {
	private static final long serialVersionUID = 1L;

    private int accountId; // Changed from 'id' to 'accountId'
    private int userId;
    private String accountNumber;
    private AccountType accountType; // Changed to enum
    private BigDecimal balance;
    private BigDecimal overdraftLimit; // New field
    private BigDecimal maxTransactionAmount; // New field
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private AccountStatus status; // Changed to enum

    public Account() {
    }

    public Account(int accountId, int userId, String accountNumber, AccountType accountType, BigDecimal balance,
                   BigDecimal overdraftLimit, BigDecimal maxTransactionAmount, LocalDateTime createdAt,
                   LocalDateTime updatedAt, AccountStatus status) {
        this.accountId = accountId;
        this.userId = userId;
        this.accountNumber = accountNumber;
        this.accountType = accountType;
        this.balance = balance;
        this.overdraftLimit = overdraftLimit;
        this.maxTransactionAmount = maxTransactionAmount;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.status = status;
    }

    // Getters and Setters
    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }
    public AccountType getAccountType() { return accountType; }
    public void setAccountType(AccountType accountType) { this.accountType = accountType; }
    public BigDecimal getBalance() { return balance; }
    public void setBalance(BigDecimal balance) { this.balance = balance; }
    public BigDecimal getOverdraftLimit() { return overdraftLimit; }
    public void setOverdraftLimit(BigDecimal overdraftLimit) { this.overdraftLimit = overdraftLimit; }
    public BigDecimal getMaxTransactionAmount() { return maxTransactionAmount; }
    public void setMaxTransactionAmount(BigDecimal maxTransactionAmount) { this.maxTransactionAmount = maxTransactionAmount; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    public AccountStatus getStatus() { return status; }
    public void setStatus(AccountStatus status) { this.status = status; }

    @Override
    public String toString() {
        return "Account{" +
               "accountId=" + accountId +
               ", userId=" + userId +
               ", accountNumber='" + accountNumber + '\'' +
               ", accountType=" + accountType +
               ", balance=" + balance +
               ", overdraftLimit=" + overdraftLimit +
               ", maxTransactionAmount=" + maxTransactionAmount +
               ", createdAt=" + createdAt +
               ", updatedAt=" + updatedAt +
               ", status=" + status +
               '}';
    }
}