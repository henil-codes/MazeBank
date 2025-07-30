package com.mazebank.dao;

import com.mazebank.model.Transaction;
import java.sql.SQLException;
import java.util.List;

public interface TransactionDao extends BaseDao<Transaction> {
    List<Transaction> findTransactionsByAccountId(int accountId) throws SQLException;
}