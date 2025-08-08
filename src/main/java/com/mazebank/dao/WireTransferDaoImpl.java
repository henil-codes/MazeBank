package com.mazebank.dao;

import com.mazebank.model.WireTransfer;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class WireTransferDaoImpl implements WireTransferDao {

    @Override
    public WireTransfer save(Connection conn, WireTransfer transfer) throws SQLException {
        String sql = "INSERT INTO wire_transfers (sender_account_id, recipient_account_id, sender_account_number, recipient_account_number, amount, description, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, transfer.getSenderAccountId());
            stmt.setInt(2, transfer.getRecipientAccountId());
            stmt.setString(3, transfer.getSenderAccountNumber());
            stmt.setString(4, transfer.getRecipientAccountNumber());
            stmt.setBigDecimal(5, transfer.getAmount());
            stmt.setString(6, transfer.getDescription());
            stmt.setString(7, transfer.getStatus());
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    transfer.setTransferId(rs.getInt(1));
                    transfer.setCreatedAt(LocalDateTime.now()); // Set creation timestamp
                }
            }
        }
        return transfer;
    }
    
    // You can implement other methods here if needed, for now we will just use the save method.
    @Override
    public Optional<WireTransfer> getById(Connection conn, int id) throws SQLException {
        // Not required for this implementation, but good practice to include
        return Optional.empty();
    }
    
    @Override
    public List<WireTransfer> getTransfersByAccountNumber(Connection conn, String accountNumber) throws SQLException {
        // Not required for this implementation, but good practice to include
        return new ArrayList<>();
    }
}