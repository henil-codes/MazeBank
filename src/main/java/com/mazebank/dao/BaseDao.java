package com.mazebank.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface BaseDao<T> {
    void add(T entity) throws SQLException;
    Optional<T> getById(int id) throws SQLException;
    List<T> getAll() throws SQLException;
    void update(T entity) throws SQLException;
    void delete(int id) throws SQLException;
}