<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 정보 확인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
<script>
    $(document).ready(function() {
        $("#order-confirm-btn").click(function() {
            // 주문 확인 및 서버 전송 로직
            let orderData = {
                cartItems: [],
                shippingAddress: {
                    recipientName: $("#recipientName").val(),
                    address: $("#address").val(),
                    postalCode: $("#postalCode").val(),
                    phoneNumber: $("#phoneNumber").val()
                },
                paymentMethod: $("#paymentMethod").val() 
                // ... 필요한 경우 추가 정보 (예: 쿠폰, 요청 사항 등)
            };

            // 장바구니 항목 정보 추가
            <c:forEach var="cartItem" items="${cartItems}"> 
                orderData.cartItems.push({
                    bookId: ${cartItem.book.no}, // cartItem에서 book.no를 사용하여 bookId 가져오기
                    qty: ${cartItem.qty}
                });
            </c:forEach>

            $.ajax({
                url: "/cart/order",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(orderData),
                success: function(response) {
                    alert("주문이 완료되었습니다.");
                    location.href = "/order/complete"; 
                },
                error: function(xhr) {
                    if (xhr.status === 400) {
                        alert("잘못된 요청입니다. 입력 값을 확인해주세요.");
                    } else {
                        alert("주문에 실패했습니다. 잠시 후 다시 시도해주세요.");
                    }
                }
            });
        });
    });
</script>
</head>
<body>
    <h2>주문 정보 확인</h2>

    <h3>주문 상품</h3>
    <table>
        <tr>
            <th>책 제목</th>
            <th>가격</th>
            <th>수량</th>
            <th>합계</th>
        </tr>
        <c:forEach var="cartItem" items="${cartItems}">
            <tr>
                <td>${cartItem.book.title}</td>
                <td>${cartItem.book.price}</td>
                <td>${cartItem.qty}</td>
                <td>${cartItem.book.price * cartItem.qty}</td>
            </tr>
        </c:forEach>
    </table>

    <p>총 결제 금액: <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</p>

    <h3>배송 정보</h3>
    <form id="shipping-form">
        <label for="recipientName">수령인:</label>
        <input type="text" id="recipientName" name="recipientName" required><br>

        <label for="address">주소:</label>
        <input type="text" id="address" name="address" required><br>

        <label for="postalCode">우편번호:</label>
        <input type="text" id="postalCode" name="postalCode" required><br>

        <label for="phoneNumber">전화번호:</label>
        <input type="tel" id="phoneNumber" name="phoneNumber" required><br>
    </form>

    <h3>결제 정보</h3>
    <select id="paymentMethod">
        <option value="creditCard">신용카드</option>
        <option value="bankTransfer">계좌이체</option>
        </select>
    <br>

    <button id="order-confirm-btn">주문 확인</button>
</body>
</html>