<%-- 
    Document   : prosesValidasi
    Created on : Jan 2, 2025, 12:19:47 AM
    Author     : CHRISTIANA NAIDA P
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistem Perpustakaan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .step-container { display: none; }
        .step-container.active { display: block; }
        .progress-step {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background-color: #e9ecef;
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        .progress-step.active {
            background-color: #0d6efd;
            color: white;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="d-flex justify-content-center align-items-center mb-4">
            <div class="progress-step active">1</div>
            <div class="mx-3">----</div>
            <div class="progress-step">2</div>
            <div class="mx-3">----</div>
            <div class="progress-step">3</div>
            <div class="mx-3">----</div>
            <div class="progress-step">4</div>
        </div>

        <div id="ValidateMamber" class="step-container active">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Form Pengembalian Buku</h5>
                        </div>
                        <div class="card-body p-4">
                            <form action="ValidateMamber" method="POST">
                                <div class="mb-3">
                                    <label class="form-label">Nama Peminjam</label>
                                    <input type="text" class="form-control" name="username" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Judul Buku</label>
                                    <input type="text" class="form-control" name="judul_buku" required>
                                </div>
                                <% 
                                    String error = (String) request.getAttribute("error");
                                    if(error != null) {
                                %>
                                <div class="alert alert-danger">
                                    <%= error %>
                                </div>
                                <% } %>
                                <button type="submit" class="btn btn-primary w-100">
                                    Lanjutkan
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>