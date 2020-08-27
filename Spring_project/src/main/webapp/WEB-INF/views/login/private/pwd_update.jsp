<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_update.jsp</title>
</head>
<body>
<c:choose>
	<c:when test="${isSuccess }">
		<script>
			alert("비밀 번호를 수정했습니다.");
			location.href="${pageContext.request.contextPath }/login/private/info.do";
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert("현재 비밀번호가 일치 하지 않습니다.");
			location.href="${pageContext.request.contextPath }/login/private/pwd_updateform.do";
		</script>
	</c:otherwise>
</c:choose>
</body>
</html>