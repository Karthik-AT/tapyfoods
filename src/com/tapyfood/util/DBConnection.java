package com.tapyfood.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DB_URL =
        "jdbc:mysql://localhost:3306/tapyfood_db" +
        "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata";

    private static final String DB_USER = "root";
    private static final String DB_PASS = "24-08-2004KAT";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("[DBConnection] MySQL JDBC Driver not found!");
            System.err.println("→ Add mysql-connector-j.jar to WebContent/WEB-INF/lib/");
            throw new RuntimeException("MySQL JDBC Driver missing.", e);
        }
    }

    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }

    // Utility class — no instances allowed
    private DBConnection() {}
}