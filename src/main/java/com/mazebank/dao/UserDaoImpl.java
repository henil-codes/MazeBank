package com.mazebank.dao;

import com.mazebank.model.HolderType;
import com.mazebank.model.User;
import com.mazebank.model.UserRole;
import com.mazebank.model.UserStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.Optional;

public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {

    @Override
    protected String getTableName() {
        return "users";
    }

    @Override
    protected String getIdColumnName() {
        return "user_id"; // Corrected ID column name
    }

    @Override
    protected User mapResultSetToEntity(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password")); // Corrected field name
        user.setEmail(rs.getString("email"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        // Timestamps handled by DB, just read them
        user.setCreatedAt(rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null);
        user.setUpdatedAt(rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null);
        user.setRole(UserRole.fromString(rs.getString("role"))); // Map to enum
        user.setStatus(UserStatus.fromString(rs.getString("status"))); // Map to enum
        user.setHolderType(HolderType.fromString(rs.getString("holder_type"))); // Map to enum
        return user;
    }

    @Override
    protected PreparedStatement prepareStatementForAdd(Connection conn, User user) throws SQLException {
        // Exclude created_at and updated_at as they are handled by DB DEFAULT CURRENT_TIMESTAMP
        String sql = "INSERT INTO users (username, password, email, first_name, last_name, role, status, holder_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setString(1, user.getUsername());
        stmt.setString(2, user.getPassword());
        stmt.setString(3, user.getEmail());
        stmt.setString(4, user.getFirstName());
        stmt.setString(5, user.getLastName());
        stmt.setString(6, user.getRole().name()); // Convert enum to string
        stmt.setString(7, user.getStatus().name()); // Convert enum to string
        stmt.setString(8, user.getHolderType().name()); // Convert enum to string
        return stmt;
    }

    @Override
    protected PreparedStatement prepareStatementForUpdate(Connection conn, User user) throws SQLException {
        // Exclude updated_at as it's handled by DB ON UPDATE CURRENT_TIMESTAMP
        String sql = "UPDATE users SET username = ?, password = ?, email = ?, first_name = ?, last_name = ?, role = ?, status = ?, holder_type = ? WHERE user_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, user.getUsername());
        stmt.setString(2, user.getPassword());
        stmt.setString(3, user.getEmail());
        stmt.setString(4, user.getFirstName());
        stmt.setString(5, user.getLastName());
        stmt.setString(6, user.getRole().name());
        stmt.setString(7, user.getStatus().name());
        stmt.setString(8, user.getHolderType().name());
        stmt.setInt(9, user.getUserId()); // Use userId for WHERE clause
        return stmt;
    }

    @Override
    public Optional<User> findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToEntity(rs));
                }
            }
        }
        return Optional.empty();
    }
    
    @Override
    public void updateUserStatus(int userId, UserStatus newStatus) throws SQLException {
        String sql = "UPDATE Users SET status = ? WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newStatus.name());
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        }
    }
}