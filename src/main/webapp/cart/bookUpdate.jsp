<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 정보 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        // 필요한 경우, 수정할 책 정보를 서버에서 가져와서 폼에 미리 채워 넣는 로직 추가 (예: AJAX GET 요청)

        $("#update-btn").click(function() {
            let formData = {
                bookId: ${book.no}, 
                title: $("#title").val(),
                author: $("#author").val(),
                publisher: $("#publisher").val(),
                pubdate: $("#pubdate").val(),
                price: $("#price").val(),
                pages: $("#pages").val()
            };

            $.ajax({
                url: "/book/update", 
                type: "PUT", 
                contentType: "application/json",
                data: JSON.stringify(formData), 
                success: function(response) {
                    alert("책 정보가 수정되었습니다.");
                    location.href = "/book/list"; 
                },
                error: function(xhr) {
                    if (xhr.status === 400) {
                        alert("잘못된 요청 데이터입니다. 입력 값을 확인해주세요.");
                    } else if (xhr.status === 404) {
                        alert("해당 책을 찾을 수 없습니다.");
                    } else {
                        alert("책 정보 수정에 실패했습니다.");
                    }
                }
            });
        });
    });
</script>
</head>
<body>
    <h2>책 정보 수정</h2>

    <form id="update-form">
        <input type="hidden" id="bookId" value="${book.no}"> 

        <label for="title">제목:</label>
        <input type="text" id="title" value="${book.title}" required><br>

        <label for="author">저자:</label>
        <input type="text" id="author" value="${book.author}" required><br>

        <label for="publisher">출판사:</label>
        <input type="text" id="publisher" value="${book.publisher}" required><br>

        <label for="pubdate">출판일:</label>
        <input type="date" id="pubdate" value="<fmt:formatDate value='${book.pubdate}' pattern='yyyy-MM-dd' />" required><br>

        <label for="price">가격:</label>
        <input type="number" id="price" value="${book.price}" required><br>

        <label for="pages">총 페이지 수:</label>
        <input type="number" id="pages" value="${book.pages}" required><br>

        <button type="button" id="update-btn">수정</button>
    </form>

    <a href="book/list">목록으로 돌아가기</a> 
</body>
</html>