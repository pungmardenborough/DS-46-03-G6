package model;

import java.time.LocalDate;

public class peminjaman {
    private String username;
    private int bookId;
    private String judul_buku;
    private int quantity;
    private LocalDate borrowDate;
    private LocalDate dueDate;
    private String status;
    private int denda;
    

    // Constructor
    public peminjaman(int bookId, String username, String judul_buku, int quantity, LocalDate borrowDate, LocalDate dueDate, String status, int denda) {
        this.username = username;
        this.bookId = bookId;
        this.judul_buku = judul_buku;
        this.quantity = quantity;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.status = status;
        this.denda = denda;
        
    }

    // Getters and Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getJudul_buku() {
        return judul_buku;
    }

    public void setJudul_buku(String judul_buku) {
        this.judul_buku = judul_buku;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public LocalDate getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(LocalDate borrowDate) {
        this.borrowDate = borrowDate;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getDenda() {
        return denda;
    }

    public void setDenda(int denda) {
        this.denda = denda;
    }

}

