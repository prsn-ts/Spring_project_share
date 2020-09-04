<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/my_recipe/private/insertform.jsp</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<style>
	/* textarea 요소의 크기가 smart editor 의 크기로 결정된다. */
	#content{
		width: 99.5%;
		height: 300px;
	}
		
</style>
<script src="${pageContext.request.contextPath}/resources/js/angular.min.js"></script>
<script>
	var myrecipeApp=angular.module("myrecipeApp", []);
	
	myrecipeApp.controller("myrecipeCtrl", function($scope, $http){
		//페이지 로딩되는 시점에 실행되는 영역
		
		//ajax 로 카페 글 목록을 요청
		$http({
			url:"${pageContext.request.contextPath}/my_recipe/private/ajax_data.do",
			method:"get"
		}).success(function(data){
			$scope.dtoData=data;
			console.log($scope);
		});
		
	});
</script>
</head>
<body ng-app="myrecipeApp">

	<%-- jsp:include(header) --%>
	<jsp:include page="../../include/header.jsp">
		<jsp:param value="index" name="thisPage"/>
	</jsp:include>
    <!-- End of Topbar -->

	<div ng-controller="myrecipeCtrl" class="editor_part" style="background-color:  #d8d8d8">
		<div class="pb-4"></div>
		<div class="container">
			<div style="background-color: #f2f2f2">
				<div class="row row-cols-1 row-cols-md-0">
					<div class="container">
					
						<div class="card m-5">
							<div class="card-body">
							<h2 class="card-title display-4 font-weight-bold text-success m-2">레시피 작성</h2>
								<hr class="two">
								<div class="temp_btn_collrection" style="text-align: right;">
									<%-- 임시 저장된 내용 불러오기 버튼 --%>
									<button class="temp_lead btn btn-primary">임시 저장된 내용 불러오기</button>
									<%-- 임시 저장된 내용 삭제 버튼 --%>
									<a href="temp_delete.jsp?writer={{dtoData.dto.id}}" class="temp_delete btn btn-outline-danger">임시 저장된 내용 삭제하기</a>
								</div>
								<form action="insert.jsp" method="post" id="submitForm">
									<div style="margin-bottom: 30px;">
										<%-- 임시 저장 버튼 --%>
										<button class="temp_save btn btn-outline-success">임시 저장</button>
									</div>
									<%-- 대표 이미지 경로를 DB에 저장하기 위해 hidden type으로 설정. --%>
									<input type="hidden" name="showImage_path" id="showImage_path"/>
									<%-- 프로필 이미지의 실제 이름을 DB에 저장하기 위해 hidden type으로 설정. --%>
									<input type="hidden" name="showImage_hidden" id="showImage_hidden"/>
									<%-- writer를 disabled로 설정했기 때문에 writer에 해당하는 value값을 hidden으로 전송하기 --%>
									<input type="hidden" id="writer" name="writer" value="{{dtoData.dto.id}}"/>
									<!-- 작성자 -->
									<div class="form-group" style="margin-left: 1px">
										<label for="writer">작성자:</label>
										<input type="text" name="writer" id="writer" value="{{dtoData.dto.id}}" disabled/>
									</div>
									<!-- 제목 -->
									<div class="form-group" style="margin-left: 1px">
										<input type="text" name="title" id="title" value="" placeholder="제목"/>
									</div>
									<!-- 서브 타이틀 -->
									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
										  <span class="input-group-text" id="inputGroup-sizing-sm">서브 타이틀</span>
										</div>
										<input class=" col" type="text" name="subTitle" id="subTitle" value="" aria-label="Sizing example input"
											aria-describedby="inputGroup-sizing-sm" placeholder="해당 요리에 대한 간략한 설명을 적어주세요."/>
									</div>
									<!-- 대표 이미지 -->
									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
										  <span class="input-group-text" id="inputGroup-sizing-sm">대표 이미지 설정</span>
										</div>
										<input type="button" name="showImage_btn" id="showImage_btn" class="file_select btn btn-success btn-sm" value="대표 이미지 고르기">
									</div>
									<div ng-if="dtoData.temp_dto or dtoData.temp_dto.imagePath">
										<img id="showImage" src="" alt="" />
									</div>
									<div ng-if="!dtoData.temp_dto.imagePath">
										<img id="showImage" src="" alt="" />
									</div>
									<!-- 스마트에디터(content) 부분 -->
									<div class="form-group ">
										<textarea name="content" id="content" cols="30" rows="10"></textarea>
									</div>
									<!-- 폼 제출 버튼 -->
									<button type="submit" class="btn btn-outline-success" onclick="submitContents(this);">저장</button>
								</form>
								
								<form style="display:none;" action="show_image_upload.jsp" method="post" 
									enctype="multipart/form-data" id="showImageForm">
									<input type="file" name="image"
										accept=".jpg, .jpeg, .png, .JPG, .JPEG" id="image"/>
								</form>
							</div>
						</div>
					</div>	
				</div>
			</div>
		</div>
		<div class="pb-4"></div>	
	</div>
	<!-- //.editor_part -->
	
	<!-- footer --> 
	<%-- jsp:include(footer) --%>
	<jsp:include page="../../include/footer.jsp">
		<jsp:param value="magazine" name="thisPage" />
	</jsp:include>
	<!-- footer end-->


