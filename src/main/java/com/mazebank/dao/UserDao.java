package com.mazebank.dao;

import java.sql.SQLException;
import java.util.Optional;

import com.mazebank.model.User;
import com.mazebank.model.UserStatus;

public interface UserDao extends BaseDao<User> {
    Optional<User> findByUsername(String username) throws SQLException;
    void updateUserStatus(int userId, UserStatus newStatus) throws SQLException;
}