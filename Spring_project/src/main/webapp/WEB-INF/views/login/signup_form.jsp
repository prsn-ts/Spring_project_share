<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Register</title>
<!-- Custom fonts for this template-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<!-- Custom styles for this template-->
<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
<style>
	.bg-register-image {
	  width: 45%;
 	 /* Link to your background image using in the property below! */
 	 background: scroll center url('http://foodtravel.co.kr/wp-content/uploads/2016/05/i2.wp.comolivem.co_.krwp-contentuploads2016050512-vegtfood2-e9e896510470b81997f150e2f0fe528f59c25e3b.jpg');
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
          <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
              </div>
              <form class="user" action="signup.do" method="post">
                <div class="form-group" style="margin-bottom: 5px;">
                  <label for="id">아이디</label>
                  <input type="text" class="form-control form-control-user" id="id" name="id" placeholder="id">
				  <span id="checkResult" style="display: inline-block;"></span>
                </div>
                <div class="form-group" style="margin-bottom: 25px;">
                  	<label for="pwd">비밀번호</label>
                    <input type="password"  class="pw form-control form-control-user" id="pwd" name="pwd" placeholder="Password">
         			<small id="passwordHelpInline" class="text-muted">
						비밀번호는 숫자+영문자+특수문자 조합으로 8자리 이상 써야합니다.
				    </small>
                </div>
                <div class="form-group" style="margin-bottom: 5px;">
                  	<label for="pwd">비밀번호 확인</label>
                    <input type="password"  class="pw form-control form-control-user" id="pwd2" name="pwd2" placeholder="Password">
                    <span id="checkPassword" style="display: inline-block;"></span>
                </div>
                
                <div class="form-group">
                  <label for="email">이메일</label>
                  <input type="text" class="form-control form-control-user" id="email" name="email" placeholder="Email Address">
                </div>
                
                <button type="submit" class="signup_btn btn btn-primary btn-user btn-block">
                  Register Account
                </button>
              </form>
              <hr>
              <div class="text-center">
                <a class="small" href="login_form.do">Already have an account? Login!</a>
              </div>
              <hr>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.js"></script>
<script>
	//한글이 포함되는지 검사하는 정규표현식
	var reg_hangle = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	//비밀번호 유효성 정규표현식(숫자+영문자+특수문자 조합으로 8자리 이상)
	var reg_pwd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
	//이메일 유효성 정규표현식
	var reg_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
    $('.pw').blur(function () {
        var pwd1 = $("#pwd").val();
        var pwd2 = $("#pwd2").val();
 
        //비밀번호 입력칸이 비어있지 않고 비밀번호 확인칸이 비어있을 때
        if ((pwd1 != '' && pwd2 == '') || (pwd1 == '' && pwd2 != '')) {
        	$("#checkPassword").text("비밀번호, 비밀번호 확인칸 모두 입력해주세요.").removeClass("text-success").css({'color':'#d92742','font-weight':'bold'});
        } else if (pwd1 != "" && pwd2 != "") {
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
    
    //회원가입 버튼을 눌렀을 때
    $(".signup_btn").on("click", function(){
    	//비밀번호 입력된 값을 가져온다.
    	var pwd1 = $("#pwd").val();
        var pwd2 = $("#pwd2").val();
        
        //이메일 입력된 값을 가져온다.
        var email = $("#email").val();
        
        //비밀번호 입력칸과 비밀번호 확인칸이 일치하지 않을 때
        if(pwd1 != pwd2){
        	//알림을 띄우고
        	alert("비밀번호, 비밀번호 확인이 일치하지 않습니다.");
        	//폼 제출을 막는다.
        	return false;
        }else if(pwd1 == pwd2){ //비밀번호 입력칸과 비밀번호 확인칸이 일치할 때
            //비밀번호가 유효하지 않은 경우
            if(!(reg_pwd.test(pwd1) && reg_pwd.test(pwd2))){
            	//알림을 띄우고
                alert('영문자+숫자+특수문자 조합으로 8자리 이상 적어주세요.');
            	//포커스 잡아주고
                $('#pwd').val("").focus();
                $('#pwd2').val("");
             	//폼 제출을 막는다.
                return false;
            } 
        }
        
        //이메일이 유효하지 않을 때
        if(reg_email.test(email) == false){
        	//알림을 띄우고
            alert('이메일 형식에 맞게 다시 입력해수세요.');
        	//포커스 잡아주고
            $('#email').val("").focus();
         	//폼 제출을 막는다.
            return false;
        }
        
    })
    
	//아이디 중복확인을 통과 했는지 여부
	var canUseId=false;
	//중복 확인 버튼을 눌렀을때 실행할 함수 등록
	$("#id").blur(function(){
		//입력한 아이디를 읽어온다.
		var inputId=$("#id").val();
		//아이디에 아무것도 입력하지않고 뗐을 시 중복확인 문자 사라지게 하기
		if(inputId.length == 0){
			$("#checkResult").text("");
			//form 안에 있는 일반 버튼을 눌러도 폼이 전송 되기 때문에 폼 전송을 막아준다.
			return false;
		}
		//ajax 를 이용해서 서버에 보낸후 결과를 응답 받는다.
		$.ajax({
			method:"GET",
			url:"checkid.do",
			data:"inputId="+inputId,
			success:function(data){
				//data => {isExist:true} or {isExist:false} 인 object 이다.
				if(data.isExist){//이미 존재하는 아이디임으로 사용 불가
					$("#checkResult")
					.text("사용불가")
					.css("color","red");
					//아이디가 사용 불가 하다고 표시한다.
					canUseId=false;
				}else{//사용가능 
					$("#checkResult")
					.text("사용가능")
					.css("color","green");
					//아이디가 사용 가능 하다고 표시한다.
					canUseId=true;
				}
 			}
		});
		//form 안에 있는 일반 버튼을 눌러도 폼이 전송 되기 때문에 폼 전송을 막아준다.
		return false;
	});
	//폼에 submit 이벤트가 일어났을때 호출될 함수 등록 
	$(".user").on("submit", function(){
		
		if(!canUseId){//사용 불가한 아이디 이면 
			alert("아이디 중복을 확인 하세요");
			return false; //폼 제출 막기 
		}
	});
</script>

</body>

</html>
