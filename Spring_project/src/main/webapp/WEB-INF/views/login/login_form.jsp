<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>SB Admin 2 - Login</title>
<!-- Custom fonts for this template-->
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<!-- Custom styles for this template-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<style>
	.bg-login-image {
	  width: 45%;
 	 /* Link to your background image using in the property below! */
 	 background: scroll center url('http://img.hani.co.kr/imgdb/resize/2019/0531/00502615_20190531.JPG');
 	 background-size: cover;
	}
</style>
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
              <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                  </div>
                  <form class="user" action="login.do" method="post">
                 	 <%-- 원래 가려던 목적지 정보를 url 이라는 파라미터 명으로 가지고 간다 --%>
                 	
					<input type="hidden" name="url" value="${url }" />
                    <div class="form-group">
                	  <label for="id">아이디</label>
                      <input value="${savedId }" type="text" class="form-control form-control-user" name="id" id="id"  placeholder="Enter id...">
                    </div>
                    <div class="form-group">
                      <label for="pwd">비밀번호</label>
                      <input value="${savedPwd }" type="password" class="form-control form-control-user"  name="pwd" id="pwd" placeholder="Password">
                    </div>
                    <div class="form-group">
                      
                        <input type="checkbox" name="isSave" value="yes"/>
                        <label >Remember Me</label>
                 
                    </div>
                    <button type="submit" class="btn btn-primary btn-user btn-block">
                      Login
                    </button>
                   
         
                  </form>
                  <hr>
                  
                  <div class="text-center">
                    <a class="small" href="signup_form.do">Create an Account!</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>


</body>

</html>