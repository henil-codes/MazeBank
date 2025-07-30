package com.mazebank.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class User implements Serializable {
	private static final long serialVersionUID = 1L;

    private int userId; // Changed from 'id' to 'userId'
    private String username;
    private String password; // Changed from 'passwordHash' to 'password' as per SQL
    private String email;
    private String firstName;
    private String lastName;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private UserRole role; // Changed to enum
    private UserStatus status; // New enum field
    private HolderType holderType; // New enum field

    public User() {
    }

    // Full constructor (consider omitting password for DTOs)
    public User(int userId, String username, String password, String email, String firstName, String lastName,
                LocalDateTime createdAt, LocalDateTime updatedAt, UserRole role, UserStatus status, HolderType holderType) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.role = role;
        this.status = status;
        this.holderType = holderType;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    public UserRole getRole() { return role; }
    public void setRole(UserRole role) { this.role = role; }
    public UserStatus getStatus() { return status; }
    public void setStatus(UserStatus status) { this.status = status; }
    public HolderType getHolderType() { return holderType; }
    public void setHolderType(HolderType holderType) { this.holderType = holderType; }

    @Override
    public String toString() {
        return "User{" +
               "userId=" + userId +
               ", username='" + username + '\'' +
               ", email='" + email + '\'' + 
               ", firstName='" + firstName + '\'' +
               ", lastName='" + lastName + '\'' +
               ", createdAt=" + createdAt +
               ", updatedAt=" + updatedAt +
               ", role=" + role +
               ", status=" + status +
               ", holderType=" + holderType +
               '}';
    }
}