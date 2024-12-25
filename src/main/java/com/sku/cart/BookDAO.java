package com.sku.cart;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class BookDAO 
{
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Connection getConn() 
	{
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(
	                "jdbc:oracle:thin:@localhost:1521:xe", "SCOTT", "TIGER");
			return conn;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Book> bookList() 
	{
		conn = getConn();
		String sql = "SELECT * FROM book";
		try {
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			List<Book> list = new ArrayList<Book>();
			while(rs.next()) {
				Book b = new Book();
				b.setNo(rs.getInt("NO"));
				b.setTitle(rs.getString("TITLE"));
				b.setAuthor(rs.getString("AUTHOR"));
				b.setPublisher(rs.getString("PUBLISHER"));
				b.setPubdate(rs.getDate("PUBDATE"));
				b.setPrice(rs.getInt("PRICE"));
				b.setPages(rs.getInt("PAGES"));
				b.setCover(rs.getString("COVER"));
				list.add(b);
			}
			return list;
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return null;
	}
	
	public List<Book> bookList(List<Book> nums) 
	{
		conn = getConn();
		String sNums = "";
		for(int i=0;i<nums.size();i++) {
			sNums += nums.get(i).getNo() + ",";
		}
		if(sNums.equals("")) {
			sNums = "0";
		}else {
			sNums = sNums.substring(0,sNums.lastIndexOf(","));
		}
		String sql = "SELECT * FROM book WHERE no IN(" + sNums + ")";

		try {
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			List<Book> list = new ArrayList<Book>();
			while(rs.next()) {
				Book b = new Book();
				b.setNo(rs.getInt("NO"));
				b.setTitle(rs.getString("TITLE"));
				b.setAuthor(rs.getString("AUTHOR"));
				b.setPublisher(rs.getString("PUBLISHER"));
				b.setPubdate(rs.getDate("PUBDATE"));
				b.setPrice(rs.getInt("PRICE"));
				b.setPages(rs.getInt("PAGES"));
				b.setCover(rs.getString("COVER"));
				list.add(b);
			}
			return list;
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return null;
	}
	
	public Book bookDetail(int no) 
	{
		conn = getConn();
		String sql = "SELECT * FROM book WHERE no=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Book b = new Book();
				b.setNo(rs.getInt("NO"));
				b.setTitle(rs.getString("TITLE"));
				b.setAuthor(rs.getString("AUTHOR"));
				b.setPublisher(rs.getString("PUBLISHER"));
				b.setPubdate(rs.getDate("PUBDATE"));
				b.setPrice(rs.getInt("PRICE"));
				b.setPages(rs.getInt("PAGES"));
				b.setCover(rs.getString("COVER"));
				return b;
			}
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return null;
	}
	
	public Book bookDetail(Book b) 
	{
		conn = getConn();
		String sql = "SELECT * FROM book WHERE no=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b.getNo());

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				b.setTitle(rs.getString("TITLE"));
				b.setAuthor(rs.getString("AUTHOR"));
				b.setPublisher(rs.getString("PUBLISHER"));
				b.setPubdate(rs.getDate("PUBDATE"));
				b.setPrice(rs.getInt("PRICE"));
				b.setPages(rs.getInt("PAGES"));
				b.setCover(rs.getString("COVER"));
				return b;
			}
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return null;
	}
	
	private void closeAll() {
		try {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
