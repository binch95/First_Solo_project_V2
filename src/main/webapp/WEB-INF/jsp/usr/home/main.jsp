<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="pageTitle" value="MAIN"></c:set>

<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Preview</title>
<script src="https://cdn.tailwindcss.com"></script>
<%@ include file="../common/head.jspf"%>
<style>

/* 메인 리스트 컨테이너 스타일 */
.main-list-container {
	width: 65%;
	margin: 0 auto;
	text-align: center;
}

/* 슬라이더 컨테이너 스타일 */
.slider-container {
	position: relative;
	width: 100%;
	overflow: hidden; /* 한 번에 보이는 영역만 보여주도록 숨김 처리 */
	border: 2px solid #ddd;
	border-radius: 5px;
}

/* 슬라이더 스타일 */
.slider {
	display: flex; /* 슬라이드 요소들을 가로로 나열 */
	transition: transform 0.5s ease-in-out; /* 슬라이드 이동 시 애니메이션 */
}

/* 슬라이드 아이템 (한 슬라이드의 크기) */
.slide {
	min-width: calc(100%/ 5); /* 한 슬라이드에 5개의 아이템 */
	box-sizing: border-box;
}

/* 개별 상품 아이템 스타일 */
.product-item {
	border: 1px solid #ddd;
	border-radius: 5px;
	padding: 15px;
	text-align: left;
	width: 100%; /* 상품 아이템이 슬라이드 안에서 꽉 차도록 설정 */
}

/* 상품 이미지 스타일 */
.product-img {
	width: 100%;
	height: 150px;
	object-fit: cover;
	border-radius: 5px;
}

/* 상품 정보 스타일 */
.product-info {
	margin-top: 10px;
}

/* 상품명 스타일 */
.product-title {
	font-size: 16px;
	font-weight: bold;
}

/* 가격 정보 및 입찰자 스타일 */
.product-bid, .product-price, .product-bidders {
	font-size: 14px;
	margin: 5px 0;
}

.abtn {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    padding: 10px;
    cursor: pointer;
    border-radius: 50%;
    z-index: 10;
}

.prev {
	left: 10px; /* 버튼을 슬라이더 바깥에 위치 */
}

.next {
	right: 10px; /* 버튼을 슬라이더 바깥에 위치 */
}

.abtn:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

.mainImg>img {
	width: 50%;
	height: 100vh;
	max-height: 400px;
}

.mainImg {
	max-height: 400px;
}
</style>

</head>
<body>

	<div class="mainImg border flex justify-center">
		<img src="${pageContext.request.contextPath}/resource/images/main/main.png" alt="">
	</div>

	<script src="/resource/mainSlideBtn.js"></script>

	<div class="main-list-container">

		<div class="slider-container" id="slider1-container">
			<button class="prev abtn" onclick="prevSlide(1)">&#10094;</button>
			<!-- 버튼이 슬라이더 바깥에 위치 -->
			<button class="next abtn" onclick="nextSlide(1)">&#10095;</button>

			<div class="slider" id="slider1">
				<c:forEach var="article" items="${articles}">
					<div class="slide">
						<!-- 상품 이미지 -->
						<div class="product-item">
							<img src="/common/genFile/file/article/1526/extra/Img/1" alt="" class="product-img">
						</div>

						<div class="product-info">
							<h3 class="product-title">${article.title}</h3>
							<p class="product-bid">입찰가: ${article.bid}원</p>
							<p class="product-price">즉시구매가: ${article.price}원</p>
							<p class="product-bidders">입찰수: ${article.bidder_count}명</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

		<div class="slider-container" id="slider1-container">
			<button class="prev abtn" onclick="prevSlide(2)">&#10094;</button>
			<!-- 버튼이 슬라이더 바깥에 위치 -->
			<button class="next abtn" onclick="nextSlide(2)">&#10095;</button>

			<div class="slider" id="slider2">
				<c:forEach var="article" items="${articles}">
					<div class="slide">
						<!-- 상품 이미지 -->
						<div class="product-item">
							<img src="/common/genFile/file/article/1526/extra/Img/1" alt="" class="product-img">
						</div>

						<div class="product-info">
							<h3 class="product-title">${article.title}</h3>
							<p class="product-bid">입찰가: ${article.bid}원</p>
							<p class="product-price">즉시구매가: ${article.price}원</p>
							<p class="product-bidders">입찰수: ${article.bidder_count}명</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
<%@ include file="../common/foot.jspf"%>