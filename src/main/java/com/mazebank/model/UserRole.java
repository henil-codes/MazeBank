package com.mazebank.model;

public enum UserRole {
    CUSTOMER,
    ADMIN;

    public static UserRole fromString(String text) {
        for (UserRole r : UserRole.values()) {
            if (r.name().equalsIgnoreCase(text)) {
                return r;
            }
        }
        throw new IllegalArgumentException("No constant with text " + text + " found in UserRole");
    }
}