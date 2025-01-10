<%@ page import="model.book" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek sesi login
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("role") == null || 
        !"admin".equalsIgnoreCase((String) sessionUser.getAttribute("role"))) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>

<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Admin Dashboard</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h1 class="text-center">Daftar Buku</h1>

        <!-- Form for adding a new book -->
        <h3>Tambah Buku Baru</h3>
        <form action="AdminServlet" method="POST">
            <input type="hidden" name="action" value="add">
            <div class="mb-3">
                <label for="judul" class="form-label">Judul Buku</label>
                <input type="text" class="form-control" id="judul" name="judul" required>
            </div>
            <div class="mb-3">
                <label for="penulis" class="form-label">Penulis</label>
                <input type="text" class="form-control" id="penulis" name="penulis" required>
            </div>
            <div class="mb-3">
                <label for="penerbit" class="form-label">Penerbit</label>
                <input type="text" class="form-control" id="penerbit" name="penerbit" required>
            </div>
            <div class="mb-3">
                <label for="stok" class="form-label">Stok</label>
                <input type="number" class="form-control" id="stok" name="stok" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Tambah Buku</button>
            
        </form>

        <h3 class="mt-4">Daftar Buku</h3>
        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>No</th>
                    <th>Judul Buku</th>
                    <th>Penulis</th>
                    <th>Penerbit</th>
                    <th>Stok</th>
                    <th>Aksi</th>
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
                    <td>
                        <a href="editBook.jsp?id=<%= book.getId() %>" class="btn btn-warning">Edit</a>
                        <form action="AdminServlet" method="POST" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= book.getId() %>">
                            <button type="submit" class="btn btn-danger">Hapus</button>
                        </form>
                    </td>
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
            <div class="text-center">
            <a href="riwayatPeminjamanServlet" class="btn btn-primary">Riwayat Peminjaman</a>
        </div>
    </div>
</body>
</html>
