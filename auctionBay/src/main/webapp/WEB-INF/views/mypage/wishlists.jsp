<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 찜목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
	<link rel="stylesheet" href="/css/common.css">
	<style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; color: #333; }
        
        .container { width: 1200px; margin: 30px auto; position: relative; }

        .wishlist-header-title {
            font-size: 28px;
            font-weight: bold;
            font-style: italic;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 25px;
            color: #000;
        }

        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 15px;
            margin-bottom: 40px;
            padding-right: 90px;
        }

        .product-card {
            background-color: #fff;
            border-radius: 4px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            cursor: pointer;
        }
        
        .product-img {
            width: 100%;
            height: 150px;
            background-color: #d1d1d1;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #777;
            font-size: 12px;
        }

        .product-info {
            padding: 10px;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .product-title-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
        }
        .product-title {
            font-weight: normal;
            color: #333;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            max-width: 100px;
        }
        .trade-type {
            font-size: 11px;
            color: #666;
        }
        .product-price {
            font-size: 14px;
            font-weight: bold;
            color: #000;
            margin-top: 2px;
        }

        .empty-wishlist {
            grid-column: span 5;
            text-align: center;
            padding: 60px;
            background-color: #e2e2e2;
            border-radius: 6px;
            color: #666;
            font-size: 15px;
        }

		.right-quick-menu {
		    position: absolute;
		    top: 120px;   /* 60px -> 120px로 조정, 필요하면 더 크게 */
		    right: 0;
		    width: 75px;
		    background-color: #ffeef4;
		    border: 1px solid #ffccd5;
		    border-radius: 6px;
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    padding: 15px 0;
		    gap: 20px;
		    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
		}
        .quick-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;
            color: #333;
            font-size: 11px;
            font-weight: bold;
            gap: 5px;
            position: relative;
        }
        .quick-icon { font-size: 22px; }
        .badge {
            position: absolute;
            top: -2px;
            right: 8px;
            background-color: #000;
            color: #fff;
            font-size: 9px;
            padding: 1px 4px;
            border-radius: 50%;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
            margin-top: 30px;
            padding-right: 90px;
        }
        .page-btn {
            padding: 5px 10px;
            border: 1px solid #ddd;
            background-color: #fff;
            color: #333;
            text-decoration: none;
            border-radius: 3px;
            font-size: 12px;
        }
        .page-btn.active {
            background-color: #000;
            color: #fff;
            border-color: #000;
            font-weight: bold;
        }
        .page-btn:hover:not(.active) { background-color: #f1f1f1; }
    </style>
</head>
<body>

<div class="container">
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <main style="margin-top: 30px;">
        <div class="wishlist-header-title">WISHLISTS</div>

        <div class="wishlist-grid">
            <c:choose>
                <c:when test="${not empty wishlist}">
                    <c:forEach var="item" items="${wishlist}">
                       
                        <div class="product-card" onclick="location.href='${pageContext.request.contextPath}/auction/${item.productNo}/detail'">
                            <div class="product-img">
                                <c:choose>
                                    <c:when test="${not empty item.mainImage}">
                                        <img src="${item.mainImage}" alt="상품 이미지" style="width:100%; height:100%; object-fit:cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <span>[이미지 영역]</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="product-info">
                                <div class="product-title-row">
                                    <span class="product-title">${item.title}</span>
                                    <span class="trade-type">
                                        <c:choose>
                                            <c:when test="${item.tradeType == 'BUY'}">구매</c:when>
                                            <c:when test="${item.tradeType == 'SELL'}">판매</c:when>
                                            <c:otherwise>경매</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="product-price">
                                    ${item.price}원
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-wishlist">
                        찜한 상품이 없습니다.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <aside class="right-quick-menu">
            <!-- 수정: /member/wishlist -> /mypage/wishlists (실제 매핑과 일치, 이 페이지 자기 자신) -->
            <a href="${pageContext.request.contextPath}/mypage/wishlists" class="quick-item">
                <span class="quick-icon">❤️</span>
                <span>찜목록</span>
            </a>
            <a href="${pageContext.request.contextPath}/message/received" class="quick-item">
                <span class="quick-icon">✉️</span>
                <span>쪽지함</span>
                <span class="badge">1</span>
            </a>
            <!-- 수정: /mypage/recent -> /mypage/recents (실제 매핑과 일치) -->
            <a href="${pageContext.request.contextPath}/mypage/recents" class="quick-item">
                <span class="quick-icon">⏱️</span>
                <span>최근 본 글</span>
            </a>
        </aside>

        <div class="pagination">
            <a class="page-btn" href="#">&lt; 이전</a>
            <a class="page-btn active" href="#">1</a>
            <a class="page-btn" href="#">2</a>
            <a class="page-btn" href="#">3</a>
            <a class="page-btn" href="#">4</a>
            <a class="page-btn" href="#">5</a>
            <a class="page-btn" href="#">다음 &gt;</a>
        </div>
    </main>

    <div style="margin-top: 50px;">
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>
</div>

</body>
</html>
