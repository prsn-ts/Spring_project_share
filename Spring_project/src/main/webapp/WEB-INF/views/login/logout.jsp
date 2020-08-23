<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/login/logout.jsp</title>
</head>
<body>
	<script>
		alert("로그 아웃 되었습니다.");
		location.href="${pageContext.request.contextPath }/home.do";
	</script>
</body>
</html>


