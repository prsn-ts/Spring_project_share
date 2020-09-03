<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>나만의 레시피</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/angular.min.js"></script>
<script>
	var myrecipeApp=angular.module("myrecipeApp", []);
	
	myrecipeApp.controller("myrecipeCtrl", function($scope, $http){
		//페이지 로딩되는 시점에 실행되는 영역
		$scope.condition="";
		$scope.keyword="";
		// url 에서 PageNum 추출
		$scope.getPageNum=function(pageNum) {
		    var params = location.search.substr(location.search.indexOf("?") + 1);
		    var sval = "";
		    params = params.split("&");
		    for (var i = 0; i < params.length; i++) {
		        temp = params[i].split("=");
		        if ([temp[0]] == pageNum) { sval = temp[1]; }
		    }
		    return sval;
		}
		// url 에서 검색 조건과 검색어 추출
		$scope.getsearchResult=function(condition, keyword) {
		    var params = location.search.substr(location.search.indexOf("?") + 1);
		    var sval = "";
		    params = params.split("&");
		    for (var i = 0; i < params.length; i++) {
		        temp = params[i].split("=");
		        if ([temp[0]] == condition) { $scope.condition = temp[1]; }
		        if ([temp[0]] == keyword) { $scope.keyword = temp[1]; }
		    }
		}
		//페이지 번호 가져오기
		$scope.pageNum=$scope.getPageNum("pageNum");
		if($scope.pageNum == ""){
			$scope.pageNum = 1;
		}
		//검색 조건 및 검색어 정보 가져오기
		$scope.getsearchResult("condition","keyword");
		//ajax 로 카페 글 목록을 요청
		$http({
			url:"${pageContext.request.contextPath}/myrecipe/ajax_list.do",
			method:"get",
			params:{pageNum:$scope.pageNum,
				condition:$scope.condition, keyword:$scope.keyword}
		}).success(function(data){
			$scope.list=data;
			console.log($scope);
		});
		//ajax 로 카페 글 목록 페이징 처리를 위한 요청
		$http({
			url:"${pageContext.request.contextPath}/myrecipe/ajax_paging_list.do",
			method:"get",
			params:{pageNum:$scope.pageNum,
				condition:$scope.condition, keyword:$scope.keyword}
		}).success(function(data){
			$scope.paging_list=data;
			//검색어를 보여주기위한 디코딩 작업.
			$scope.keyword = decodeURI($scope.paging_list.keyword);
			//시작 페이지와 끝 페이지의 정보를 배열에 저장한다.
			var range = [];
			for(var i=data.startPageNum;i<=data.endPageNum;i++) {
			  range.push(i);
			}
			$scope.range = range;
			console.log($scope);
		});
		//다음 페이지 버튼을 눌렀을 때 호출되는 함수
		$scope.next=function(){
			//ajax 로 카페 글 목록을 요청
			$http({
				url:"/myrecipe/ajax_list.do",
				method:"get",
				params:{pageNum:$scope.pageNum,
					condition:$scope.condition, keyword:$scope.keyword}
			}).success(function(data){
				$scope.list=data;
				
				$scope.pageNum=data[0].pageNum;
			});
			//ajax 로 카페 글 목록 페이징 처리를 위한 요청
			$http({
				url:"/myrecipe/ajax_paging_list.do",
				method:"get",
				params:{pageNum:$scope.pageNum,
					condition:$scope.condition, keyword:$scope.keyword}
			}).success(function(data){
				$scope.paging_list=data;
				var range = [];
				for(var i=data[0].startPageNum;i<=data[0].endPageNum;i++) {
				  range.push(i);
				}
				$scope.range = range;
				
				$scope.pageNum=data[0].pageNum;
			});
		};
	});
