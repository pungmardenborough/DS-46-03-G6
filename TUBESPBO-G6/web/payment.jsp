<%-- 
    Document   : payment
    Created on : Jan 2, 2025, 2:10:36 AM
    Author     : CHRISTIANA NAIDA P
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detail Pembayaran</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
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
            transition: all 0.3s;
        }
        .progress-step.active {
            background-color: #0d6efd;
            color: white;
            transform: scale(1.1);
            box-shadow: 0 0 10px rgba(13, 110, 253, 0.3);
        }
        .progress-step.completed {
            background-color: #198754;
            color: white;
        }
        .payment-option {
            border: 2px solid #dee2e6;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            background-color: white;
        }
        .payment-option:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-color: #0d6efd;
        }
        .payment-option.selected {
            border-color: #0d6efd;
            background-color: #f8f9fa;
            box-shadow: 0 5px 15px rgba(13, 110, 253, 0.2);
        }
        .payment-logo {
            width: 100px;
            height: 50px;
            object-fit: contain;
            margin-right: 20px;
        }
        .va-number {
            font-family: monospace;
            font-size: 26px;
            letter-spacing: 2px;
            color: #0d6efd;
            background: #f8f9fa;
            padding: 8px 15px;
            border-radius: 8px;
            margin-top: 5px;
        }
        .fee-card {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .total-fee {
            background: linear-gradient(145deg, #dc3545 0%, #bb2d3b 100%);
            color: white;
            border-radius: 12px;
            padding: 20px;
        }
        .total-fee h4 {
            margin: 0;
            font-size: 28px;
        }
        .btn-payment {
            padding: 12px 20px;
            font-size: 18px;
            border-radius: 10px;
            transition: all 0.3s;
        }
        .btn-payment:not(:disabled):hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
        }
    </style>
</head>
<body class="bg-light">
    <%
        // Inisialisasi variabel
        int lateFee = 0;
        int damageFee = 0;
        
        try {
            // Ambil dueDate dari attribute (dari servlet)
            Date dueDate = (Date) request.getAttribute("dueDate");
            String condition = request.getParameter("condition");
            
            // Hitung denda keterlambatan
            if (dueDate != null) {
                Date returnDate = new Date(); // Tanggal hari ini
                
                if (returnDate.after(dueDate)) {
                    long diffInMillis = returnDate.getTime() - dueDate.getTime();
                    long daysLate = diffInMillis / (1000 * 60 * 60 * 24); // Konversi ke hari
                    lateFee = (int)(daysLate * 5000); // Rp 5.000 per hari
                }
            }
            
            // Cek kondisi buku
            if ("damaged".equals(condition)) {
                damageFee = 50000; // Rp 50.000 untuk buku rusak
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Hitung total
        int totalFee = lateFee + damageFee;
    %>

    <div class="container py-5">
        <!-- Progress Steps -->
        <div class="d-flex justify-content-center align-items-center mb-5">
            <div class="progress-step completed">1</div>
            <div class="mx-3">----</div>
            <div class="progress-step completed">2</div>
            <div class="mx-3">----</div>
            <div class="progress-step active">3</div>
            <div class="mx-3">----</div>
            <div class="progress-step">4</div>
        </div>

        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-danger text-white py-3">
                        <h5 class="mb-0 fw-bold">Rincian Pembayaran</h5>
                    </div>
                    <div class="card-body p-4">
                        <!-- Denda Section -->
                        <div class="row g-4 mb-4">
                            <div class="col-md-6">
                                <div class="fee-card">
                                    <label class="text-muted mb-2">Denda Keterlambatan</label>
                                    <div class="fw-bold fs-4">
                                        Rp 35.000
                                    </div>
                                    <small class="text-muted">
                                        <%= lateFee > 35.000 ? "Denda Rp 5.000/hari" : "Keterlambatan 7 hari" %>
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="fee-card">
                                    <label class="text-muted mb-2">Denda Kerusakan</label>
                                    <div class="fw-bold fs-4">
                                        Rp <%= String.format("%,d", damageFee) %>
                                    </div>
                                    <small class="text-muted">
                                        <%= damageFee > 0 ? "Biaya perbaikan buku" : "Tidak ada kerusakan" %>
                                    </small>
                                </div>
                            </div>
                        </div>

                        <!-- Total Amount -->
                        <div class="total-fee mb-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="text-white-50 mb-1">Total Pembayaran</div>
                                    <%
                                        int totalAmount = 35000; // Denda keterlambatan default
                                        String condition = request.getParameter("condition");

                                        // Jika ada kerusakan, tambahkan denda 50000
                                        if ("damaged".equals(condition)) {
                                            totalAmount += 50000;
                                        }
                                    %>
                                    <h4>Rp <%= String.format("%,d", totalAmount) %></h4>
                                    <small class="text-white-50">
                                        <%= "damaged".equals(condition) ? 
                                            "Denda Keterlambatan (Rp 35.000) + Denda Kerusakan (Rp 50.000)" : 
                                            "Denda Keterlambatan (Rp 35.000)" %>
                                    </small>
                                </div>
                            </div>
                        </div>

                        <!-- Payment Method -->
                        <form action="ProcessPayment" method="POST">
                            <input type="hidden" name="selectedBank" id="selectedBank">
                            <input type="hidden" name="totalFee" value="<%= totalFee %>">
                            <input type="hidden" name="lateFee" value="<%= lateFee %>">
                            <input type="hidden" name="damageFee" value="<%= damageFee %>">
                            
                            <h6 class="mb-3 fw-bold">Pilih Metode Pembayaran</h6>
                            
                            <!-- Virtual Account Section -->
                            <div class="mb-4">
                                <div class="fw-bold text-muted mb-2">Virtual Account</div>
                                
                                <!-- BCA VA -->
                                <div class="payment-option" data-bank="bca">
                                    <div class="d-flex align-items-center">
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/5/5c/Bank_Central_Asia.svg" 
                                             alt="BCA" class="payment-logo">
                                        <div class="flex-grow-1">
                                            <div class="fw-bold fs-5 mb-1">BCA Virtual Account</div>
                                            <div class="va-number">880012345678</div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Mandiri VA -->
                                <div class="payment-option" data-bank="mandiri">
                                    <div class="d-flex align-items-center">
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/a/ad/Bank_Mandiri_logo_2016.svg" 
                                             alt="Mandiri" class="payment-logo">
                                        <div class="flex-grow-1">
                                            <div class="fw-bold fs-5 mb-1">Mandiri Virtual Account</div>
                                            <div class="va-number">890012345678</div>
                                        </div>
                                    </div>
                                </div>

                                <!-- BNI VA -->
                                <div class="payment-option" data-bank="bni">
                                    <div class="d-flex align-items-center">
                                        <img src="https://upload.wikimedia.org/wikipedia/id/5/55/BNI_logo.svg" 
                                             alt="BNI" class="payment-logo">
                                        <div class="flex-grow-1">
                                            <div class="fw-bold fs-5 mb-1">BNI Virtual Account</div>
                                            <div class="va-number">881012345678</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- E-Wallet Section -->
                            <div class="mb-4">
                                <div class="fw-bold text-muted mb-2">E-Wallet</div>
                                
                                <!-- DANA -->
                                <div class="payment-option" data-bank="dana">
                                    <div class="d-flex align-items-center">
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/7/72/Logo_dana_blue.svg" 
                                             alt="DANA" class="payment-logo">
                                        <div class="flex-grow-1">
                                            <div class="fw-bold fs-5 mb-1">DANA</div>
                                            <div class="va-number">08123456789</div>
                                        </div>
                                    </div>
                                </div>

                                <!-- ShopeePay -->
                                <div class="payment-option" data-bank="shopeepay">
                                    <div class="d-flex align-items-center">
                                        <img src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg0xEliVy5hQoWdaJ1rgGiR12103fUsC_7iaw-gS6RUF2HDmlF9gBwDiJtvfA935bVAfJHY1VHvmF9ROUBqzm5JJIID1fITP7-20s-RwEwlFTJ8RUQ9n_XbBjoPhwaf-RQQoU0XUnCvSPIK/s320/Shopee+Pay.png"
                                             alt="ShopeePay" class="payment-logo">
                                        <div class="flex-grow-1">
                                            <div class="fw-bold fs-5 mb-1">ShopeePay</div>
                                            <div class="va-number">08123456789</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-danger btn-payment w-100 mt-4" id="payButton" disabled>
                                Bayar Sekarang
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.querySelectorAll('.payment-option').forEach(option => {
            option.addEventListener('click', function() {
                document.querySelectorAll('.payment-option').forEach(opt => {
                    opt.classList.remove('selected');
                });
                this.classList.add('selected');
                document.getElementById('selectedBank').value = this.dataset.bank;
                document.getElementById('payButton').disabled = false;
            });
        });
    </script>
</body>
</html>