/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;

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
import clasess.JDBC;

@WebServlet("/Payment")
public class payment extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            System.out.println("=== DEBUG: Starting Payment Process ===");
            
            conn = JDBC.getConnection();
            System.out.println("Database Connection: " + (conn != null ? "Success" : "Failed"));
            
            if(conn == null) {
                throw new SQLException("Database connection is null");
            }
            
            // Debug: Print parameter yang diterima
            String idPeminjaman = request.getParameter("idPeminjaman");
            String condition = request.getParameter("condition");
            System.out.println("ID Peminjaman: " + idPeminjaman);
            System.out.println("Condition: " + condition);
            
            // Validasi parameter
            if (idPeminjaman == null || idPeminjaman.trim().isEmpty()) {
                throw new ServletException("ID Peminjaman tidak boleh kosong");
            }
            
            // Query sesuai struktur database baru
            String sql = "SELECT late_fine, lateFees FROM borrowings WHERE id = ?";
            System.out.println("SQL Query: " + sql);
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, idPeminjaman);
            
            System.out.println("Executing query for ID: " + idPeminjaman);
            
            rs = stmt.executeQuery();
            System.out.println("Query executed. Has results: " + rs.next());
            
            if (rs.next()) {
                // Ambil denda dari database
                double lateFine = rs.getDouble("late_fine");
                double lateFees = rs.getDouble("lateFees");
                System.out.println("Raw lateFine from DB: " + lateFine);
                System.out.println("Raw lateFees from DB: " + lateFees);
                
                int lateFeeAmount = (int)(lateFees * 1000); // Konversi ke Rupiah
                System.out.println("Converted lateFeeAmount: " + lateFeeAmount);
                
                // Hitung denda kerusakan jika buku rusak
                int damageFee = "damaged".equals(condition) ? 50000 : 0;
                System.out.println("Damage Fee: " + damageFee);
                
                // Hitung total denda
                int totalFee = lateFeeAmount + damageFee;
                System.out.println("Total Fee: " + totalFee);
                
                // Set atribut untuk JSP
                request.setAttribute("lateFee", lateFeeAmount);
                request.setAttribute("damageFee", damageFee);
                request.setAttribute("totalFee", totalFee);
                
                System.out.println("=== Attributes set for JSP ===");
                System.out.println("lateFee attribute: " + request.getAttribute("lateFee"));
                System.out.println("damageFee attribute: " + request.getAttribute("damageFee"));
                System.out.println("totalFee attribute: " + request.getAttribute("totalFee"));
                
                // Generate nomor VA
                String va = String.format("%08d", Integer.parseInt(idPeminjaman.replaceAll("[^0-9]", "")));
                request.setAttribute("bcaVA", "88001" + va);
                request.setAttribute("mandiriVA", "89001" + va);
                request.setAttribute("bniVA", "88101" + va);
                
                System.out.println("=== Forwarding to payment.jsp ===");
                request.getRequestDispatcher("payment.jsp").forward(request, response);
            } else {
                System.out.println("No data found for ID: " + idPeminjaman);
                throw new ServletException("Data peminjaman tidak ditemukan untuk ID: " + idPeminjaman);
            }
            
        } catch (SQLException e) {
            System.out.println("=== SQL ERROR ===");
            e.printStackTrace();
            System.out.println("SQL Error: " + e.getMessage());
            throw new ServletException("Database error: " + e.getMessage());
        } catch (ServletException se) {
            System.out.println("=== SERVLET ERROR ===");
            se.printStackTrace();
            System.out.println("Servlet Error: " + se.getMessage());
            throw se;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
                System.out.println("=== Resources Closed ===");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}