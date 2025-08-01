package com.mazebank.dao;

import com.mazebank.model.Transfer;

import java.sql.Connection;
import java.sql.SQLException;

public interface TransferDao extends BaseDao<Transfer> {
    // Add any specific transfer DAO methods if needed, beyond basic CRUD
    void add(Transfer transfer, Connection conn) throws SQLException;
}