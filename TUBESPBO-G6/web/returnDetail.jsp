<%-- 
    Document   : returnDetail
    Created on : Jan 2, 2025, 4:08:30 AM
    Author     : CHRISTIANA NAIDA P
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.peminjaman"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detail Pengembalian</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .book-condition-btn {
            padding: 20px;
            border: 2px solid;
            border-radius: 10px;
            width: 100%;
            transition: all 0.2s;
            background: white;
        }
        .book-condition-btn.good {
            border-color: #198754;
            color: #198754;
        }
        .book-condition-btn.good:hover {
            background: #198754;
            color: white;
        }
        .book-condition-btn.damaged {
            border-color: #dc3545;
            color: #dc3545;
        }
        .book-condition-btn.damaged:hover {
            background: #dc3545;
            color: white;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <div id="peminjaman" class="step-container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Detail Peminjaman</h5>
                        </div>
                        <div class="card-body p-4">
                            <% 
                                peminjaman bookReturn = (peminjaman) request.getAttribute("bookReturn");
                                if (bookReturn != null) {
                                    // Hitung keterlambatan
                                    LocalDate today = LocalDate.now();
                                    long daysLate = 0;
                                    int fine = 0;
                                    
                                    if (bookReturn.getDueDate() != null && today.isAfter(bookReturn.getDueDate())) {
                                        daysLate = ChronoUnit.DAYS.between(bookReturn.getDueDate(), today);
                                        fine = (int) (daysLate * 1000); // Denda Rp5.000 per hari
                                    }
                            %>
                            <div class="row mb-4">
                                <div class="col-md-4">
                                    <label class="text-muted">ID Peminjaman</label>
                                    <div class="fw-bold"><%= bookReturn.getBookId() %></div>
                                </div>
                                <div class="col-md-8">
                                    <label class="text-muted">Peminjam</label>
                                    <div class="fw-bold" id="borrowerName"><%= bookReturn.getUsername() %></div>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-12">
                                    <label class="text-muted">Judul Buku</label>
                                    <div class="fw-bold"><%= bookReturn.getJudul_buku() %></div>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-md-4">
                                    <label class="text-muted">Tanggal Pinjam</label>
                                    <div class="fw-bold"><%= bookReturn.getBorrowDate() %></div>
                                </div>
                                <div class="col-md-4">
                                    <label class="text-muted">Batas Kembali</label>
                                    <div class="fw-bold"><%= bookReturn.getDueDate() %></div>
                                </div>
                                <div class="col-md-4">
                                    <label class="text-muted">Keterlambatan</label>
                                    <div class="fw-bold text-danger"><%= daysLate %> hari</div>
                                </div>
                            </div>

                            <!-- Menampilkan Denda -->
                            <div class="row mb-4">
                                <div class="col-md-12">
                                    <label class="text-muted">Denda Keterlambatan</label>
                                    <div class="fw-bold text-danger"><%= fine == 0 ? "Tidak ada denda" : "Rp " + String.format("%,d", fine) %></div>
                                </div>
                            </div>

                            <div class="border-top pt-4">
                                <h6 class="mb-3">Kondisi Buku:</h6>
                                <div class="row">
                                    <div class="col-md-6">
                                        <button class="book-condition-btn good" 
                                                onclick="window.location.href='payment.jsp?condition=baik&bookId=<%= bookReturn.getBookId() %>&fine=<%= fine %>'">
                                            Kondisi Baik
                                        </button>
                                    </div>
                                    <div class="col-md-6">
                                        <button class="book-condition-btn damaged" 
                                                onclick="window.location.href='payment.jsp?condition=rusak&bookId=<%= bookReturn.getBookId() %>&fine=<%= fine %>'">
                                            Ada Kerusakan
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <% } else { %>
                            <div class="alert alert-danger">
                                Data peminjaman tidak ditemukan. Silakan periksa kembali atau hubungi petugas.
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>