package com.mazebank.service;

import com.mazebank.dto.UserResponseDTO;
import com.mazebank.exception.ResourceNotFoundException;
import com.mazebank.model.User;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface UserService {
	User registerUser(User user) throws SQLException; // Returns the registered user

	UserResponseDTO getUserById(int userId) throws SQLException, ResourceNotFoundException;

	UserResponseDTO getUserByUsername(String username) throws SQLException, ResourceNotFoundException;

	List<UserResponseDTO> getAllUsers() throws SQLException;

	void updateUser(User user) throws SQLException, ResourceNotFoundException;

	void deleteUser(int userId) throws SQLException, ResourceNotFoundException;

	void approveUser(int userId) throws SQLException, ResourceNotFoundException;

	boolean verifyCurrentPassword(int userId, String currentPassword) throws SQLException, ResourceNotFoundException;

	void updateUserWithPasswordValidation(int userId, String username, String email, String firstName, String lastName,
			String currentPassword, String newPassword, String confirmPassword)
			throws SQLException, ResourceNotFoundException, IllegalArgumentException;
}