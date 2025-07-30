package com.mazebank.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    /**
     * Hashes a plain text password using BCrypt.
     * @param plainPassword The plain text password.
     * @return The BCrypt hashed password.
     */
    public static String hashPassword(String plainPassword) {
        // BCrypt.hashpw generates a salt internally and includes it in the hash.
        // The second argument, 10, is the log_rounds parameter. 2^10 iterations.
        // Higher values are more secure but slower. 10-12 is generally recommended.
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
    }

    /**
     * Verifies a plain text password against a stored BCrypt hashed password.
     * @param plainPassword The plain text password to verify.
     * @param hashedPassword The stored BCrypt hashed password (contains the salt).
     * @return true if passwords match, false otherwise.
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }


}