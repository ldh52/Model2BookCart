package com.sku.cart;

public class Book 
{
	private int no;
	private String title;
	private String author;
	private String publisher;
	private java.sql.Date pubdate;
	private int price;
	private int pages;
	private String cover;
	private int qty;
	
	public Book() {}
	
	public Book(int no) {
		this.no = no;
	}
	
	public boolean equals(Object obj) {
		Book other = (Book) obj;
		return this.no == other.no;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public java.sql.Date getPubdate() {
		return pubdate;
	}
	public void setPubdate(java.sql.Date pubdate) {
		this.pubdate = pubdate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getPages() {
		return pages;
	}
	public void setPages(int pages) {
		this.pages = pages;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
}
