package com.mazebank.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.mazebank.util.DBConnection;

public abstract class BaseDaoImpl<T> implements BaseDao<T> {

    protected Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    // Abstract methods to be implemented by concrete DAOs for entity-specific logic
    protected abstract T mapResultSetToEntity(ResultSet rs) throws SQLException;
    protected abstract PreparedStatement prepareStatementForAdd(Connection conn, T entity) throws SQLException;
    protected abstract PreparedStatement prepareStatementForUpdate(Connection conn, T entity) throws SQLException;
    protected abstract String getTableName();
    protected abstract String getIdColumnName();

    
    @Override
    public void add(T entity) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement stmt = prepareStatementForAdd(conn, entity)) {
            stmt.executeUpdate();
            // Important: Retrieve generated keys if your entity needs the auto-generated ID back
            // This assumes the PreparedStatement was created with Statement.RETURN_GENERATED_KEYS
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    // This part needs to be handled by concrete DAOs,
                    // as setting the ID requires knowing the entity type and its setter.
                    // For example: if (entity instanceof User) ((User)entity).setUserId(generatedKeys.getInt(1));
                    // Or, the add method can return the generated ID, and the service layer sets it.
                    // For now, let's assume the service layer will fetch after add if needed.
                }
            }
        }
    }
    
    public void add(T entity, Connection conn) throws SQLException {
        try (PreparedStatement stmt = prepareStatementForAdd(conn, entity)) {
            stmt.executeUpdate();
        }
    }

    @Override
    public Optional<T> getById(int id) throws SQLException {
        String sql = "SELECT * FROM " + getTableName() + " WHERE " + getIdColumnName() + " = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToEntity(rs));
                }
            }
        }
        return Optional.empty();
    }
    
    public Optional<T> getById(int id, Connection conn) throws SQLException {
        String sql = "SELECT * FROM " + getTableName() + " WHERE " + getIdColumnName() + " = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToEntity(rs));
                }
            }
        }
        return Optional.empty();
    }

    @Override
    public List<T> getAll() throws SQLException {
        List<T> entities = new ArrayList<>();
        String sql = "SELECT * FROM " + getTableName();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                entities.add(mapResultSetToEntity(rs));
            }
        }
        return entities;
    }

    @Override
    public void update(T entity) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement stmt = prepareStatementForUpdate(conn, entity)) {
            stmt.executeUpdate();
        }
    }

    @Override
    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM " + getTableName() + " WHERE " + getIdColumnName() + " = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}