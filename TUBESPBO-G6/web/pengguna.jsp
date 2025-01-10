<%-- 
    Document   : pengguna
    Created on : Dec 17, 2024, 6:25:46 PM
    Author     : CHRISTIANA NAIDA P
--%>

<%@page import="java.util.List"%>
<%@page import="model.book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek sesi login
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("role") == null || 
        !"user".equalsIgnoreCase((String) sessionUser.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Pengguna</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Dashboard Pengguna</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h1 class="text-center">Selamat Datang, <%= sessionUser.getAttribute("username") %>!</h1>
        <p class="text-center">Ini adalah dashboard pengguna perpustakaan.</p>
        <hr>
        <div class="text-center">
            <h3 class="mt-4">Daftar Buku</h3>
        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>No</th>
                    <th>Judul Buku</th>
                    <th>Penulis</th>
                    <th>Penerbit</th>
                    <th>Stok</th>
                </tr>
            </thead>
            <tbody>
                
                <% 
                    List<book> books = (List<book>) request.getAttribute("books");
                    if (books != null && !books.isEmpty()) {
                        for (int i = 0; i < books.size(); i++) {
                            book book = books.get(i);
                %>
                <tr>
                    <td><%= i + 1 %></td>
                    <td><%= book.getJudul() %></td>
                    <td><%= book.getPenulis() %></td>
                    <td><%= book.getPenerbit() %></td>
                    <td><%= book.getStok() %></td>
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6">NO BOOKS AVAILABLE.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <!-- Button to go to the borrowing page -->
        <div class="d-flex justify-content-center mt-4">
            <div class="text-center">
             
                <a href="PeminjamanServlet" class="btn btn-primary">Pinjam Buku</a>
                <a href="prosesValidasi.jsp" class="btn btn-primary">Pengembalian Buku</a>
                </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
