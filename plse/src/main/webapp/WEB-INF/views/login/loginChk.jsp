<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:choose>
	<c:when test="${ result != 'ok' }">
			<script>
				alert("아이디 또는 비밀번호를 확인하여주세요");
				location.href = "login";
			</script>
		</c:when>
		<c:otherwise>
			<script>
				location.href = "http://localhost:8080/practice/";
			</script>
		</c:otherwise>
</c:choose>
</body>
</html>