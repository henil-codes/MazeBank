package com.mazebank.dao;

import com.mazebank.model.Log;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class LogDaoImpl extends BaseDaoImpl<Log> implements LogDao {

    @Override
    protected String getTableName() {
        return "logs";
    }

    @Override
    protected String getIdColumnName() {
        return "log_id";
    }

    @Override
    protected Log mapResultSetToEntity(ResultSet rs) throws SQLException {
        Log log = new Log();
        log.setLogId(rs.getInt("log_id"));
        // Read nullable Integer for user_id
        int userId = rs.getInt("user_id");
        if (rs.wasNull()) {
            log.setUserId(null);
        } else {
            log.setUserId(userId);
        }
        log.setAction(rs.getString("action"));
        log.setDescription(rs.getString("description"));
        log.setLogTime(rs.getTimestamp("log_time") != null ? rs.getTimestamp("log_time").toLocalDateTime() : null);
        return log;
    }

    @Override
    protected PreparedStatement prepareStatementForAdd(Connection conn, Log log) throws SQLException {
        // log_time handled by DB DEFAULT CURRENT_TIMESTAMP
        String sql = "INSERT INTO logs (user_id, action, description) VALUES (?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        if (log.getUserId() != null) {
            stmt.setInt(1, log.getUserId());
        } else {
            stmt.setNull(1, java.sql.Types.INTEGER);
        }
        stmt.setString(2, log.getAction());
        stmt.setString(3, log.getDescription());
        return stmt;
    }

    // New overloaded add method to support transactions
    @Override
    public void add(Log log, Connection conn) throws SQLException {
        // log_time handled by DB DEFAULT CURRENT_TIMESTAMP
        String sql = "INSERT INTO logs (user_id, action, description) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            if (log.getUserId() != null) {
                stmt.setInt(1, log.getUserId());
            } else {
                stmt.setNull(1, java.sql.Types.INTEGER);
            }
            stmt.setString(2, log.getAction());
            stmt.setString(3, log.getDescription());
            stmt.executeUpdate();
            // You might want to retrieve the generated log_id here and set it back to the Log object
        }
    }


    @Override
    protected PreparedStatement prepareStatementForUpdate(Connection conn, Log log) throws SQLException {
        // Assuming logs are rarely updated, focusing on the basics
        String sql = "UPDATE logs SET user_id = ?, action = ?, description = ? WHERE log_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        if (log.getUserId() != null) {
            stmt.setInt(1, log.getUserId());
        } else {
            stmt.setNull(1, java.sql.Types.INTEGER);
        }
        stmt.setString(2, log.getAction());
        stmt.setString(3, log.getDescription());
        stmt.setInt(4, log.getLogId());
        return stmt;
    }

    @Override
    public List<Log> findLogsByUserId(int userId) throws SQLException {
        List<Log> logs = new ArrayList<>();
        String sql = "SELECT * FROM " + getTableName() + " WHERE user_id = ? ORDER BY log_time DESC";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    logs.add(mapResultSetToEntity(rs));
                }
            }
        }
        return logs;
    }
}