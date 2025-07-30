package com.mazebank.dao;

import java.sql.SQLException;
import java.util.Optional;

import com.mazebank.model.User;

public interface UserDao extends BaseDao<User> {
    Optional<User> findByUsername(String username) throws SQLException;
}