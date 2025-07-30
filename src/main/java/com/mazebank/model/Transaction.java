package com.mazebank.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Transaction implements Serializable {
	private static final long serialVersionUID = 1L;

    private int transactionId; // Changed from 'id' to 'transactionId'
    private int accountId;
    private TransactionType type; // Changed to enum
    private BigDecimal amount;
    private LocalDateTime transactionDate;
    private String description;
    private TransactionStatus status; // Changed to enum
    private Integer transferId; // Can be null as per SQL

    public Transaction() {
    }

    public Transaction(int transactionId, int accountId, TransactionType type, BigDecimal amount,
                       LocalDateTime transactionDate, String description, TransactionStatus status, Integer transferId) {
        this.transactionId = transactionId;
        this.accountId = accountId;
        this.type = type;
        this.amount = amount;
        this.transactionDate = transactionDate;
        this.description = description;
        this.status = status;
        this.transferId = transferId;
    }

    // Getters and Setters
    public int getTransactionId() { return transactionId; }
    public void setTransactionId(int transactionId) { this.transactionId = transactionId; }
    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }
    public TransactionType getType() { return type; }
    public void setType(TransactionType type) { this.type = type; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public LocalDateTime getTransactionDate() { return transactionDate; }
    public void setTransactionDate(LocalDateTime transactionDate) { this.transactionDate = transactionDate; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public TransactionStatus getStatus() { return status; }
    public void setStatus(TransactionStatus status) { this.status = status; }
    public Integer getTransferId() { return transferId; }
    public void setTransferId(Integer transferId) { this.transferId = transferId; }

    @Override
    public String toString() {
        return "Transaction{" +
               "transactionId=" + transactionId +
               ", accountId=" + accountId +
               ", type=" + type +
               ", amount=" + amount +
               ", transactionDate=" + transactionDate +
               ", description='" + description + '\'' +
               ", status=" + status +
               ", transferId=" + transferId +
               '}';
    }
}