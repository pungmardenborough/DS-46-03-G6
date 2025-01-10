package model;

import dao.BookReturnDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ValidateMamber")
public class ValidateMamber extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Ambil parameter dari form
            String username = request.getParameter("username");
            String judulBuku = request.getParameter("judul_buku");
            
            // Debug log
            System.out.println("Received parameters:");
            System.out.println("Username: " + username);
            System.out.println("Judul Buku: " + judulBuku);
            
            // Validasi input
            if (username == null || username.trim().isEmpty() || 
                judulBuku == null || judulBuku.trim().isEmpty()) {
                request.setAttribute("error", "Username dan Judul Buku harus diisi!");
                request.getRequestDispatcher("/return.jsp").forward(request, response);
                return;
            }
            
            // Proses validasi
            BookReturnDao dao = new BookReturnDao();
            boolean isValid = dao.validateMember(username, judulBuku);
            
            if (isValid) {
                // Jika valid, ambil detail peminjaman
                bookReturn peminjamanData = dao.getBorrowingDetails(username, judulBuku);
                
                if (peminjamanData != null) {
                    // Set data ke request attribute
                    request.setAttribute("peminjaman", peminjamanData);
                    request.getRequestDispatcher("/returnDetail.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Detail peminjaman tidak ditemukan.");
                    request.getRequestDispatcher("/return.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Data peminjaman tidak ditemukan atau buku sudah dikembalikan.");
                request.getRequestDispatcher("/return.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.out.println("Error in ValidateMember servlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Terjadi kesalahan sistem. Silakan coba lagi.");
            request.getRequestDispatcher("/return.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect ke halaman return untuk GET request
        response.sendRedirect("return.jsp");
    }
}