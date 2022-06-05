package com.virtusa.kafka;

public class Order {
	
	private int isbn;
	public Order() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Order(int isbn, String prodName) {
		super();
		this.isbn = isbn;
		this.prodName = prodName;
	}
	public int getIsbn() {
		return isbn;
	}
	public void setIsbn(int isbn) {
		this.isbn = isbn;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	private String prodName;
}
