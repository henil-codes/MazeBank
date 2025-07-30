package com.mazebank.dao;

import com.mazebank.model.Transaction;
import com.mazebank.model.TransactionStatus;
import com.mazebank.model.TransactionType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TransactionDaoImpl extends BaseDaoImpl<Transaction> implements TransactionDao {

    @Override
    protected String getTableName() {
        return "transactions";
    }

    @Override
    protected String getIdColumnName() {
        return "transaction_id";
    }

    @Override
    protected Transaction mapResultSetToEntity(ResultSet rs) throws SQLException {
        Transaction transaction = new Transaction();
        transaction.setTransactionId(rs.getInt("transaction_id"));
        transaction.setAccountId(rs.getInt("account_id"));
        transaction.setType(TransactionType.fromString(rs.getString("type")));
        transaction.setAmount(rs.getBigDecimal("amount"));
        transaction.setTransactionDate(rs.getTimestamp("transaction_date") != null ? rs.getTimestamp("transaction_date").toLocalDateTime() : null);
        transaction.setDescription(rs.getString("description"));
        transaction.setStatus(TransactionStatus.fromString(rs.getString("status")));
        // Read nullable Integer for transfer_id
        int transferId = rs.getInt("transfer_id");
        if (rs.wasNull()) {
            transaction.setTransferId(null);
        } else {
            transaction.setTransferId(transferId);
        }
        return transaction;
    }

    @Override
    protected PreparedStatement prepareStatementForAdd(Connection conn, Transaction transaction) throws SQLException {
        String sql = "INSERT INTO transactions (account_id, type, amount, description, status, transfer_id) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setInt(1, transaction.getAccountId());
        stmt.setString(2, transaction.getType().name());
        stmt.setBigDecimal(3, transaction.getAmount());
        stmt.setString(4, transaction.getDescription());
        stmt.setString(5, transaction.getStatus().name());
        if (transaction.getTransferId() != null) {
            stmt.setInt(6, transaction.getTransferId());
        } else {
            stmt.setNull(6, java.sql.Types.INTEGER);
        }
        return stmt;
    }

    @Override
    protected PreparedStatement prepareStatementForUpdate(Connection conn, Transaction transaction) throws SQLException {
        String sql = "UPDATE transactions SET account_id = ?, type = ?, amount = ?, description = ?, status = ?, transfer_id = ? WHERE transaction_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, transaction.getAccountId());
        stmt.setString(2, transaction.getType().name());
        stmt.setBigDecimal(3, transaction.getAmount());
        stmt.setString(4, transaction.getDescription());
        stmt.setString(5, transaction.getStatus().name());
        if (transaction.getTransferId() != null) {
            stmt.setInt(6, transaction.getTransferId());
        } else {
            stmt.setNull(6, java.sql.Types.INTEGER);
        }
        stmt.setInt(7, transaction.getTransactionId());
        return stmt;
    }

    @Override
    public List<Transaction> findTransactionsByAccountId(int accountId) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM " + getTableName() + " WHERE account_id = ? ORDER BY transaction_date DESC";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, accountId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    transactions.add(mapResultSetToEntity(rs));
                }
            }
        }
        return transactions;
    }
}