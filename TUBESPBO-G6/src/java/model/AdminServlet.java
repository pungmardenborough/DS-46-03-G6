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

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

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
            request.getRequestDispatcher("/admin.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp");
        } finally {
            closeResources(rs, pst, conn);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addBook(request, response);
        } else if ("edit".equals(action)) {
            editBook(request, response);
        } else if ("delete".equals(action)) {
            deleteBook(request, response);
        }
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pst = null;

        try {
            conn = JDBC.getConnection();
            String query = "INSERT INTO daftarbuku (judul, penulis, penerbit, stok) VALUES (?, ?, ?, ?)";
            pst = conn.prepareStatement(query);

            pst.setString(1, request.getParameter("judul"));
            pst.setString(2, request.getParameter("penulis"));
            pst.setString(3, request.getParameter("penerbit"));
            pst.setInt(4, Integer.parseInt(request.getParameter("stok")));

            pst.executeUpdate();
            response.sendRedirect("AdminServlet");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp");
        } finally {
            closeResources(null, pst, conn);
        }
    }

    private void editBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pst = null;

        try {
            conn = JDBC.getConnection();
            String query = "UPDATE daftarbuku SET judul = ?, penulis = ?, penerbit = ?, stok = ? WHERE id = ?";
            pst = conn.prepareStatement(query);

            pst.setString(1, request.getParameter("judul"));
            pst.setString(2, request.getParameter("penulis"));
            pst.setString(3, request.getParameter("penerbit"));
            pst.setInt(4, Integer.parseInt(request.getParameter("stok")));
            pst.setInt(5, Integer.parseInt(request.getParameter("id")));

            pst.executeUpdate();
            response.sendRedirect("AdminServlet");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp");
        } finally {
            closeResources(null, pst, conn);
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pst = null;

        try {
            conn = JDBC.getConnection();
            String query = "DELETE FROM daftarbuku WHERE id = ?";
            pst = conn.prepareStatement(query);
            pst.setInt(1, Integer.parseInt(request.getParameter("id")));
            pst.executeUpdate();

            response.sendRedirect("AdminServlet");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp");
        } finally {
            closeResources(null, pst, conn);
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
