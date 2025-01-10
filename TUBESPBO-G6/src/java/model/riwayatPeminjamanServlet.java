// riwayatPeminjamanServlet.java
package model;

import clasess.JDBC;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "riwayatPeminjamanServlet", urlPatterns = {"/riwayatPeminjamanServlet"})
public class riwayatPeminjamanServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            conn = JDBC.getConnection();
            String query = "SELECT id, username, judul_buku, jumlah_peminjaman, tanggal_peminjaman, status, denda FROM peminjaman";
            pst = conn.prepareStatement(query);
            rs = pst.executeQuery();

            List<peminjaman> peminjamanList = new ArrayList<>();

            while (rs.next()) {
                // Safely handle potentially null dates
                LocalDate tanggalPeminjaman = rs.getDate("tanggal_peminjaman") != null ? 
                    rs.getDate("tanggal_peminjaman").toLocalDate() : null;
                    
                // Calculate return date (5 days from borrow date)
                LocalDate tanggalPengembalian = tanggalPeminjaman != null ? 
                    tanggalPeminjaman.plusDays(5) : null;

                peminjaman peminjaman = new peminjaman(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("judul_buku"),
                        rs.getInt("jumlah_peminjaman"),
                        tanggalPeminjaman,
                        tanggalPengembalian,
                        rs.getString("status"),
                        rs.getInt("denda")
                );

                peminjamanList.add(peminjaman);
            }

            request.setAttribute("peminjamanList", peminjamanList);
            request.getRequestDispatcher("/riwayatPeminjaman.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("An error occurred while processing the request.");
        } finally {
            closeResources(rs, pst, conn);
        }
    }

    private void closeResources(ResultSet rs, PreparedStatement pst, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
