package com.mazebank.model;

public enum AccountType {
    CHEQUING,
    SAVINGS,
    CHECKING; // Assuming CHECKING is equivalent to CHEQUING or a distinct type

    public static AccountType fromString(String text) {
        for (AccountType at : AccountType.values()) {
            if (at.name().equalsIgnoreCase(text)) {
                return at;
            }
        }
        throw new IllegalArgumentException("No constant with text " + text + " found in AccountType");
    }
}