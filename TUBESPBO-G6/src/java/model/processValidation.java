package model;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.BookReturnDao;
import model.bookReturn;

@WebServlet("/ProcessValidation")
public class processValidation extends HttpServlet {
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       
       String memberName = request.getParameter("borrower_name");
       String bookTitle = request.getParameter("book_title");
       
       System.out.println("Processing validation for member: " + memberName + ", book: " + bookTitle);
       
       BookReturnDao dao = new BookReturnDao();
       boolean isValid = dao.validateMember(memberName, bookTitle);
       
       if(isValid) {
           bookReturn bookReturn = dao.getBorrowingDetails(memberName, bookTitle);
           request.setAttribute("bookReturn", bookReturn);
           
           if(bookReturn != null) {
               request.getRequestDispatcher("returnDetail.jsp").forward(request, response);
           } else {
               request.setAttribute("error", "Detail peminjaman tidak ditemukan");
               request.getRequestDispatcher("prosesValidasi.jsp").forward(request, response);
           }
       } else {
           request.setAttribute("error", "Data peminjaman tidak ditemukan");
           request.getRequestDispatcher("prosesValidasi.jsp").forward(request, response);
       }
   }
}