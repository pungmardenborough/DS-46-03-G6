package model;

import java.util.Date;

public class bookReturn {
    private String returnId;
    private String borrowerName;
    private String bookTitle;
    private Date borrowDate;
    private Date dueDate;
    private int latedays;
    private String condition;
    private double lateFine;
    private double damageFine;
    private double totalFine;
    private String paymentMethod;
    private String paymentStatus;

    // Getters and Setters
    public String getReturnId() { return returnId; }
    public void setReturnId(String returnId) { this.returnId = returnId; }
    
    public String getBorrowerName() { return borrowerName; }
    public void setBorrowerName(String borrowerName) { this.borrowerName = borrowerName; }
    
    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }
    
    public Date getBorrowDate() { return borrowDate; }
    public void setBorrowDate(Date borrowDate) { this.borrowDate = borrowDate; }
    
    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }
    
    public int getLatedays() { return latedays; }
    public void setLatedays(int latedays) { this.latedays = latedays; }
    
    public String getCondition() { return condition; }
    public void setCondition(String condition) { this.condition = condition; }
    
    public double getLateFine() { return lateFine; }
    public void setLateFine(double lateFine) { this.lateFine = lateFine; }
    
    public double getDamageFine() { return damageFine; }
    public void setDamageFine(double damageFine) { this.damageFine = damageFine; }
    
    public double getTotalFine() { return totalFine; }
    public void setTotalFine(double totalFine) { this.totalFine = totalFine; }
    
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
}