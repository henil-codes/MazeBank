package com.mazebank.dao;

import com.mazebank.model.WireTransfer;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface WireTransferDao {
    WireTransfer save(Connection conn, WireTransfer transfer) throws SQLException;
    Optional<WireTransfer> getById(Connection conn, int id) throws SQLException;
    List<WireTransfer> getTransfersByAccountNumber(Connection conn, String accountNumber) throws SQLException;
}