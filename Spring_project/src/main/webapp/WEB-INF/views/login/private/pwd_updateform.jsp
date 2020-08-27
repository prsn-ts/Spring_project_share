<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/login/private/pwd_updateform.jsp</title>

<!-- Custom fonts for this template-->
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<style>
	.bg-update-image {
	  width: 45%;
 	 /* Link to your background image using in the property below! */
 	 background: scroll center url('https://img1.daumcdn.net/thumb/R720x0/?fname=http%3A%2F%2Ft1.daumcdn.net%2Fliveboard%2Fdailylife%2Ff74fc9b2636944b19b888e1cd34efafa.JPG');
 	 background-size: cover;
	}
</style>
</head>
<body class="bg-gradient-primary">

  <div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-update-image "></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">비밀번호 변경</h1>
              </div>
	<form class="user" action="pwd_update.do" method="post" id="myForm">
		<div class="form-group">
			<label for="pwd">기존 비밀번호</label>
			<input type="password" class="form-control form-control-user" name="pwd" id="pwd" placeholder="Password"/>
		</div>
		<div class="form-group">
			<label for="newPwd">새 비밀번호</label>
			<input type="password" class="pw form-control form-control-user" name="newPwd" id="newPwd" placeholder="NewPassword"/>
		</div>
		<div class="form-group">
			<label for="newPwd2">새 비밀번호 확인</label>
			<input type="password" class="pw form-control form-control-user" name="newPwd2" id="newPwd2" placeholder="NewPassword"/>
			<span id="checkPassword"></span>
		</div>
		<button type="submit" class="btn btn-primary btn-user btn-block">수정하기</button>
	</form>
</div>
  </div>
          </div>
        </div>
      </div>
    </div>


<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.js"></script>
<script>
	$('.pw').focusout(function () {
	    var pwd1 = $("#newPwd").val();
	    var pwd2 = $("#newPwd2").val();
	
	  //비밀번호 입력칸이 비어있지 않고 비밀번호 확인칸이 비어있을 때
        if ((pwd1 != '' && pwd2 == '') || (pwd1 == '' && pwd2 != '')) {
        	$("#checkPassword").text("비밀번호, 비밀번호 확인칸 모두 입력해주세요.").removeClass("text-success").css({'color':'#d92742','font-weight':'bold'});
        } else if (pwd1 != "" || pwd2 != "") {
            if (pwd1 == pwd2) {		
                $("#checkPassword").text("비밀번호가 일치합니다.").addClass("text-success");
            } else {
            	$("#checkPassword").text("비밀번호가 일치하지 않습니다.").removeClass("text-success").css({'color':'#d92742','font-weight':'bold'});
            }
        }
      	//비밀번호 입력칸과 비밀번호 확인칸에 아무것도 입력하지않고 뗐을 시 중복확인 문자 사라지게 하기
		if(pwd1.length == 0 && pwd2.length == 0){
			$("#checkPassword").text("");
			//form 안에 있는 일반 버튼을 눌러도 폼이 전송 되기 때문에 폼 전송을 막아준다.
			return false;
		}
	});
</script>
<script>
	//id 가 myForm  인 곳에 submit 이벤트가 일어 났을때 실행할 함수 등록 
	$("#myForm").on("submit", function(){
		//입력한 새로운 비밀번호 2개를 읽어와서 
		var pwd1=$("#newPwd").val();
		var pwd2=$("#newPwd2").val();
		//만일 일치하지 않으면 
		if(pwd1 != pwd2){
			//알림을 띄우고 
			alert("새로운 비밀번호가 일치 하지 않습니다.");
			//비밀번호 입력란을 초기화 하고 포커스도 주고 
			$("#newPwd").val("").focus();
			$("#newPwd2").val("");
			//폼전송을 막는다. 
			return false;
		}
	});
</script>

</body>
</html>
