package com.mazebank.dto;

import com.mazebank.model.HolderType;
import com.mazebank.model.UserRole;
import com.mazebank.model.UserStatus;

import java.time.LocalDateTime;

public class UserResponseDTO {
    private int userId;
    private String username;
    private String email;
    private String firstName;
    private String lastName;
    private UserRole role;
    private UserStatus status;
    private HolderType holderType;
    private LocalDateTime createdAt;

    public UserResponseDTO() {}

    public UserResponseDTO(int userId, String username, String email, String firstName, String lastName,
                           UserRole role, UserStatus status, HolderType holderType, LocalDateTime createdAt) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.role = role;
        this.status = status;
        this.holderType = holderType;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public UserRole getRole() { return role; }
    public void setRole(UserRole role) { this.role = role; }
    public UserStatus getStatus() { return status; }
    public void setStatus(UserStatus status) { this.status = status; }
    public HolderType getHolderType() { return holderType; }
    public void setHolderType(HolderType holderType) { this.holderType = holderType; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}