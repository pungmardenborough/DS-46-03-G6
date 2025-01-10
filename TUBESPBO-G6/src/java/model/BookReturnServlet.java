package model;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BookReturnServlet")
public class BookReturnServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String condition = request.getParameter("condition");
        double lateFine = 15000; // 3 hari × 5000
        double damageFine = "damaged".equals(condition) ? 50000 : 0;
        double totalFine = lateFine + damageFine;
        
        // Kirim response
        String jsonResponse = String.format(
            "{\"success\":true,\"lateFine\":%.2f,\"damageFine\":%.2f,\"totalFine\":%.2f}",
            lateFine, damageFine, totalFine
        );
        
        response.setContentType("application/json");
        response.getWriter().write(jsonResponse);
    }
}