package com.mazebank.dao;

import com.mazebank.model.Transfer;
import com.mazebank.model.TransferStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;

public class TransferDaoImpl extends BaseDaoImpl<Transfer> implements TransferDao {

    @Override
    protected String getTableName() {
        return "transfers";
    }

    @Override
    protected String getIdColumnName() {
        return "transfer_id";
    }

    @Override
    protected Transfer mapResultSetToEntity(ResultSet rs) throws SQLException {
        Transfer transfer = new Transfer();
        transfer.setTransferId(rs.getInt("transfer_id"));
        transfer.setSourceAccountId(rs.getInt("source_account_id"));
        transfer.setTargetAccountId(rs.getInt("target_account_id"));
        transfer.setAmount(rs.getBigDecimal("amount"));
        transfer.setTransferDate(rs.getTimestamp("transfer_date") != null ? rs.getTimestamp("transfer_date").toLocalDateTime() : null);
        transfer.setDescription(rs.getString("description"));
        transfer.setStatus(TransferStatus.fromString(rs.getString("status")));
        transfer.setDateApproved(rs.getTimestamp("date_approved") != null ? rs.getTimestamp("date_approved").toLocalDateTime() : null);
        return transfer;
    }

    @Override
    protected PreparedStatement prepareStatementForAdd(Connection conn, Transfer transfer) throws SQLException {
        // transfer_date and date_approved defaults handled by DB, if not explicitly set
        String sql = "INSERT INTO transfers (source_account_id, target_account_id, amount, description, status, date_approved) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setInt(1, transfer.getSourceAccountId());
        stmt.setInt(2, transfer.getTargetAccountId());
        stmt.setBigDecimal(3, transfer.getAmount());
        stmt.setString(4, transfer.getDescription());
        stmt.setString(5, transfer.getStatus().name());
        if (transfer.getDateApproved() != null) {
            stmt.setTimestamp(6, java.sql.Timestamp.valueOf(transfer.getDateApproved()));
        } else {
            stmt.setNull(6, java.sql.Types.TIMESTAMP);
        }
        return stmt;
    }

    @Override
    protected PreparedStatement prepareStatementForUpdate(Connection conn, Transfer transfer) throws SQLException {
        String sql = "UPDATE transfers SET source_account_id = ?, target_account_id = ?, amount = ?, description = ?, status = ?, date_approved = ? WHERE transfer_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, transfer.getSourceAccountId());
        stmt.setInt(2, transfer.getTargetAccountId());
        stmt.setBigDecimal(3, transfer.getAmount());
        stmt.setString(4, transfer.getDescription());
        stmt.setString(5, transfer.getStatus().name());
        if (transfer.getDateApproved() != null) {
            stmt.setTimestamp(6, java.sql.Timestamp.valueOf(transfer.getDateApproved()));
        } else {
            stmt.setNull(6, java.sql.Types.TIMESTAMP);
        }
        stmt.setInt(7, transfer.getTransferId());
        return stmt;
    }
}