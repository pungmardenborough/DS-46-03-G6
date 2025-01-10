package dao;

import model.bookReturn;
import java.sql.*;
import java.util.Date;

public class BookReturnDao {
    // Ganti URL, USER, dan PASSWORD sesuai dengan pengaturan database Anda
    private static final String URL = "jdbc:mysql://localhost:3306/tubes"; // Ganti 'localhost' jika database berada di server lain
    private static final String USER = "root"; // Username MySQL Anda
    private static final String PASSWORD = ""; // Password MySQL Anda

    private static Connection getConnection() {
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

    public boolean validateMember(String borrowerName, String bookTitle) {
        String query = "SELECT * FROM borrowings WHERE borrower_name = ? AND book_title = ? AND return_date IS NULL";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, borrowerName);
            stmt.setString(2, bookTitle);

            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Mengembalikan true jika data ditemukan
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public bookReturn getBorrowingDetails(String borrowerName, String bookTitle) {
        String query = "SELECT * FROM borrowings WHERE borrower_name = ? AND book_title = ? AND return_date IS NULL";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, borrowerName);
            stmt.setString(2, bookTitle);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                bookReturn bookReturn = new bookReturn();
                bookReturn.setReturnId("BK" + System.currentTimeMillis());
                bookReturn.setBorrowerName(rs.getString("borrower_name"));
                bookReturn.setBookTitle(rs.getString("book_title"));
                bookReturn.setBorrowDate(rs.getDate("borrow_date"));
                bookReturn.setDueDate(rs.getDate("due_date"));

                // Hitung keterlambatan
                Date dueDate = rs.getDate("due_date");
                if (dueDate != null) {
                    Date now = new Date();
                    long diff = now.getTime() - dueDate.getTime();
                    int lateDays = (int) (diff / (1000 * 60 * 60 * 24));
                    bookReturn.setLatedays(Math.max(0, lateDays));
                } else {
                    bookReturn.setLatedays(0);
                }

                return bookReturn;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateBookReturn(bookReturn bookReturn) {
        if (bookReturn == null) {
            System.out.println("BookReturn object is null");
            return false;
        }

        String query = "UPDATE borrowings SET return_date = ?, book_condition = ?, " +
                      "late_fine = ?, damage_fine = ?, total_fine = ?, " +
                      "payment_method = ?, payment_status = ? " +
                      "WHERE borrower_name = ? AND book_title = ? AND return_date IS NULL";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setDate(1, new java.sql.Date(new Date().getTime()));
            stmt.setString(2, bookReturn.getCondition());
            stmt.setDouble(3, bookReturn.getLateFine());
            stmt.setDouble(4, bookReturn.getDamageFine());
            stmt.setDouble(5, bookReturn.getTotalFine());
            stmt.setString(6, bookReturn.getPaymentMethod());
            stmt.setString(7, bookReturn.getPaymentStatus());
            stmt.setString(8, bookReturn.getBorrowerName());
            stmt.setString(9, bookReturn.getBookTitle());

            return stmt.executeUpdate() > 0; // Mengembalikan true jika pembaruan berhasil
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
