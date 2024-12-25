<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Index</title> 
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">
function sendPost() {
	$.ajax({
		url:'book',
		method:'POST',
		cache:false
		
	});
}

function sendPut() {
	$.ajax({
		url:'book',
		method:'PUT',
		cache:false
		
	});
}
function sendDelete() {
	$.ajax({
		url:'book',
		method:'DELETE',
		cache:false
		
	});
}
</script>
</head>
<body>
<main>
<ul>
<li>[<a href="list">도서목록</a>]</li>
</ul>
<h3>도서구매 장바구니 프로젝트</h3>
</main>
<button type="button" onclick="sendPost();">POST</button>
<button type="button" onclick="sendPut();">PUT</button>
<button type="button" onclick="sendDelete();">DELETE</button>
</body>
</html>