package com.mazebank.model;

public enum UserStatus {
    PENDING,
    APPROVED,
    REJECTED,
    ACTIVE,
    INACTIVE;

    public static UserStatus fromString(String text) {
        for (UserStatus s : UserStatus.values()) {
            if (s.name().equalsIgnoreCase(text)) {
                return s;
            }
        }
        throw new IllegalArgumentException("No constant with text " + text + " found in UserStatus");
    }
}