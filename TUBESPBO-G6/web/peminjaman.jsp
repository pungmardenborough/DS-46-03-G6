<%-- 
    Document   : peminjaman
    Created on : Dec 29, 2024, 2:24:32 AM
    Author     : CHRISTIANA NAIDA P
--%>

<%-- 
    Document   : peminjaman
    Created on : Dec 29, 2024, 2:24:32 AM
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
        response.sendRedirect("pengguna.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Peminjaman Buku</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .alert-success {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1050;
            display: none;
        }
    </style>
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
        <h1 class="text-center">Peminjaman Buku</h1>
        <p class="text-center">Pilih buku yang ingin dipinjam</p>
        <hr>

        <form action="PeminjamanServlet" method="POST">
            <input type="hidden" name="action" value="add">
            <div class="mb-3">
                <label for="username" class="form-label">Nama Pengguna</label>
                <input type="text" class="form-control" id="username" name="username" value="<%= sessionUser.getAttribute("username") %>" readonly>
            </div>

            <div class="mb-3">
                <label for="judul_buku" class="form-label">Judul Buku</label>
                <select class="form-select" id="judul_buku" name="judul_buku" required>
                    <option value="">Pilih Buku</option>
                    <% 
                        List<book> books = (List<book>) request.getAttribute("books");
                        if (books != null && !books.isEmpty()) {
                            for (book book : books) {
                    %>
                        <option value="<%= book.getJudul() %>"><%= book.getJudul() %></option>
                    <% 
                            }
                        } else {
                    %>
                        <option value="" disabled>No books available</option>
                    <% 
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label for="jumlah_peminjaman" class="form-label">Jumlah Buku</label>
                <input type="number" class="form-control" id="jumlah_peminjaman" name="jumlah_peminjaman" min="1" required>
            </div>

            <!-- Field for Borrow Date -->
            <div class="mb-3">
                <label for="tanggal_peminjaman" class="form-label">Tanggal Peminjaman</label>
                <input type="date" class="form-control" id="tanggal_peminjaman" name="tanggal_peminjaman" readonly>
            </div>

            <!-- Field for Return Date -->
            <div class="mb-3">
                <label for="tanggal_pengembalian" class="form-label">Tanggal Pengembalian</label>
                <input type="date" class="form-control" id="tanggal_pengembalian" name="tanggal_pengembalian" readonly>
            </div>
            <div class="d-flex">
                <button type="submit" name="action" value="borrow" class="btn btn-primary me-2">Pinjam Buku</button>
            </div>
            
        </form>
    </div>
        

    <!-- Pop-up Notification -->
    <div class="alert alert-success" id="success-popup" role="alert">
        Peminjaman buku sudah berhasil!
    </div>

    <!-- JavaScript to handle dates and pop-up -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Set default borrow and return dates
            const today = new Date();
            const borrowDate = today.toISOString().split('T')[0];
            const returnDate = new Date(today);
            returnDate.setDate(today.getDate() + 5);

            document.getElementById("tanggal_peminjaman").value = borrowDate;
            document.getElementById("tanggal_pengembalian").value = returnDate.toISOString().split('T')[0];

            // Show pop-up based on URL status parameter
        const status = new URLSearchParams(window.location.search).get("status");
        if (status === "success") {
            alert("Peminjaman buku berhasil!");
            setTimeout(() => {
                window.location.href = "penggunaServlet";
            }, 2000); // Redirect after 2 seconds
        } else if (status === "error") {
            alert("Terjadi kesalahan saat memproses peminjaman buku.");
            setTimeout(() => {
                window.location.href = "penggunaServlet";
            }, 2000); // Redirect after 2 seconds
        }

        // Remove URL parameter after showing pop-up (if necessary)
        if (status) {
            history.replaceState(null, "penggunaServlet", window.location.pathname);
        }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
