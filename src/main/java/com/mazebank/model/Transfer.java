package com.mazebank.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Transfer implements Serializable {
	private static final long serialVersionUID = 1L;

    private int transferId; // Changed from 'id' to 'transferId'
    private int sourceAccountId;
    private int targetAccountId;
    private BigDecimal amount;
    private LocalDateTime transferDate;
    private String description;
    private TransferStatus status; // Changed to enum
    private LocalDateTime dateApproved; // New field, can be null

    public Transfer() {
    }

    public Transfer(int transferId, int sourceAccountId, int targetAccountId, BigDecimal amount,
                    LocalDateTime transferDate, String description, TransferStatus status, LocalDateTime dateApproved) {
        this.transferId = transferId;
        this.sourceAccountId = sourceAccountId;
        this.targetAccountId = targetAccountId;
        this.amount = amount;
        this.transferDate = transferDate;
        this.description = description;
        this.status = status;
        this.dateApproved = dateApproved;
    }

    // Getters and Setters
    public int getTransferId() { return transferId; }
    public void setTransferId(int transferId) { this.transferId = transferId; }
    public int getSourceAccountId() { return sourceAccountId; }
    public void setSourceAccountId(int sourceAccountId) { this.sourceAccountId = sourceAccountId; }
    public int getTargetAccountId() { return targetAccountId; }
    public void setTargetAccountId(int targetAccountId) { this.targetAccountId = targetAccountId; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public LocalDateTime getTransferDate() { return transferDate; }
    public void setTransferDate(LocalDateTime transferDate) { this.transferDate = transferDate; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public TransferStatus getStatus() { return status; }
    public void setStatus(TransferStatus status) { this.status = status; }
    public LocalDateTime getDateApproved() { return dateApproved; }
    public void setDateApproved(LocalDateTime dateApproved) { this.dateApproved = dateApproved; }

    @Override
    public String toString() {
        return "Transfer{" +
               "transferId=" + transferId +
               ", sourceAccountId=" + sourceAccountId +
               ", targetAccountId=" + targetAccountId +
               ", amount=" + amount +
               ", transferDate=" + transferDate +
               ", description='" + description + '\'' +
               ", status=" + status +
               ", dateApproved=" + dateApproved +
               '}';
    }
}