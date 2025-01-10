<%-- 
    Document   : processPayment
    Created on : Jan 2, 2025, 2:11:07?AM
    Author     : CHRISTIANA NAIDA P
--%>

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProcessPayment") 
public class processPayment extends HttpServlet {
  
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
           
       System.out.println("ProcessPayment servlet called");
       
       try {
           // Debug: Print semua parameter yang diterima
           java.util.Enumeration<String> paramNames = request.getParameterNames();
           while(paramNames.hasMoreElements()) {
               String paramName = paramNames.nextElement();
               System.out.println(paramName + ": " + request.getParameter(paramName));
           }

           // Ambil parameter dari request
           String selectedBank = request.getParameter("selectedBank");
           int totalFee = Integer.parseInt(request.getParameter("totalFee"));
           
           // Simulasi proses pembayaran (70% success)
           boolean isSuccess = Math.random() > 0.3;
           
           // Set VA number berdasarkan bank yang dipilih
           String vaNumber = "";
           String bankLogo = "";
           String bankName = "";
           String instructions = "";
           
           switch(selectedBank) {
               case "bca":
                   vaNumber = "880012345678";
                   bankLogo = "https://upload.wikimedia.org/wikipedia/commons/5/5c/Bank_Central_Asia.svg";
                   bankName = "BCA Virtual Account";
                   instructions = "1. Buka aplikasi BCA Mobile\n" +
                                "2. Pilih menu m-Transfer > BCA Virtual Account\n" +
                                "3. Masukkan nomor Virtual Account\n" +
                                "4. Periksa informasi pembayaran\n" +
                                "5. Masukkan PIN m-BCA\n" +
                                "6. Pembayaran selesai";
                   break;
               case "mandiri":
                   vaNumber = "890012345678";
                   bankLogo = "https://upload.wikimedia.org/wikipedia/commons/a/ad/Bank_Mandiri_logo_2016.svg";
                   bankName = "Mandiri Virtual Account";
                   instructions = "1. Buka aplikasi Livin' by Mandiri\n" +
                                "2. Pilih menu Pembayaran\n" +
                                "3. Pilih Virtual Account\n" +
                                "4. Masukkan nomor Virtual Account\n" +
                                "5. Konfirmasi pembayaran\n" +
                                "6. Pembayaran selesai";
                   break;
               case "bni":
                   vaNumber = "881012345678";
                   bankLogo = "https://upload.wikimedia.org/wikipedia/id/5/55/BNI_logo.svg";
                   bankName = "BNI Virtual Account";
                   instructions = "1. Buka aplikasi BNI Mobile\n" +
                                "2. Pilih menu Transfer\n" +
                                "3. Pilih Virtual Account Billing\n" +
                                "4. Masukkan nomor Virtual Account\n" +
                                "5. Konfirmasi pembayaran\n" +
                                "6. Pembayaran selesai";
                   break;
               default:
                   throw new ServletException("Metode pembayaran tidak valid");
           }
           
           // Set attribute untuk payment status page
           request.setAttribute("selectedBank", selectedBank);
           request.setAttribute("totalFee", totalFee);
           request.setAttribute("paymentStatus", isSuccess ? "SUCCESS" : "FAILED");
           request.setAttribute("vaNumber", vaNumber);
           request.setAttribute("bankLogo", bankLogo);
           request.setAttribute("bankName", bankName);
           request.setAttribute("instructions", instructions);
           
           // Forward ke halaman status
           request.getRequestDispatcher("/PaymentStatus.jsp").forward(request, response);
           
       } catch (Exception e) {
           // Log error
           System.out.println("Error processing payment: " + e.getMessage());
           e.printStackTrace();
           
           // Set error attributes dan forward ke status page
           request.setAttribute("paymentStatus", "FAILED");
           request.setAttribute("errorMessage", e.getMessage());
           request.getRequestDispatcher("/PaymentStatus.jsp").forward(request, response);
       }
   }
}