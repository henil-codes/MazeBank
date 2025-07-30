package com.mazebank.util;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;
import java.util.Locale;

public class NumberUtils {

    // Define the scale for currency calculations (e.g., 2 decimal places)
    private static final int CURRENCY_SCALE = 2;
    // Define the rounding mode (e.g., HALF_UP for standard rounding)
    private static final RoundingMode ROUNDING_MODE = RoundingMode.HALF_UP;

    /**
     * Scales a BigDecimal to the standard currency scale (2 decimal places) and applies rounding.
     * Prevents issues with floating-point precision in financial calculations.
     * @param value The BigDecimal value to scale.
     * @return The scaled BigDecimal.
     */
    public static BigDecimal scaleBigDecimal(BigDecimal value) {
        if (value == null) {
            return BigDecimal.ZERO;
        }
        return value.setScale(CURRENCY_SCALE, ROUNDING_MODE);
    }

    /**
     * Formats a BigDecimal as currency string (e.g., "$1,234.56").
     * @param amount The BigDecimal amount to format.
     * @return The formatted currency string.
     */
    public static String formatCurrency(BigDecimal amount) {
        if (amount == null) {
            return "$0.00"; // Or throw IllegalArgumentException, depending on desired behavior
        }
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(Locale.US); // Use US locale for "$"
        // Ensure the BigDecimal is scaled before formatting for consistency
        return currencyFormatter.format(scaleBigDecimal(amount));
    }

    // Example usage
    public static void main(String[] args) {
        BigDecimal unscaled = new BigDecimal("1234.56789");
        System.out.println("Unscaled: " + unscaled);
        System.out.println("Scaled: " + scaleBigDecimal(unscaled));
        System.out.println("Formatted: " + formatCurrency(unscaled));

        BigDecimal exact = new BigDecimal("99.99");
        System.out.println("Exact: " + exact);
        System.out.println("Scaled Exact: " + scaleBigDecimal(exact));
        System.out.println("Formatted Exact: " + formatCurrency(exact));

        BigDecimal zero = BigDecimal.ZERO;
        System.out.println("Zero: " + zero);
        System.out.println("Scaled Zero: " + scaleBigDecimal(zero));
        System.out.println("Formatted Zero: " + formatCurrency(zero));

        BigDecimal neg = new BigDecimal("-50.255");
        System.out.println("Negative: " + neg);
        System.out.println("Scaled Negative: " + scaleBigDecimal(neg));
        System.out.println("Formatted Negative: " + formatCurrency(neg));
    }
}