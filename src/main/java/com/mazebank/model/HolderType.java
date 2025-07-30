package com.mazebank.model;

public enum HolderType {
    PERSONAL,
    BUSINESS,
    STUDENT;

    public static HolderType fromString(String text) {
        for (HolderType ht : HolderType.values()) {
            if (ht.name().equalsIgnoreCase(text)) {
                return ht;
            }
        }
        throw new IllegalArgumentException("No constant with text " + text + " found in HolderType");
    }
}