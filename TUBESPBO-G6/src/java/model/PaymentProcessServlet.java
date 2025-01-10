package model;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProcessPayment") 
public class PaymentProcessServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ProcessPayment servlet called");

        // Ambil parameter dari request
        String selectedBank = request.getParameter("selectedBank");
        String totalFee = request.getParameter("totalFee");

        try {
            // Simulasi proses pembayaran
            boolean isSuccess = Math.random() > 0.3; // 70% kemungkinan sukses
            String paymentStatus = isSuccess ? "SUCCESS" : "FAILED";

            // Log hasil
            System.out.println("Payment method: " + selectedBank);
            System.out.println("Total Fee: " + totalFee);
            System.out.println("Payment status: " + paymentStatus);

            // Set attribute untuk halaman status pembayaran
            request.setAttribute("selectedBank", selectedBank);
            request.setAttribute("totalFee", totalFee);
            request.setAttribute("paymentStatus", paymentStatus);

            // Forward ke halaman status pembayaran
            request.getRequestDispatcher("PaymentStatus.jsp").forward(request, response);

        } catch (Exception e) {
            // Log error
            System.out.println("Error processing payment: " + e.getMessage());
            e.printStackTrace();

            // Kirim response error
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle GET request untuk melihat status pembayaran
        String paymentId = request.getParameter("paymentId");

        try {
            if (paymentId != null) {
                // Contoh data: Seharusnya mengambil dari database
                request.setAttribute("selectedBank", "BCA");
                request.setAttribute("totalFee", "50000");
                request.setAttribute("paymentStatus", "PENDING"); // Contoh: Status awal

                // Forward ke halaman status pembayaran
                request.getRequestDispatcher("PaymentStatus.jsp").forward(request, response);
            } else {
                response.sendRedirect("payment.jsp");
            }
        } catch (Exception e) {
            // Log error
            System.out.println("Error retrieving payment status: " + e.getMessage());
            e.printStackTrace();

            // Kirim response error
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}
