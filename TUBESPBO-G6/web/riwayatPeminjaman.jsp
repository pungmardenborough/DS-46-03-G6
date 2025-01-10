<%@page import="model.peminjaman"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Riwayat Peminjaman</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Riwayat Peminjaman</a>
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
        <h1 class="text-center">Riwayat Peminjaman Buku</h1>
        <p class="text-center">Berikut adalah daftar riwayat peminjaman yang telah dilakukan.</p>
        <hr>

        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>No</th>
                    <th>Username</th>
                    <th>Judul Buku</th>
                    <th>Jumlah</th>
                    <th>Tanggal Peminjaman</th>
                    <th>Tanggal Pengembalian</th>
                    <th>Status</th>
                    <th>Denda</th>
                    
                </tr>
            </thead>
            <tbody>
                <% 
                    List<peminjaman> peminjamanList = (List<peminjaman>) request.getAttribute("peminjamanList");
                    
                    if (peminjamanList != null && !peminjamanList.isEmpty()) {
                        for (int i = 0; i < peminjamanList.size(); i++) {
                            peminjaman item = peminjamanList.get(i);
                %>
                <tr>
                    <td><%= i + 1 %></td>
                    <td><%= item.getUsername() %></td>
                    <td><%= item.getJudul_buku() %></td>
                    <td><%= item.getQuantity() %></td>
                    <td><%= item.getBorrowDate() %></td>
                    <td><%= item.getDueDate()%></td>
                    <td><%= item.getStatus() %></td>
                    <td><%= item.getDenda() %></td>
                    
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr>
                    <td colspan="13" class="text-center">Tidak ada data peminjaman.</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <div class="d-flex justify-content-center mt-4">
            <a href="AdminServlet" class="btn btn-primary">Kembali ke Dashboard Admin</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
