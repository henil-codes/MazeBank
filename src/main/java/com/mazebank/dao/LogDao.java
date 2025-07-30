package com.mazebank.dao;

import com.mazebank.model.Log;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public interface LogDao extends BaseDao<Log> {
    List<Log> findLogsByUserId(int userId) throws SQLException;
    // Add specific add method that can take an existing connection for transaction context
    void add(Log log, Connection conn) throws SQLException;
}