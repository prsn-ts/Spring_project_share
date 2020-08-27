<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/login/private/info.jsp</title>
<style>
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
	.bg-info-image {
	  width: 45%;
 	 /* Link to your background image using in the property below! */
 	 background: scroll center url('https://img1.daumcdn.net/thumb/R720x0/?fname=http%3A%2F%2Ft1.daumcdn.net%2Fliveboard%2Fdailylife%2F75fa2dd2ea934d009052fb8867b6bb8c.jpg');
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

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-6 d-none d-lg-block bg-info-image"></div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center clearfix" style="position:relative;">
                  	<c:choose>
                  		<c:when test="${empty dto.profile and empty dto.saveFileName}">
                  			<img id="profileImage" src="${pageContext.request.contextPath}/resources/images/noprofile.jpg" alt="" />
                  		</c:when>
                  		<c:otherwise>
                  			<img id="profileImage" src="${pageContext.request.contextPath}${dto.profile }" alt="" />
                  		</c:otherwise>
                  	</c:choose>
                    <h1 class="h4 text-gray-900">회원 정보</h1>
                  </div>
					<table class="table">
						<tr>
							<th><label for="id">아이디</label></th>
							<td><input type="text" id="id" value="${dto.id }" disabled /></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><a href="pwd_updateform.do">수정하기</a></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${dto.email }</td>
						</tr>
						<tr>
							<th>가입일</th>
							<td>${dto.regdate }</td>
						</tr>
					</table>
					<a href="updateform.do">개인정보 수정</a><br />
					<hr>
					<a href="javascript:deleteConfirm()">탈퇴</a>
                </div>            
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.form.min.js"></script>
<script>
	//탈퇴 버튼 누를 시 실행되는 함수
	function deleteConfirm(){
		var isDelete=confirm("${id } 회원님 탈퇴 하시겠습니까?");
		if(isDelete){
			location.href="delete.do";
		}
	}
	//프로필 이미지를 클릭했을 때 프로필 수정에 대해 실행할 함수 등록
	$("#profileImage").on("click", function(){
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
		//프로필 이미지를 업데이트 한다. data => {imageSrc:"/upload/xxx.jpg"}
		$("#profileImage")
		.attr("src","${pageContext.request.contextPath}"+data.imageSrc);
		//회원정보 수정폼 전송될 때 같이 프로필 정보도 같이 전송 되도록 한다.
		$("#profile").val(data.imageSrc); // input type="hidden"의 value값
	})
</script>
</body>
</html>