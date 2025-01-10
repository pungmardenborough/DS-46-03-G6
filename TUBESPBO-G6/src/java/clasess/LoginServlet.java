package clasess;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ambil input username dan password dari form login
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // Buat koneksi ke database
            conn = JDBC.getConnection();
            if (conn == null) {
                System.out.println("Koneksi ke database gagal!");
                response.sendRedirect("index.jsp?error=database");
                return;
            }

            System.out.println("Koneksi ke database berhasil!"); // Debugging

            // Query untuk mengecek username dan password
            String query = "SELECT * FROM users WHERE username=? AND password=?";
            pst = conn.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password);

            rs = pst.executeQuery();

            if (rs.next()) {
                // Ambil nilai role dari database
                String role = rs.getString("role");
                System.out.println("User Role: " + role); // Debugging: cetak role di console

                // Simpan informasi sesi
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                // Redirect berdasarkan role
                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("AdminServlet"); // Dashboard admin
                } else {
                    response.sendRedirect("penggunaServlet"); // Dashboard pengguna
                }
            } else {
                // Jika username atau password salah
                System.out.println("Username atau password salah!"); // Debugging
                response.sendRedirect("index.jsp?error=true");
            }

        } catch (SQLException e) {
            System.out.println("Database Error: " + e.getMessage()); // Debugging
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=database");
        } finally {
            // Tutup koneksi database
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
