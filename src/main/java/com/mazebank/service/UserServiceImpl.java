package com.mazebank.service;

import com.mazebank.dao.UserDao;
import com.mazebank.dao.UserDaoImpl;
import com.mazebank.dto.UserResponseDTO;
import com.mazebank.exception.ResourceNotFoundException;
import com.mazebank.model.HolderType;
import com.mazebank.model.User;
import com.mazebank.model.UserRole;
import com.mazebank.model.UserStatus;
import com.mazebank.util.DBConnection;
import com.mazebank.util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.stream.Collectors;

public class UserServiceImpl implements UserService {
	private DataSource dataSource;
	private UserDao userDao;

	public void UserDAO(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public UserServiceImpl() {
		this.userDao = new UserDaoImpl();
	}

	public UserServiceImpl(UserDao userDao) {
		this.userDao = userDao;
	}

	@Override
	public User registerUser(User user) throws SQLException {
		// Business logic: Hash password before storing
		String hashedPassword = PasswordUtil.hashPassword(user.getPassword()); // Hash plain password
		user.setPassword(hashedPassword); // Store the BCrypt hash

		// Set default values if not provided by DTO/form
		if (user.getRole() == null) {
			user.setRole(UserRole.CUSTOMER);
		}
		if (user.getStatus() == null) {
			user.setStatus(UserStatus.PENDING); // Default status for new registrations
		}
		if (user.getHolderType() == null) {
			user.setHolderType(HolderType.PERSONAL); // Default holder type
		}

		userDao.add(user); // Add will set auto-generated ID to user object (if BaseDaoImpl supported it)
							// Or, you'd need to re-fetch to get the full object with DB-generated fields.
							// For now, let's assume `add` operation will update the ID in the passed object
							// if Statement.RETURN_GENERATED_KEYS is properly handled in BaseDaoImpl and
							// specific DAO.
							// For this setup, we'll return the object as is, or fetch it if ID is critical
							// after add.
							// Let's modify BaseDaoImpl add method to try to set ID if entity has a setter.
		return user;
	}

	@Override
	public UserResponseDTO getUserById(int userId) throws SQLException, ResourceNotFoundException {
		Optional<User> userOptional = userDao.getById(userId);
		User user = userOptional.orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + userId));
		return mapUserToUserResponseDTO(user);
	}

	public int getTotalUsers() {
		try (Connection conn = DBConnection.getConnection()) {
			String sql = "SELECT COUNT(*) FROM users";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (SQLException e) {
			throw new RuntimeException("Database error while counting users", e);
		}
	}

	@Override
	public UserResponseDTO getUserByUsername(String username) throws SQLException, ResourceNotFoundException {
		Optional<User> userOptional = userDao.findByUsername(username);
		User user = userOptional
				.orElseThrow(() -> new ResourceNotFoundException("User not found with username: " + username));
		return mapUserToUserResponseDTO(user);
	}

	@Override
	public List<UserResponseDTO> getAllUsers() throws SQLException {
		return userDao.getAll().stream().map(this::mapUserToUserResponseDTO).collect(Collectors.toList());
	}

	@Override
	public void updateUser(User user) throws SQLException, ResourceNotFoundException {
		Optional<User> existingUser = userDao.getById(user.getUserId());
		if (!existingUser.isPresent()) {
			throw new ResourceNotFoundException("User not found for update with ID: " + user.getUserId());
		}

		// Only update password if it's explicitly provided (non-null and non-empty)
		if (user.getPassword() != null && !user.getPassword().isEmpty()) {
			String newHashedPassword = PasswordUtil.hashPassword(user.getPassword());
			user.setPassword(newHashedPassword);
		} else {
			// Retain old password hash if new password is not provided
			user.setPassword(existingUser.get().getPassword());
		}
		// DB handles updated_at
		userDao.update(user);
	}

	@Override
	public void deleteUser(int userId) throws SQLException, ResourceNotFoundException {
		Optional<User> existingUser = userDao.getById(userId);
		if (!existingUser.isPresent()) {
			throw new ResourceNotFoundException("User not found for deletion with ID: " + userId);
		}
		userDao.delete(userId);
	}

	@Override
	public void approveUser(int userId) throws SQLException, ResourceNotFoundException {
		Optional<User> userOptional = userDao.getById(userId);
		if (userOptional.isEmpty()) {
			throw new ResourceNotFoundException("User with ID " + userId + " not found.");
		}
		userDao.updateUserStatus(userId, UserStatus.ACTIVE);
	}

	// Add these methods to your UserServiceImpl class

	@Override
	public boolean verifyCurrentPassword(int userId, String currentPassword)
			throws SQLException, ResourceNotFoundException {
		Optional<User> userOptional = userDao.getById(userId);
		if (userOptional.isEmpty()) {
			throw new ResourceNotFoundException("User not found.");
		}

		User user = userOptional.get();
		return PasswordUtil.verifyPassword(currentPassword, user.getPassword());
	}

	@Override
	public void updateUserWithPasswordValidation(int userId, String username, String email, String firstName,
			String lastName, String currentPassword, String newPassword, String confirmPassword)
			throws SQLException, ResourceNotFoundException, IllegalArgumentException {

		// Input validation
		if (username == null || username.trim().isEmpty()) {
			throw new IllegalArgumentException("Username is required.");
		}
		if (email == null || email.trim().isEmpty()) {
			throw new IllegalArgumentException("Email is required.");
		}
		if (firstName == null || firstName.trim().isEmpty()) {
			throw new IllegalArgumentException("First name is required.");
		}
		if (lastName == null || lastName.trim().isEmpty()) {
			throw new IllegalArgumentException("Last name is required.");
		}

		// Get existing user to preserve other fields
		UserResponseDTO existingUserDTO = getUserById(userId);

		// Create User object for update
		User userToUpdate = new User();
		userToUpdate.setUserId(userId);
		userToUpdate.setUsername(username.trim());
		userToUpdate.setEmail(email.trim());
		userToUpdate.setFirstName(firstName.trim());
		userToUpdate.setLastName(lastName.trim());

		// Preserve existing fields that shouldn't be changed
		userToUpdate.setRole(existingUserDTO.getRole());
		userToUpdate.setStatus(existingUserDTO.getStatus());
		userToUpdate.setHolderType(existingUserDTO.getHolderType());

		// Handle password update if provided
		if (newPassword != null && !newPassword.trim().isEmpty()) {
			if (currentPassword == null || currentPassword.trim().isEmpty()) {
				throw new IllegalArgumentException("Current password is required to set a new password.");
			}

			if (!newPassword.equals(confirmPassword)) {
				throw new IllegalArgumentException("New password and confirmation password do not match.");
			}

			if (newPassword.length() < 6) {
				throw new IllegalArgumentException("New password must be at least 6 characters long.");
			}

			// Verify current password
			if (!verifyCurrentPassword(userId, currentPassword)) {
				throw new IllegalArgumentException("Current password is incorrect.");
			}

			// Set new password (will be hashed in updateUser method)
			userToUpdate.setPassword(newPassword);
		} else {
			// Don't change password if not provided
			userToUpdate.setPassword(null);
		}

		// Update user
		updateUser(userToUpdate);
	}

	private UserResponseDTO mapUserToUserResponseDTO(User user) {
		UserResponseDTO dto = new UserResponseDTO();
		dto.setUserId(user.getUserId());
		dto.setUsername(user.getUsername());
		dto.setEmail(user.getEmail());
		dto.setFirstName(user.getFirstName());
		dto.setLastName(user.getLastName());
		dto.setRole(user.getRole());
		dto.setStatus(user.getStatus());
		dto.setHolderType(user.getHolderType());
		dto.setCreatedAt(user.getCreatedAt());
		return dto;
	}
}