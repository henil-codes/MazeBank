package com.mazebank.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Log implements Serializable {
	private static final long serialVersionUID = 1L;

    private int logId; // Changed from 'id' to 'logId'
    private Integer userId; // Can be null as per SQL
    private String action;
    private String description;
    private LocalDateTime logTime;

    public Log() {
    }

    public Log(int logId, Integer userId, String action, String description, LocalDateTime logTime) {
        this.logId = logId;
        this.userId = userId;
        this.action = action;
        this.description = description;
        this.logTime = logTime;
    }

    // Getters and Setters
    public int getLogId() { return logId; }
    public void setLogId(int logId) { this.logId = logId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public LocalDateTime getLogTime() { return logTime; }
    public void setLogTime(LocalDateTime logTime) { this.logTime = logTime; }

    @Override
    public String toString() {
        return "Log{" +
               "logId=" + logId +
               ", userId=" + userId +
               ", action='" + action + '\'' +
               ", description='" + description + '\'' +
               ", logTime=" + logTime +
               '}';
    }
}