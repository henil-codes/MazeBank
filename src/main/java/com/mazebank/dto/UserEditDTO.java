package com.mazebank.dto;

public class UserEditDTO extends UserResponseDTO {
	private String currentPassword;
	private String newPassword;
	private String confirmPassword;

	public UserEditDTO() {
	}

	public UserEditDTO(UserResponseDTO userResponse) {
		super(userResponse.getUserId(), userResponse.getUsername(), userResponse.getEmail(),
				userResponse.getFirstName(), userResponse.getLastName(), userResponse.getRole(),
				userResponse.getStatus(), userResponse.getHolderType(), userResponse.getCreatedAt());
	}

	// Getters and setters for password fields
	public String getCurrentPassword() {
		return currentPassword;
	}

	public void setCurrentPassword(String currentPassword) {
		this.currentPassword = currentPassword;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
}