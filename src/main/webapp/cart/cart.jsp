<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
<script>
    $(document).ready(function() {
        loadCartItems(); // 페이지 로드 시 장바구니 항목 불러오기
        updateTotalPrice(); // 초기 총 결제 금액 계산 및 표시

        $(document).on("click", ".update-qty-btn", function() {
            let $button = $(this);
            let bookId = $button.data("book-id"); 
            let newQty = $button.closest("tr").find(".qty-input").val();

            if (isNaN(newQty) || newQty <= 0) {
                alert("수량은 0보다 큰 숫자여야 합니다.");
                return; 
            }

            $.ajax({
                url: "/cart/update/" + bookId, 
                type: "PUT", 
                contentType: "application/json",
                data: JSON.stringify({ qty: parseInt(newQty) }), 
                success: function(response) {
                    updateCartItem(bookId, newQty, response.itemTotal); 
                    updateTotalPrice();
                },
                error: function(xhr) {
                    if (xhr.status === 400) {
                        alert("잘못된 요청입니다. 입력 값을 확인해주세요.");
                    } else if (xhr.status === 404) {
                        alert("해당 장바구니 항목을 찾을 수 없습니다.");
                    } else {
                        alert("수량 변경에 실패했습니다. 잠시 후 다시 시도해주세요.");
                    }
                }
            });
        });

        $(document).on("click", ".delete-btn", function() {
            let $button = $(this);
            let bookId = $button.data("book-id"); 

            $.ajax({
                url: "/cart/delete/" + bookId, 
                type: "DELETE", 
                success: function(response) {
                    $button.closest("tr").remove(); 
                    updateTotalPrice(); 
                },
                error: function() {
                    alert("삭제에 실패했습니다.");
                }
            });
        });

        $("#order-btn").click(function() {
            // 1. 장바구니에 항목이 있는지 확인
            if ($(".cart-item-row").length === 0) {
                alert("장바구니가 비어 있습니다. 상품을 추가해주세요.");
                return;
            }

            // 2. 주문 정보 수집 (필요한 경우 - 예: 배송지 정보, 결제 정보 등)
            let orderData = {
                cartItems: [], 
                shippingAddress: {
                    recipientName: $("#recipientName").val(),
                    address: $("#address").val(),
                    postalCode: $("#postalCode").val(),
                    phoneNumber: $("#phoneNumber").val()
                },
                paymentMethod: {
                    type: $("input[name='paymentMethod']:checked").val(), 
                }
                // ... 기타 필요한 정보 (예: 쿠폰 정보, 요청 사항 등)
            };

            // 장바구니 항목 정보 수집
            $(".cart-item-row").each(function() {
                let bookId = $(this).data("book-id");
                let qty = parseInt($(this).find(".qty-input").val());
                orderData.cartItems.push({ bookId: bookId, qty: qty });
            });

            // 3. 서버에 주문 요청 전송
            $.ajax({
                url: "/cart/order",
                type: "POST",
                contentType: "application/json", 
                data: JSON.stringify(orderData), 
                success: function(response) {
                    alert("주문이 완료되었습니다.");
                    clearCart(); 
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

    function loadCartItems() {
        $.ajax({
            url: "/cart/list", 
            type: "GET",
            success: function(response) {
                displayCartItems(response); 
                updateTotalPrice(); 
            },
            error: function() {
                alert("장바구니 정보를 불러오는 데 실패했습니다.");
            }
        });
    }

    function displayCartItems(cartItems) {
        let cartItemsHtml = "";
        for (let cartItem of cartItems) {
            cartItemsHtml += "<tr class='cart-item-row' data-book-id='" + cartItem.book.no + "'>"; 
            cartItemsHtml += "<td>" + cartItem.book.title + "</td>";
            cartItemsHtml += "<td>" + cartItem.book.price + "</td>";
            cartItemsHtml += "<td>";
            cartItemsHtml += "<input type='number' class='qty-input' value='" + cartItem.qty + "' min='1'>";
            cartItemsHtml += "<button class='update-qty-btn' data-book-id='" + cartItem.book.no + "'>수정</button>"; 
            cartItemsHtml += "</td>";
            cartItemsHtml += "<td>" + (cartItem.book.price * cartItem.qty) + "</td>"; 
            cartItemsHtml += "<td>";
            cartItemsHtml += "<button class='delete-btn' data-book-id='" + cartItem.book.no + "'>삭제</button>"; 
            cartItemsHtml += "</td>";
            cartItemsHtml += "</tr>";
        }
        $("table tbody").html(cartItemsHtml); 
    }

    function updateCartItem(bookId, newQty, itemTotal) {
        let row = $(`tr[data-book-id="${bookId}"]`); 
        row.find(".qty-input").val(newQty);
        row.find("td:nth-child(4)").text(itemTotal); 
    }

    function updateTotalPrice() {
        let totalPrice = 0;
        $(".cart-item-row").each(function() {
            let itemPrice = parseInt($(this).find("td:nth-child(2)").text());
            let itemQty = parseInt($(this).find(".qty-input").val());
            totalPrice += itemPrice * itemQty;
        });
        $("#total-price").text(totalPrice.toLocaleString() + "원"); 
    }

    // 장바구니 비우기 함수
    function clearCart() {
        $("table tbody").empty();
        updateTotalPrice();
    }
</script>
</head>
<body>
    <h2>장바구니</h2>

    <table>
        <tr>
            <th>책 제목</th>
            <th>가격</th>
            <th>수량</th>
            <th>합계</th>
            <th></th> 
        </tr>
        <tbody></tbody> 
    </table>

    <p>총 결제 금액: <span id="total-price"></span></p> 

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

    <button id="order-btn">주문하기</button>

    <a href="book/list">쇼핑 계속하기</a> 
</body>
</html>