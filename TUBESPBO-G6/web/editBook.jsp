<%-- 
    Document   : book
    Created on : Dec 17, 2024, 8:05:03 PM
    Author     : CHRISTIANA NAIDA P
--%>

<%@page import="java.awt.print.Book"%>
<%@ page import="clasess.JDBC" %>
<%@ page import="model.book" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Edit Buku</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h1>Edit Buku</h1>

        <%
            int bookId = Integer.parseInt(request.getParameter("id"));
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                conn = JDBC.getConnection();
                String query = "SELECT * FROM daftarbuku WHERE id = ?";
                pst = conn.prepareStatement(query);
                pst.setInt(1, bookId);
                rs = pst.executeQuery();

                book book = null;
                if (rs.next()) {
                    book = new book(rs.getInt("id"), rs.getString("judul"), rs.getString("penulis"), rs.getString("penerbit"), rs.getInt("stok"));
                }
        %>

        <form action="AdminServlet" method="POST">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" value="<%= book.getId() %>">
            <div class="mb-3">
                <label for="judul" class="form-label">Judul Buku</label>
                <input type="text" class="form-control" id="judul" name="judul" value="<%= book.getJudul() %>" required>
            </div>
            <div class="mb-3">
                <label for="penulis" class="form-label">Penulis</label>
                <input type="text" class="form-control" id="penulis" name="penulis" value="<%= book.getPenulis() %>" required>
            </div>
            <div class="mb-3">
                <label for="penerbit" class="form-label">Penerbit</label>
                <input type="text" class="form-control" id="penerbit" name="penerbit" value="<%= book.getPenerbit() %>" required>
            </div>
            <div class="mb-3">
                <label for="stok" class="form-label">Stok</label>
                <input type="number" class="form-control" id="stok" name="stok" value="<%= book.getStok() %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
        </form>

        <%
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (pst != null) try { pst.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        %>
    </div>
</body>
</html>
