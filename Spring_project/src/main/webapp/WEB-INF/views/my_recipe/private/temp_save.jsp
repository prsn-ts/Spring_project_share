<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/my_recipe/private/temp_save.jsp</title>
</head>
<body>
	<script>
		alert("임시 저장 되었습니다.");
		location.href="${pageContext.request.contextPath}/my_recipe/private/insertform.do";
	</script>
</body>
</html>