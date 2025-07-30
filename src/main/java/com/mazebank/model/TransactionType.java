package com.mazebank.model;

public enum TransactionType {
    DEBIT,
    CREDIT,
    FEE,
    INTEREST,
    DEPOSIT,
    WITHDRAWAL,
    TRANSFER_IN,
    TRANSFER_OUT;

    public static TransactionType fromString(String text) {
        for (TransactionType tt : TransactionType.values()) {
            if (tt.name().equalsIgnoreCase(text)) {
                return tt;
            }
        }
        throw new IllegalArgumentException("No constant with text " + text + " found in TransactionType");
    }
}