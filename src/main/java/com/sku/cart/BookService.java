package com.sku.cart;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BookService 
{
	private HttpServletRequest request;
	private HttpServletResponse response;
	private String[] path;
	private String uri;
	private String servletPath;
	
	public BookService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		uri = request.getRequestURI();
		path = uri.split("\\/");
		servletPath = request.getServletPath();
	}

	public String process() {
		// TODO Auto-generated method stub
		return null;
	}

}
