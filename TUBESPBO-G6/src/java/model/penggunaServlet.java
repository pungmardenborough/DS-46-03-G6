/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import clasess.JDBC;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "penggunaServlet", urlPatterns = {"/penggunaServlet"})
public class penggunaServlet extends HttpServlet {

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
            request.getRequestDispatcher("/pengguna.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("pengguna.jsp");
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