<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.code } LIST"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />

<<style>
.product-list-container {
    width: 65%;
    margin: 0 auto;
    text-align: center;
}

.product-list {
    display: grid;
    grid-template-columns: repeat(5, 1fr); /* 한 줄에 5개씩 */
    gap: 20px;
    margin-bottom: 20px;
}

.product-item {
    border: 1px solid #ddd;
    border-radius: 5px;
    padding: 15px;
    text-align: left;
}

.product-img {
    width: 100%;
    height: 150px;
    object-fit: cover;
    border-radius: 5px;
}

.product-info {
    margin-top: 10px;
}

.product-title {
    font-size: 16px;
    font-weight: bold;
}

.product-bid, .product-price, .product-bidders {
    font-size: 14px;
    margin: 5px 0;
}

.product-stats {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
    padding: 10px;
    background-color: #f8f8f8;
    border-radius: 5px;
    border: 1px solid #ddd;
}

.product-stats p {
    margin: 0;
    font-size: 16px;
    font-weight: bold;
}
</style>
<script>

window.onload = function() {
    // 상품 데이터에서 가격 정보를 가져와서 처리
    const productPrices = Array.from(document.querySelectorAll('.product-price')).map(priceElement => {
        // 가격에서 '원'을 제거하고 숫자로 변환
        return parseInt(priceElement.innerText.replace('즉시구매가: ', '').replace('원', ''));
    });

    // 평균 가격 계산
    const avgPrice = Math.floor(productPrices.reduce((total, price) => total + price, 0) / productPrices.length);

    // 가장 높은 가격과 가장 낮은 가격 계산
    const maxPrice = Math.max(...productPrices);
    const minPrice = Math.min(...productPrices);

    // HTML에 결과 표시
    document.getElementById('avgPrice').innerText = avgPrice.toLocaleString();
    document.getElementById('maxPrice').innerText = maxPrice.toLocaleString();
    document.getElementById('minPrice').innerText = minPrice.toLocaleString();
};

</script>

<section class="mt-24 text-xl px-4">
	<div class="mx-auto">

		<%-- 		${articles} --%>




		<div class="product-list-container">
				<div class="mb-4 flex">
			<div><c:choose><c:when test="${board.name != null}"> ${board.name}</c:when><c:otherwise> 검색어 ${searchKeyword }이 포함된 </c:otherwise> </c:choose>실시간상품 ${articlesCount }개 중 20개상품</div>
			<div class="flex-grow"></div>
			<!-- 			<form action="../article/list"> -->
		</div>
<div class="product-stats">
    <p>평균 가격: <span id="avgPrice"></span>원</p>
    <p>가장 높은 가격: <span id="maxPrice"></span>원</p>
    <p>가장 낮은 가격: <span id="minPrice"></span>원</p>
</div>
    <div class="product-list" id="productList">
        <c:forEach var="article" items="${articles}">
            <div class="product-item">
                <!-- 상품 이미지 -->
                <img src="${rq.getImgUri(article.id)}" alt="" class="product-img">

                <!-- 상품 정보 -->
                <div class="product-info">
                    <h3 class="product-title">${article.title}</h3>
                    <p class="product-bid">입찰가: ${article.bid}원</p>
                    <p class="product-price">즉시구매가: ${article.price}원</p>
                    <p class="product-bidders">입찰자: ${article.bidder_count}</p>
                </div>
            </div>
        </c:forEach>
    </div>
	</div>



	<!-- 	동적 페이징 -->
	<div class="pagination flex justify-center mt-3">
		<c:set var="paginationLen" value="3" />
		<c:set var="startPage" value="${page -  paginationLen  >= 1 ? page - paginationLen : 1}" />
		<c:set var="endPage" value="${page +  paginationLen  <= pagesCount ? page + paginationLen : pagesCount}" />

		<c:set var="baseUri" value="?boardId=${boardId }" />
		<c:set var="baseUri" value="${baseUri }&searchKeywordTypeCode=${searchKeywordTypeCode}" />
		<c:set var="baseUri" value="${baseUri }&searchKeyword=${searchKeyword}" />

		<c:if test="${startPage > 1 }">
			<a class="btn btn-sm" href="${ baseUri}&page=1">1</a>

		</c:if>
		<c:if test="${startPage > 2 }">
			<button class="btn btn-sm btn-disabled">...</button>
		</c:if>

		<c:forEach begin="${startPage }" end="${endPage }" var="i">
			<a class="btn btn-sm ${param.page == i ? 'btn-active' : '' }" href="${ baseUri}&page=${i }">${i }</a>
		</c:forEach>

		<c:if test="${endPage < pagesCount - 1 }">
			<button class="btn btn-sm btn-disabled">...</button>
		</c:if>

		<c:if test="${endPage < pagesCount }">
			<a class="btn btn-sm" href="${ baseUri}&page=${pagesCount }">${pagesCount }</a>
		</c:if>
	</div>


</section>

<%@ include file="../common/foot.jspf"%>
