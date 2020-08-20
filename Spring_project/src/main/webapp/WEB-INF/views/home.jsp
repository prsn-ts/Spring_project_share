<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 레시피</title>
<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<!-- customize css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<!-- 글씨체 관련 -->
<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
<!-- 아이콘 관련 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome-4.7.0/css/font-awesome.min.css">
<!-- JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
	<%-- jsp:include(header) --%>
	<jsp:include page="include/header.jsp">
		<jsp:param value="index" name="thisPage"/>
	</jsp:include>
	
	<div class="container_outer" style="background-color: #E6E6E6;">
		<div class="container" >
			<div class="pb-4"></div>
			<div class="row_all p-3" style="border: 1px solid #f2f2f2; background-color: #f2f2f2;">
				<div>
					<div class="carousel_title">
						<div style="color: black; font-size: 20px; padding:10px;">요리</div>
					</div>
					<div id="carouselExampleCaptions" class="carousel slide mb-4" data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
							<li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
							<li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
						</ol>
						<div class="carousel-inner border border-warning">
							<div class="carousel-item active">
								<a href="javascript:linkrandom()">
								<img src="resources/images/indexbg1.jpg" class="d-block w-100" style="height: 400px" alt="...">
								</a>
								<div class="carousel-caption d-none d-md-block">
								</div>
							</div>
							<div class="carousel-item">
								<img src="https://i.ytimg.com/vi/QmYtkgL5JAA/maxresdefault.jpg" class="d-block w-100" style="height: 400px"  alt="...">
								<div class="carousel-caption d-none d-md-block">
								</div>
							</div>
							<div class="carousel-item">
								<img src="resources/images/ad3.png" class="d-block w-100" style="height: 400px" alt="...">
								<div class="carousel-caption d-none d-md-block">
								</div>
							</div>
						</div>
						<a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true" style="width: 40px; height:40px;"></span>
							<span class="sr-only">Previous</span>
						</a>
						<a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true" style="width: 40px; height:40px;"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>
				</div>
			</div>
			<div class="pt-4"></div>
		</div>
	
		<div class="container">
			<div class="pb-4"></div>
			<div class="row_all p-3" style="border: 1px solid #dfdfdf; background-color: #f2f2f2;">
				<div class="card-deck mb-4 h-100">
					<div class="card">
						<img src="resources/images/cook1.png" class="card-img-top first_card" class="card-img-top" alt="...">
						<div class="card-body" style="cursor: pointer;" onclick="location.href='cook/cooking1.do';">
							<h5 class="card-title">자네 오늘은 쭈꾸미 볶음 어떤가?</h5>
							<p class="card-text">쭈꾸미볶음 + 콜라 = 기적의 맛.</p>
							<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
						</div>
					</div>
				    <div class="card">
						<img src="resources/images/index1.png" class="card-img-top" alt="...">
						<div class="card-body" style="cursor: pointer;" onclick="location.href='cook/cooking2.do';">
							<h5 class="card-title">여름에 시원한 빙수 요리 보실렵니까?</h5>
							<p class="card-text">팥빙수가 짱이제</p>
							<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
						</div>
				    </div>
					<div class="card">
						<img src="resources/images/index2.png" class="card-img-top" alt="...">
						<div class="card-body" style="cursor: pointer;" onclick="location.href='cook/cooking3.do';">
							<h5 class="card-title">다시마 칼국수</h5>
							<p class="card-text">냠냠?</p>
							<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
						</div>
					</div>
				</div>
				<div class="card-deck mb-4 h-100">
					<div class="card">
						<img src="resources/images/index3.png" class="card-img-top first_card" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">차가운 물냉면 어떠십니까</h5>
							<p class="card-text">비냉보만 물냉이지</p>
							<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
						</div>
					</div>
				    <div class="card">
						<img src="resources/images/index4.png" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">바삭바삭한 돈까스</h5>
							<p class="card-text">남녀노소 모두 좋아하는 돈까스</p>
							<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
						</div>
				    </div>
					<div class="card">
						<img src="resources/images/index5.png" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">원기회복엔 삼계탕</h5>
							<p class="card-text">복날엔 역시 삼계탕이지</p>
							<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
						</div>
					</div>
				</div>
			</div>
			<div class="pt-4"></div>
		</div>
	</div>
  	
	<footer>
	<div class="container">
		<div class="row">
		    <div class="col-md intro">
			    	<p class="f_link">
			    		<a href="#">회사소개</a>
			    		<span>|</span>
			    		<a href="#">광고문의</a>
			    		<span>|</span>
			    		<a href="#">개인정보처리방침</a>
			    		<span>|</span>
			    		<a href="#">이용약관</a>
			    		<span>|</span>
			    		<a href="#">고객센터</a>
			    	</p>
			    	<p class="f_info">
			    		대표 : 김아무개/ E : aaabbbccc@naver.com / F : 02) 000-xxxx <br />
			    		서울 금천구 가산동 371-50 에이스하이엔드타워 3차 1106-1호 <br />
			    		문의전화(운영시간 평일 09:00~17:00) <br />
			    		서비스 이용문의 : 070-oooo-xxxx <br />
			    	</p>
			    	<p class="f_info">
			    		(주)에이콘 아카데미 / 사업자등록번호 117-22-33333 / 통신판매업신고 <br />
			    		제 2020-서울강남-0001호 / 벤처기업확인 / 사업자정보확인 <br />
			    		서울지방중소기업청 제 000000001-2-00003호 <br />
			    	</p>
			    	<p class="f_info">
			    		Copyright 2020 김아무개. All Rights Reserved.
			    	</p>
		    </div>
		    <div class="col-md banner">
			    	<div class="up_banner">
			    		SNS 공유
			    	</div>
			    	<div class="down_banner">
			    		<div><a href="http://www.facebook.com/"><i class="fa fa-facebook-square fa-3x" aria-hidden="true"></i><br /><span class="sns_text">페이스북</span></a></div>
			    		<div><a href="http://www.instagram.com "><i class="fa fa-instagram fa-3x" aria-hidden="true"></i><br /><span class="sns_text">인스타그램</span></a></div>
			    		<div><a href="http://www.youtube.com"><i class="fa fa-youtube-play fa-3x" aria-hidden="true"></i><br /><span class="sns_text">유튜브</span></a></div>
			    		<div><a href="http://www.twitter.com"><i class="fa fa-twitter-square fa-3x" aria-hidden="true"></i><br /><span class="sns_text">트위터</span></a></div>
			    		<div><a href="http://www.quora.com"><i class="fa fa-quora fa-3x" aria-hidden="true"></i><br /><span class="sns_text">쿼라</span></a></div>
			    		<div><a href="http://www.medium.com/"><i class="fa fa-medium fa-3x" aria-hidden="true"></i><br /><span class="sns_text">미디엄</span></a></div>
			    	</div>
		    </div>
		    <div class="col-md logo_part">
				로고 이미지
	    	</div>
  		</div>
  	</div>
	</footer>
</body>
</html>