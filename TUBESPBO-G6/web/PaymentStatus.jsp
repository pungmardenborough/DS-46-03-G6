<%-- 
    Document   : PaymentStatus
    Created on : Jan 2, 2025, 2:11:27 AM
    Author     : CHRISTIANA NAIDA P
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Status Pembayaran</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(120deg, #fdfbfb, #ebedee);
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .status-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            padding: 40px 30px;
            text-align: center;
            width: 100%;
            max-width: 500px;
        }
        .status-icon {
            width: 100px;
            height: 100px;
            margin-bottom: 20px;
            animation: pop 0.5s ease-out;
        }
        @keyframes pop {
            0% {
                transform: scale(0);
                opacity: 0;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
        .status-message {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .status-message.success {
            color: #28a745;
        }
        .status-message.failed {
            color: #dc3545;
        }
        .status-message.pending {
            color: #ffc107;
        }
        .btn-back {
            display: inline-block;
            padding: 12px 20px;
            font-size: 18px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }
        .btn-back:hover {
            background-color: #0056b3;
            transform: translateY(-3px);
        }
    </style>
</head>
<body>
    <div class="status-container">
        <% String paymentStatus = (String) request.getAttribute("paymentStatus"); %>

        <% if (paymentStatus != null) { %>
            <% if (paymentStatus.equals("SUCCESS")) { %>
                <img src="https://i.pinimg.com/736x/de/ec/66/deec66975df4b570fa087c25f863665a.jpg" 
                     alt="Payment Success" class="status-icon">
                <div class="status-message success">Pembayaran Berhasil!</div>
            <% } else if (paymentStatus.equals("FAILED")) { %>
                <img src="https://th.bing.com/th/id/OIP.sI7tYXUnpR7XDi984X1uAQAAAA?w=190&h=190&c=7&r=0&o=5&dpr=1.5&pid=1.7" 
                     alt="Payment Failed" class="status-icon">
                <div class="status-message failed">Pembayaran Gagal!</div>
            <% } else { %>
                <img src="https://upload.wikimedia.org/wikipedia/commons/1/17/Circle-icons-clock.svg" 
                     alt="Payment Pending" class="status-icon">
                <div class="status-message pending">Pembayaran Sedang Diproses...</div>
            <% } %>
        <% } else { %>
            <img src="https://upload.wikimedia.org/wikipedia/commons/8/88/Red_cross_icon.svg" 
                 alt="Error" class="status-icon">
            <div class="status-message failed">Status Tidak Ditemukan!</div>
        <% } %>

        <a href="index.jsp" class="btn-back">Kembali ke Halaman Utama</a>
    </div>
</body>
</html>
