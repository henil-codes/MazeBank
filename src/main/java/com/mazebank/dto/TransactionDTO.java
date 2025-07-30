package com.mazebank.dto;

import com.mazebank.model.TransactionType;
import java.math.BigDecimal;

public class TransactionDTO {
    private int accountId;
    private TransactionType type; // Changed to enum
    private BigDecimal amount;
    private String description;
    private Integer targetAccountId; // For transfers

    public TransactionDTO() {}

    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }
    public TransactionType getType() { return type; }
    public void setType(TransactionType type) { this.type = type; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Integer getTargetAccountId() { return targetAccountId; }
    public void setTargetAccountId(Integer targetAccountId) { this.targetAccountId = targetAccountId; }
}