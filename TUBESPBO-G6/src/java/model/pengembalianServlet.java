/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author CHRISTIANA NAIDA P
 */
@WebServlet(name = "pengembalianServlet", urlPatterns = {"/pengembalianServlet"})
public class pengembalianServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Logic for handling POST requests
        processReturn(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Logic for handling GET requests
        processReturn(request, response);
    }

    private void processReturn(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Ambil parameter dari request
        String condition = request.getParameter("kondisi_buku");
        int daysLate;
        try {
            daysLate = Integer.parseInt(request.getParameter("hari_terlambat"));
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":false,\"message\":\"Invalid hari_terlambat parameter.\"}");
            return;
        }

        // Hitung denda
        double lateFine = 0;
        if (daysLate > 5) {
            lateFine = (daysLate - 5) * 1000; // Denda dihitung setelah 5 hari
        }
        double damageFine = "damaged".equals(condition) ? 50000 : 0;
        double totalFine = lateFine + damageFine;

        // Kirim response dalam format JSON
        String jsonResponse = String.format(
            "{\"success\":true,\"lateFine\":%.2f,\"damageFine\":%.2f,\"totalFine\":%.2f}",
            lateFine, damageFine, totalFine
        );

        response.setContentType("application/json");
        response.getWriter().write(jsonResponse);
    }
}
