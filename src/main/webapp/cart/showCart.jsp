<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>장바구니 보기</title>
<style type="text/css">
	table { border-collapse: collapse; border-spacing: 0; }
	tr:first-child, tr:last-child { background-color:#dfd; }
	th,td{padding:0.3em 1em; border:1px dashed black; }
	td#total_cell { text-align:right;font-weight:bolder; }
	td.sum_label { text-align:right; font-weight: bolder;}
	input[type=number] {width:2em;}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">
function changeQty(no) {
	var obj = {};
	obj.no = no;
	obj.qty = $('#qty'+no).val();

	$.ajax({
		url:'updateQty/'+no+'/'+obj.qty,
		method:'get',
		cache:false,
		data:obj,
		dataType:'json',
		success:function(res){
			alert(res.updated ? '수량변경 성공':'실패');
			if(res.updated) location.href='showcart';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}

function deleteBook() {
	var arr = $('#cb:checked').map(function() {
		return $(this).val();
	});

	var strValue='';
	for(var i=0;i<arr.length;i++){ 
		strValue += (arr[i]+',');
	}
	var obj = {};
	obj.delitems = strValue;

	$.ajax({
		url:'delItems',
		method:'post',
		cache:false,
		data:obj,
		dataType:'json',
		success:function(res){
			alert(res.deleted ? '삭제 성공':'실패');
			if(res.deleted) location.href="showcart";
		},
		error:function(xhr,status,err){
			alert('에러:' + err)
		}
	});
}
</script>
</head>
<body>
<main>
	<h3>장바구니 보기</h3>
	<table>
	<tr><th>도서번호</th><th>제목</th><th>저자</th><th>출판사</th><th>출판일</th><th>가격</th><th>수량</th>
		<th><button onclick="deleteBook();">선택삭제</button></th>
	</tr>
	<c:forEach var="b" items="${list}" varStatus="status">
		<tr><td>${b.no}</td><td>${b.title}</td><td>${b.author}</td><td>${b.publisher}</td>
				<td>${b.pubdate}</td><td class="price_cell">${b.price}</td>
				<td><input type="number" id="qty${b.no}" value="${b.qty}">
					<button onclick="changeQty(${b.no});">적용</button>
				</td>
				<td><input type="checkbox" name="cb" id="cb" value="${b.no}"></td>
		</tr>
	</c:forEach>
	<fmt:formatNumber var="ttl" value="${total}" type="currency" currencySymbol="\\"/>
	<tr><td colspan="4"><td class="sum_label">합계</td><td id="total_cell">${ttl}</td><td></td></tr>
	</table>
	<p>
	<a href="list"><button>목록보기</button></a>
</main>
</body>
</html>