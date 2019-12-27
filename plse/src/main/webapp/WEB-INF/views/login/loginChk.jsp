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
	<c:when test="${ result == 'no' }">
			<script>
				alert("회원가입시 작성하신 이메일로 인증을 먼저 해주세요");
				location.href = "login";
			</script>
		</c:when>
		<c:when test="${ result == 'fail' }">
			<script>
				alert("아이디 또는 비밀번호를 확인해주세요");
				location.href = "login";
			</script>
		</c:when>
		<c:otherwise>
			<script>
				location.href = "http://localhost:8989/practice/";
			</script>
		</c:otherwise>
</c:choose>
</body>
</html>