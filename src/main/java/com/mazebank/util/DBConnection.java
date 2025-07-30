package com.mazebank.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class DBConnection {

	private static Properties props = new Properties();
	private static String propFileName = "db.properties";
	
    // Method to load properties from a specific file
    public static void loadProperties(String fileName) {
        propFileName = fileName;
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream(propFileName)) {
            if (input == null) {
                System.out.println("Sorry, unable to find " + propFileName);
                return;
            }
            props.load(input);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
    
    // Static initializer block (runs once when class is loaded)
    static {
        loadProperties("db.properties"); // Load default properties on startup
    }

    public static Connection getConnection() throws SQLException {
        String url = props.getProperty("db.url");
        String user = props.getProperty("db.username");
        String password = props.getProperty("db.password");

        if (url == null || user == null || password == null) {
            throw new SQLException("Database properties not loaded correctly. Check " + propFileName);
        }

        try {
        	Class.forName(props.getProperty("db.driver")); // Load the JDBC driver
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found.");
            e.printStackTrace();
            throw new SQLException("JDBC Driver not found.", e);
        }

        return DriverManager.getConnection(url, user, password);
    }
    
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
