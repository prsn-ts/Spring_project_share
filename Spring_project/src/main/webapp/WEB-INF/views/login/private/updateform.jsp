<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/login/private/updateform.jsp</title>
<style>
	/* 프로필 업로드 폼을 화면에서 숨긴다. */
	#profileForm{
		display:none;
	}
	.form-group label{
		display: list-item;
    	margin-bottom: 0.8rem;
	}
	/* 이미지를 작은 원형으로 만든다. */
	#profileImage{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%;
		curser: pointer;
		float: left;
    	margin: 10px;
	}
	/* 텍스트 세로 가운데 정렬 */
	.text-center h1{
		position: absolute;
	    top: 0;
	    bottom: 0;
	    left: 0;
	    right: 0;
	    height: 50%;
	    margin: auto;
	}
	.bg-updateform-image {
	  width: 45%;
 	 /* Link to your background image using in the property below! */
 	 background: scroll center url('https://ppss.kr/wp-content/uploads/2017/11/20171108024157592_IBYNSQCZ.jpg');
 	 background-size: cover;
	}
</style>
<!-- Custom fonts for this template-->
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
</head>
<body class="bg-gradient-primary">

<div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-updateform-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center clearfix" style="position:relative;">
              	<c:choose>
              		<c:when test="${empty dto.profile and empty dto.saveFileName}">
              			<img id="profileImage" src="${pageContext.request.contextPath}/resources/images/noprofile.jpg" alt="" />
              		</c:when>
              		<c:otherwise>
              			<img id="profileImage" src="${pageContext.request.contextPath}${dto.profile}" alt="" />
              		</c:otherwise>
              	</c:choose>
                <h1 class="h4 text-gray-900">회원정보 변경</h1>
              </div>
				<form class="user" action="update.do" method="post">
					<%-- 프로필 이미지를 DB에 저장하기 위해 hidden type으로 설정. --%>
					<input type="hidden" name="profile" id="profile" value="${dto.profile}"/>
					<%-- 프로필 이미지의 실제 이름을 DB에 저장하기 위해 hidden type으로 설정. --%>
					<input type="hidden" name="saveFileName" id="profile_name" value="${dto.saveFileName}"/>
					<%-- id를 disabled로 설정했기 때문에 id에 해당하는 value값을 hidden으로 전송하기 --%>
					<input type="hidden" id="id" name="id" value="${dto.id}"/>
					<div class="form-group">
						<label for="id">아이디</label>
						<input type="text" class="form-control form-control-user" id="id" name="id" value="${dto.id}" disabled/>
					</div>
					<div class="form-group">
						<label for="">이메일</label>
						<input type="text"  class="form-control form-control-user" id="email" name="email" value="${dto.email}" />
					</div>
					<div class="form-group">
						<label for="">프로필 설정</label>
						<input type="button" id="" class="file_select btn btn-outline-primary" value="프로필 파일 선택하기">
						<button type="submit" class="profile_delete btn btn-danger">프로필 사진 지우기</button>
					</div>
					<br />
					<button type="submit" class="btn btn-primary btn-user btn-block">수정확인</button>
					<hr>
					<button type="reset" class="btn btn-danger btn-user btn-block" 
					onclick="window.location.href='${pageContext.request.contextPath}/home.do'">취소</button>
				</form>
				
				<form action="profile_upload.do" method="post" 
					enctype="multipart/form-data" id="profileForm">
					<input type="file" name="image"
						accept=".jpg, .jpeg, .png, .JPG, .JPEG" id="image"/>
				</form>
			</div>
  		  </div>
        </div>
      </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.form.min.js"></script>
<script>
	//프로필 사진을 삭제하기위한 버튼을 누를 시 동작하기
	$(".profile_delete").on("click", function(){
		//profile_delete 버튼을 눌렀을 때 폼 액션 값을 profile_delete.do 바꿔준다.
		$(".user").attr("action", "profile_delete.do");
		//액션 값이 profile_delete.do 바뀐 폼을 제출한다.
		$(".user").submit();
	});

	//프로필 이미지를 클릭했을 때 프로필 수정에 대해 실행할 함수 등록
	$("#profileImage, .file_select").on("click", function(){
		//프로필 이미지를 눌렀을 때 input type="file" 을 강제 클릭하게 한다.
		$("#image").click(); //파일 선택창이 뜰 수 있도록
	});
	
	//이미지를 선택했을 때 변화를 감지되었을 때 동작할 함수 등록
	$("#image").on("change", function(){ //기존 파일이 변경된 경우
		//폼을 강제 제출한다.
		$("#profileForm").submit();
	});
	
	//폼이 ajax 로 제출될 수 있도록 플러그인을 동작 시킨다.
	$("#profileForm").ajaxForm(function(data){
		console.log("실행순서 들어옴2!!");
		//프로필 이미지를 업데이트 한다. data => {imageSrc:"/upload/xxx.jpg","saveFileName":"xxx.jpg"}
		$("#profileImage")
		.attr("src","${pageContext.request.contextPath}"+data.imageSrc);
		//회원정보 수정폼 전송될 때 같이 프로필 정보도 같이 전송 되도록 한다.
		$("#profile").val(data.imageSrc); // input type="hidden"의 value값
		//회원정보 수정폼 전송될 때 같이 프로필 정보도 같이 전송 되도록 한다.
		$("#profile_name").val(data.saveFileName); // input type="hidden"의 value값
	})
</script>
</body>
</html>







