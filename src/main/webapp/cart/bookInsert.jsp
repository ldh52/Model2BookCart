<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 책 등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        $("#add-book-btn").click(function() {
            let formData = {
                title: $("#title").val(),
                author: $("#author").val(),
                publisher: $("#publisher").val(),
                pubdate: $("#pubdate").val(),
                price: $("#price").val(),
                pages: $("#pages").val()
            };

            $.ajax({
                url: "/book/create", 
                type: "POST", 
                contentType: "application/json",
                data: JSON.stringify(formData), 
                success: function(response) {
                    if (response.success) { // 서버 응답에 success 필드 확인
                        alert("책이 성공적으로 추가되었습니다.");
                        location.href = "/book/list"; 
                    } else {
                        alert("책 추가에 실패했습니다: " + response.message); 
                    }
                },
                error: function() {
                    alert("책 추가 요청 중 오류가 발생했습니다.");
                }
            });
        });
    });
</script>
</head>
<body>
    <h2>새 책 등록</h2>

    <form id="add-book-form">
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" required><br>

        <label for="author">저자:</label>
        <input type="text" id="author" name="author" required><br>

        <label for="publisher">출판사:</label>
        <input type="text" id="publisher" name="publisher" required><br>

        <label for="pubdate">출판일:</label>
        <input type="date" id="pubdate" name="pubdate" required><br>

        <label for="price">가격:</label>
        <input type="number" id="price" name="price" required><br>

        <label for="pages">총 페이지 수:</label>
        <input type="number" id="pages" name="pages" required><br>

        <button type="button" id="add-book-btn">등록</button>
    </form>

    <a href="book/list">목록으로 돌아가기</a> 
</body>
</html>