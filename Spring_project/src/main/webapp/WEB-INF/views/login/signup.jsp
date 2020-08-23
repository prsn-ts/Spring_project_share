<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login/signup.jsp</title>
</head>
<body>
<h1>알림</h1>
<c:choose>
	<c:when test="${isSuccess }">
		<script>
			alert("${param.id} 님 회원가입 되었습니다.");
			location.href="login_form.do";
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert("가입이 실패 했습니다.");
			location.href="signup_form.do";
		</script>
	</c:otherwise>
</c:choose>
</body>
</html>
