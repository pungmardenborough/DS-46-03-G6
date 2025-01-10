package clasess;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBC {
    // Gantilah URL, USER, dan PASSWORD sesuai dengan informasi di phpMyAdmin
    private static final String URL = "jdbc:mysql://localhost:3306/tubes"; // Gantilah 'localhost' jika database berada di server lain
    private static final String USER = "root"; // Username MySQL Anda
    private static final String PASSWORD = ""; // Password MySQL Anda

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Memastikan MySQL JDBC driver di-load
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Membuat koneksi ke database
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
}
