package com.mazebank.model;

public enum AccountStatus {
    ACTIVE,
    INACTIVE,
    CLOSED;

    public static AccountStatus fromString(String text) {
        for (AccountStatus as : AccountStatus.values()) {
            if (as.name().equalsIgnoreCase(text)) {
                return as;
            }
        }
        throw new IllegalArgumentException("No constant with text " + text + " found in AccountStatus");
    }
}