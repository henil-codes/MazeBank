package com.mazebank.dto;

import com.mazebank.model.AccountType;
import java.math.BigDecimal;

public class AccountCreationDTO {
    private int userId;
    private AccountType accountType; // Changed to enum
    private BigDecimal initialBalance;
    private BigDecimal overdraftLimit; // New field
    private BigDecimal maxTransactionAmount; // New field

    public AccountCreationDTO() {}

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public AccountType getAccountType() { return accountType; }
    public void setAccountType(AccountType accountType) { this.accountType = accountType; }
    public BigDecimal getInitialBalance() { return initialBalance; }
    public void setInitialBalance(BigDecimal initialBalance) { this.initialBalance = initialBalance; }
    public BigDecimal getOverdraftLimit() { return overdraftLimit; }
    public void setOverdraftLimit(BigDecimal overdraftLimit) { this.overdraftLimit = overdraftLimit; }
    public BigDecimal getMaxTransactionAmount() { return maxTransactionAmount; }
    public void setMaxTransactionAmount(BigDecimal maxTransactionAmount) { this.maxTransactionAmount = maxTransactionAmount; }
}