<!-- SmartEditor 에서 필요한 javascript 로딩  -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<!-- jquery -->
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.form.min.js"></script>
<%--
	[ SmartEditor 를 사용하기 위한 설정 ]
	
	1. WebContent 에 SmartEditor  폴더를 복사해서 붙여 넣기
	2. WebContent 에 upload 폴더 만들어 두기
	3. WebContent/WEB-INF/lib 폴더에 
	   commons-io.jar 파일과 commons-fileupload.jar 파일 붙여 넣기
	4. <textarea id="content" name="content"> 
	   content 가 아래의 javascript 에서 사용 되기때문에 다른 이름으로 바꾸고 
	      싶으면 javascript 에서  content 를 찾아서 모두 다른 이름으로 바꿔주면 된다. 
	5. textarea 의 크기가 SmartEditor  의 크기가 된다.
	6. 폼을 제출하고 싶으면  submitContents(this) 라는 javascript 가 
	      폼 안에 있는 버튼에서 실행되면 된다.
--%>
<script>
	//이미지 경로와 이미지 실제 이름을 선언.
	var showImage_path = null;
	var showImage_hidden = null;
	
	//주기적으로 폼 안에 내용이 바뀐 값들을 저장한다.
	$("#submitForm").find("*").on("propertychange change keyup paste input", function() {
		//아이디가 title,subTitle인 input 값 가져오기
	    var title = $("#title").val();
	    var subTitle = $("#subTitle").val();
	    //바뀐 내용을 value값에 다시 대입.
	    $("#title").val(title);
	    $("#subTitle").val(subTitle);
	});
	
	//임시 저장 버튼을 클릭했을 대 이벤트 발생.
	$(".temp_save").on("click", function(){
		//temp_save 버튼을 눌렀을 때 폼 액션 값을 temp_save.jsp 바꿔준다.
		$("#submitForm").attr("action", "temp_save.jsp");
		//스마트 에디터 내용과 함께 다른 value값을 temp_save.jsp 페이지로 보낸다.
		submitContents(this);
	});
	
	$(".temp_lead").on("click", function(){
		console.log("ok");
		//ajax 요청 처리를 한다.
		$.ajax({
			method:"get",
			url:"temp_lead.jsp", //요청 파라미터가 없으면 전달 안해도 된다.
			success:function(data){
				/*
					temp_lead.jsp 페이지에서 contentType 을 application/json
					이라고 정확히 명시 했기 때문에 jquery 가 응답된 문자열을
					object 로 바꿔서 전달을 해준다.
				*/
				console.log(data); //json으로 응답할 것이라 응답페이지에 명시 되있기 때문에 전달 받은 data 인자값은 object 타입이다.
				//타이틀 값을 불러온다.
				$("#title").val(data.title);
				//서브 타이틀 값을 불러온다.
				$("#subTitle").val(data.subTitle);
				//대표 이미지를 불러온다.
				//임시 저장된 이미지 경로와 실제이름을 불러올 때 DB에 값이 있는 경우에만 value 값을 읽어오기(없을 때 읽어오면 문자열 null이 value에 들어가면서 이미지 출력이 안됨.) 
				if(data.imagePath != "null"){
					$("#showImage")
					.attr("src","${pageContext.request.contextPath}"+data.imagePath);
					//대표 이미지를 불러올 때 value 값도 다시 세팅한다(글을 실제로 저장(등록)하려고할 때 이미지 경로와 이미지 실제 이름을 넘겨주어야한다.)
					$("#showImage_path").val(data.imagePath);
					$("#showImage_hidden").val(data.showImage);
				}
			}
		});
		//ajax 요청 처리를 한다.(img 태그의 쌍따옴표로인한 json 형식의 저장이 원활히 되지 않기 때문에 content 부분만 따로 요청)
		$.ajax({
			method:"get",
			url:"temp_lead_content.jsp", //요청 파라미터가 없으면 전달 안해도 된다.
			success:function(data){
				/*
					temp_lead.jsp 페이지에서 contentType 을 application/json
					이라고 정확히 명시 했기 때문에 jquery 가 응답된 문자열을
					object 로 바꿔서 전달을 해준다.
				*/
				console.log(data); //확인용.
				//스마트 에디터에 내용을 불러온다.
				oEditors.getById["content"].exec("PASTE_HTML", [data]);
			}
		});
		
	});
	
	//프로필 이미지를 클릭했을 때 프로필 수정에 대해 실행할 함수 등록
	$(".file_select").on("click", function(){
		//프로필 이미지를 눌렀을 때 input type="file" 을 강제 클릭하게 한다.
		$("#image").click(); //파일 선택창이 뜰 수 있도록
	});
	
	//이미지를 선택했을 때 변화를 감지되었을 때 동작할 함수 등록
	$("#image").on("change", function(){ //기존 파일이 변경된 경우
		console.log("실행순서 들어옴!");
		//폼을 강제 제출한다.
		$("#showImageForm").submit();
	});
	
	//폼이 ajax 로 제출될 수 있도록 플러그인을 동작 시킨다.
	$("#showImageForm").ajaxForm(function(data){
		//프로필 이미지를 업데이트 한다. data => {imageSrc:"/upload/xxx.jpg","showImage":"xxx.jpg"}
		$("#showImage")
		.attr("src","${pageContext.request.contextPath}"+data.imageSrc);
		//회원정보 수정폼 전송될 때 같이 프로필 정보도 같이 전송 되도록 한다.
		$("#showImage_path").val(data.imageSrc); // input type="hidden"의 value값
		//회원정보 수정폼 전송될 때 같이 프로필 정보도 같이 전송 되도록 한다.
		$("#showImage_hidden").val(data.showImage); // input type="hidden"의 value값
		//이미지 경로와 실제 이름을 showImage_path, showImage_hidden 변수에 저장
		showImage_path = $("#showImage_path").val();
	    showImage_hidden = $("#showImage_hidden").val();
	})

	var oEditors = [];
	
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["content"].getIR();
		alert(sHTML);
	}
	//폼에 저장 버튼을 누르면 호출되는 함수 
	//<button type="submit" onclick="submitContents(this);">저장</button>	
	function submitContents(elClickedObj) {
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
		try {
			elClickedObj.form.submit();//폼 강제 제출
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>
</body>
</html>
