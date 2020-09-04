<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/my_recipe/private/insert.jsp</title>
</head>
<body>
	<c:choose>
		<c:when test="${isSuccess }">
			<script>
				alert("${writer } 님 글이 등록되었습니다.");
				location.href="${pageContext.request.contextPath}/my_recipe/myrecipe.do";
			</script>
		</c:when>
		<c:otherwise>
			<script>
				alert("글 등록이 실패했습니다.");
				location.href="${pageContext.request.contextPath}/my_recipe/private/insertform.do";
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>