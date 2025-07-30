package com.mazebank.service;

import com.mazebank.dao.UserDao;
import com.mazebank.dao.UserDaoImpl;
import com.mazebank.dto.UserLoginDTO;
import com.mazebank.exception.AuthException;
import com.mazebank.model.User;
import com.mazebank.util.PasswordUtil;
import java.sql.SQLException;
import java.util.Optional;

public class AuthServiceImpl implements AuthService {

    private UserDao userDao;

    public AuthServiceImpl() {
        this.userDao = new UserDaoImpl();
    }

    public AuthServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public Optional<User> authenticate(UserLoginDTO loginDTO) throws SQLException, AuthException {
        if (loginDTO == null || loginDTO.getUsername() == null || loginDTO.getPassword() == null ||
            loginDTO.getUsername().trim().isEmpty() || loginDTO.getPassword().trim().isEmpty()) {
            throw new AuthException("Username and password cannot be empty.");
        }

        Optional<User> userOptional = userDao.findByUsername(loginDTO.getUsername());

        if (userOptional.isEmpty()) {
            throw new AuthException("Invalid username or password."); // Generic message for security
        }

        User user = userOptional.get();
        String storedHashedPassword = user.getPassword(); // This is the BCrypt hash

        // Verify password using BCrypt
        boolean isPasswordValid = PasswordUtil.verifyPassword(loginDTO.getPassword(), storedHashedPassword);

        if (isPasswordValid) {
            return Optional.of(user);
        } else {
            throw new AuthException("Invalid username or password."); // Generic message for security
        }
    }
}