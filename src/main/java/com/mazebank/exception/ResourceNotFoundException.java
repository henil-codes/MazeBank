package com.mazebank.exception;

// This exception is thrown when a requested resource (e.g., User, Account) is not found.
public class ResourceNotFoundException extends Exception {
    public ResourceNotFoundException(String message) {
        super(message);
    }

    public ResourceNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
}