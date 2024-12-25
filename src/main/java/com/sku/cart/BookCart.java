package com.sku.cart;

import java.util.*;

public class BookCart
{
	private List<Book> list = new ArrayList<>();
	
	public boolean add(Book b) {
		Book found = find(b);
		
		if(found==null) list.add(b);
		else {
			found.setQty(found.getQty()+b.getQty());
		}
		return true;
	}
	
	public Book find(Book b) {
		if(list.contains(b)) {
			return list.get(list.indexOf(b));
		}
		return null;
	}
	
	public int getTotalPrice() {
		int total = 0;
		for(int i=0;i<list.size();i++) {
			total += list.get(i).getPrice()*list.get(i).getQty();
		}
		return total;
	}
	
	public List<Book> showCart() {
		BookDAO dao = new BookDAO();
		List<Book> sList = dao.bookList(list); 
		for(int i=0;i<sList.size();i++) {
			sList.get(i).setQty(list.get(i).getQty());
		}
		list = sList;
		return list;
	}
	
	public List<Book> getItems() {
		return list;
	}
	
	public boolean updateQty(Book b) {
		if(list.contains(b)) {
			Book found = list.get(list.indexOf(b));
			found.setQty(b.getQty());
			return true;
		}
		return false;
	}
	
	public boolean deleteItems(String delItems) {
		String[] items = delItems.trim().split("\\,");
		int delcnt = items.length;
		int cnt = 0;
		for(int i=0;i<items.length;i++) {
			int no = Integer.parseInt(items[i]);
			Book delbook = new Book(no);
			if(list.contains(delbook)) {
				list.remove(delbook);
				cnt++;
			}
		}
		return delcnt==cnt;
	}
}