</script>
</head>
<body ng-app="myrecipeApp">
	<%-- jsp:include(header) --%>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<%-- //header --%>
	
	<!-- Page Content -->
	<div ng-controller="myrecipeCtrl" class="myrecipe_part" style="background-color: #d8d8d8;">
		<div class="container">
			<div class="pb-4"></div>
			<div class="row_all p-3" style="border: 1px solid #dfdfdf; background-color: #f2f2f2;">
			
			<div class=" my-4">
				<h3 style="text-shadow: 2px 2px 4px gray;">나만의 레시피</h3>
				<div class="write_btn" style="width:100%; text-align: right;">
				  	<button type="submit" class="btn btn-outline-success" onclick="location.href='${pageContext.request.contextPath}/my_recipe/private/insertform.do';">레시피 작성하기</button>
				</div>
			</div>

				<!-- Page Features -->
				<div class="row text-center" >
				  <div ng-repeat="tmp in list" class="card_one col-lg-3 col-md-6 mb-4" style=" cursor: pointer;" onclick="location.href='sub_myrecipe.do?num={{tmp.num}}';">
				    <div class="card h-100">
				      <img ng-if="tmp.imagePath" class="card-img-top" src="${pageContext.request.contextPath}{{tmp.imagePath}}" alt="">
				      <img ng-if="!tmp.imagePath" class="card-img-top" src="${pageContext.request.contextPath}/resources/images/basic_img.png" alt="">
				      <div class="card-body">
				        <h4 class="card-title">{{tmp.title}}</h4>
				        <p class="card-text">{{tmp.subTitle}}</p>
				        <p class="card-text">작성일자 : {{tmp.regdate}}</p>
				      </div>
				      <div class="card-footer">
				        <a href="sub_myrecipe.do?num={{tmp.num}}" class="btn btn-primary">레시피 보러가기!</a>
				      </div>
				    </div>
				  </div>
				<%--
				  <div class="card_one col-lg-3 col-md-6 mb-4">
				    <div class="card h-100">
				      <img class="card-img-top" src="http://placehold.it/500x325" alt="">
				      <div class="card-body">
				        <h4 class="card-title">Card title</h4>
				        <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo magni sapiente, tempore debitis beatae culpa natus architecto.</p>
				      </div>
				      <div class="card-footer">
				        <a href="#" class="btn btn-primary">Find Out More!</a>
				      </div>
				    </div>
				  </div>
				
				  <div class="card_one col-lg-3 col-md-6 mb-4">
				    <div class="card h-100">
				      <img class="card-img-top" src="http://placehold.it/500x325" alt="">
				      <div class="card-body">
				        <h4 class="card-title">Card title</h4>
				        <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
				      </div>
				      <div class="card-footer">
				        <a href="#" class="btn btn-primary">Find Out More!</a>
				      </div>
				    </div>
				  </div>
				
				  <div class="card_one col-lg-3 col-md-6 mb-4">
				    <div class="card h-100">
				      <img class="card-img-top" src="http://placehold.it/500x325" alt="">
				      <div class="card-body">
				        <h4 class="card-title">Card title</h4>
				        <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo magni sapiente, tempore debitis beatae culpa natus architecto.</p>
				      </div>
				      <div class="card-footer">
				        <a href="#" class="btn btn-primary" >Find Out More!</a>
				      </div>
				    </div>
				  </div>
				  
				  <div class="card_one col-lg-3 col-md-6 mb-4">
				    <div class="card h-100">
				      <img class="card-img-top" src="http://placehold.it/500x325" alt="">
				      <div class="card-body">
				        <h4 class="card-title">Card title</h4>
				        <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
				      </div>
				      <div class="card-footer">
				        <a href="#" class="btn btn-primary">Find Out More!</a>
				      </div>
				    </div>
				  </div>
				  
				  <div class="card_one col-lg-3 col-md-6 mb-4">
				    <div class="card h-100">
				      <img class="card-img-top" src="http://placehold.it/500x325" alt="">
				      <div class="card-body">
				        <h4 class="card-title">Card title</h4>
				        <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
				      </div>
				      <div class="card-footer">
				        <a href="#" class="btn btn-primary">Find Out More!</a>
				      </div>
				    </div>
				  </div>
				  
				  <div class="card_one col-lg-3 col-md-6 mb-4">
				    <div class="card h-100">
				      <img class="card-img-top" src="http://placehold.it/500x325" alt="">
				      <div class="card-body">
				        <h4 class="card-title">Card title</h4>
				        <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
				      </div>
				      <div class="card-footer">
				        <a href="#" class="btn btn-light-primary">Find Out More!</a>
				      </div>
				    </div>
				  </div>
				  
				  <div class="card_one col-lg-3 col-md-6 mb-4">
				    <div class="card h-100">
				      <img class="card-img-top" src="http://placehold.it/500x325" alt="">
				      <div class="card-body">
				        <h4 class="card-title">Card title</h4>
				        <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
				      </div>
				      <div class="card-footer">
				        <a href="#" class="btn btn-primary">Find Out More!</a>
				      </div>  
				    </div>
				  </div>
				  --%>
				</div>
				
				<!-- //.row -->
				<div class="search_form" style="float:right;">
					<form action="myrecipe.do" method="get" accept-charset="UTF-8">
						<label for="condition">검색조건</label>
						<select name="condition" id="condition">
							<option value="title_content">제목+내용</option>
							<option value="title">제목</option>
							<option value="writer">작성자</option>
						</select>
						<input value="{{keyword}}" type="text" name="keyword" placeholder="검색어..."/>
						<button class="btn-primary" ng-click="next()">검색</button>
					</form>
				</div>
				
				<div class="page-display">
					<ul class="pagination pagination-sm">
						<div ng-if="paging_list.startPageNum != 1">
							<li class="page-item"><a class="page-link" href="myrecipe.do?pageNum={{paging_list.startPageNum-1}}&condition={{paging_list.condition}}&keyword={{paging_list.keyword}}" ng-click="next()">Prev</a></li>
						</div>
						<div ng-repeat="i in range" ng-model="i">
							<div ng-if="i == paging_list.pageNum">
								<li class="page-item active"><a class="page-link" href="myrecipe.do?pageNum={{i}}&condition={{paging_list.condition}}&keyword={{paging_list.keyword}}" ng-click="next()">{{i}}</a></li>
							</div>
							<div ng-if="i != paging_list.pageNum" ng-model="i">
								<li class="page-item"><a class="page-link" href="myrecipe.do?pageNum={{i}}&condition={{paging_list.condition}}&keyword={{paging_list.keyword}}" ng-click="next()">{{i}}</a></li>
							</div>
						</div>	
						<div ng-if="paging_list.endPageNum < paging_list.totalPageCount">
							<li class="page-item"><a class="page-link" href="myrecipe.do?pageNum={{paging_list.endPageNum+1}}&condition={{paging_list.condition}}&keyword={{paging_list.keyword}}" ng-click="next()">Next</a></li>
						</div>
					</ul>
				</div>				
			</div>
			<!-- //.row_all -->
		<div class="pt-4"></div>
		</div>
		<!-- //.container -->
	</div>
	<!-- //Page Content -->
	
	<!-- footer --> 
		<%-- jsp:include(footer) --%>
		<jsp:include page="../include/footer.jsp">
			<jsp:param value="sub_myrecipe" name="thisPage"/>
		</jsp:include>
	<!-- footer end-->

</body>
</html>