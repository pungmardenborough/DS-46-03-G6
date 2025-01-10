/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;

import clasess.JDBC;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author CHRISTIANA NAIDA P
 */
@WebServlet(name = "PeminjamanServlet", urlPatterns = {"/PeminjamanServlet"})
public class PeminjamanServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            conn = JDBC.getConnection();
            String query = "SELECT * FROM daftarbuku";
            pst = conn.prepareStatement(query);
            rs = pst.executeQuery();

            List<book> books = new ArrayList<>();
            while (rs.next()) {
                book book = new book(
                    rs.getInt("id"),
                    rs.getString("judul"),
                    rs.getString("penulis"),
                    rs.getString("penerbit"),
                    rs.getInt("stok")
                );
                books.add(book);
            }

            request.setAttribute("books", books);
            request.getRequestDispatcher("/peminjaman.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("peminjaman.jsp");
        } finally {
            closeResources(null, pst, conn);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addPeminjam(request, response);
        }
    }
    
    private void addPeminjam(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    Connection conn = null;
    PreparedStatement pst = null;
    PreparedStatement updateStockPst = null;

    try {
        conn = JDBC.getConnection();

        // Ambil data dari form
        String username = request.getParameter("username");
        String judulBuku = request.getParameter("judul_buku");
        int jumlahPeminjaman = Integer.parseInt(request.getParameter("jumlah_peminjaman"));
        String tanggalPeminjaman = request.getParameter("tanggal_peminjaman");
        String tanggalPengembalian = request.getParameter("tanggal_pengembalian");

        // Cek stok buku sebelum melanjutkan
        String checkStockQuery = "SELECT stok FROM daftarbuku WHERE judul = ?";
        pst = conn.prepareStatement(checkStockQuery);
        pst.setString(1, judulBuku);

        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            int stok = rs.getInt("stok");
            if (stok < jumlahPeminjaman) {
                // Jika stok tidak mencukupi, tampilkan pesan error
                response.sendRedirect("peminjaman.jsp?status=stok_kurang");
                return;
            }
        } else {
            // Jika buku tidak ditemukan, tampilkan pesan error
            response.sendRedirect("peminjaman.jsp?status=buku_tidak_ditemukan");
            return;
        }

        // Tambahkan data ke tabel peminjaman
        String insertPeminjamanQuery = "INSERT INTO peminjaman (username, judul_buku, jumlah_peminjaman, tanggal_peminjaman, tanggal_pengembalian, status, denda) VALUES (?, ?, ?, ?, ?, ?, ?)";
        pst = conn.prepareStatement(insertPeminjamanQuery);
        pst.setString(1, username);
        pst.setString(2, judulBuku);
        pst.setInt(3, jumlahPeminjaman);
        pst.setDate(4, java.sql.Date.valueOf(tanggalPeminjaman));
        pst.setDate(5, java.sql.Date.valueOf(tanggalPengembalian));
        pst.setString(6, "dipinjam"); // Status default "dipinjam"
        pst.setInt(7, 0); // Denda default 0
        pst.executeUpdate();

        // Kurangi stok buku
        String updateStockQuery = "UPDATE daftarbuku SET stok = stok - ? WHERE judul = ?";
        updateStockPst = conn.prepareStatement(updateStockQuery);
        updateStockPst.setInt(1, jumlahPeminjaman);
        updateStockPst.setString(2, judulBuku);
        updateStockPst.executeUpdate();

        response.sendRedirect("PeminjamanServlet?status=success");

    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("peminjaman.jsp?status=error");
    } finally {
        closeResources(null, pst, conn);
        closeResources(null, updateStockPst, null);
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
