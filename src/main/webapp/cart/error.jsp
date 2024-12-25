<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류 발생</title>
<style>
    body {
        font-family: sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        margin: 0;
        background-color: #f0f0f0;
    }

    .error-container {
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        padding: 30px;
        text-align: center;
    }

    h1 {
        color: #d32f2f; /* 빨간색 */
    }

    p {
        margin-bottom: 20px;
    }

    a {
        color: #007bff; /* 파란색 */
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
    <div class="error-container">
        <h1>죄송합니다. 오류가 발생했습니다.</h1>
        <p>${error}</p> <%-- 서블릿에서 설정된 에러 메시지 표시 --%>
        <a href="/book/list">책 목록으로 돌아가기</a>
    </div>
</body>
</html>