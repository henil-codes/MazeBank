package com.mazebank.model;

public enum TransactionStatus {
    COMPLETED,
    PENDING,
    FAILED;

    public static TransactionStatus fromString(String text) {
        for (TransactionStatus ts : TransactionStatus.values()) {
            if (ts.name().equalsIgnoreCase(text)) {
                return ts;
            }
        }
        throw new IllegalArgumentException("No constant with text " + text + " found in TransactionStatus");
    }
}