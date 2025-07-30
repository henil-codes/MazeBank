package com.mazebank.service;

import com.mazebank.dto.UserLoginDTO;
import com.mazebank.exception.AuthException;
import com.mazebank.model.User;
import java.sql.SQLException;
import java.util.Optional;

public interface AuthService {
    Optional<User> authenticate(UserLoginDTO loginDTO) throws SQLException, AuthException;
}