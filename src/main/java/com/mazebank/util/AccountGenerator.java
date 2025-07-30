package com.mazebank.util;

import java.security.SecureRandom;

public class AccountGenerator {

    private static final SecureRandom random = new SecureRandom();
    private static final String DIGITS = "0123456789";
    private static final int RANDOM_PART_LENGTH = 11; // To make total length around 20 with userId

    /**
     * Generates a unique account number based on user ID and random digits.
     * Format: userId (padded to 9 digits) + random 11 digits = 20 characters
     * @param userId The ID of the user for whom the account is created.
     * @return A unique account number string.
     */
    public static String generateAccountNumber(int userId) {
        // Pad userId to 9 digits (max for INT is 2,147,483,647, so 9-10 digits)
        String userIdStr = String.format("%09d", userId); // Pad with leading zeros if less than 9 digits

        StringBuilder sb = new StringBuilder(userIdStr);
        for (int i = 0; i < RANDOM_PART_LENGTH; i++) {
            sb.append(DIGITS.charAt(random.nextInt(DIGITS.length())));
        }
        return sb.toString();
    }
}