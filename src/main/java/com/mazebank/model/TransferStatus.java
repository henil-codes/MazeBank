package com.mazebank.model;

public enum TransferStatus {
    PENDING,
    COMPLETED,
    FAILED,
    CANCELLED;

    public static TransferStatus fromString(String text) {
        for (TransferStatus ts : TransferStatus.values()) {
            if (ts.name().equalsIgnoreCase(text)) {
                return ts;
            }
        }
        throw new IllegalArgumentException("No constant with text " + text + " found in TransferStatus");
    }
}