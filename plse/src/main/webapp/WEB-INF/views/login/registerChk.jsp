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
	<c:when test="${ result == 1 }">
			<script>
				alert("회원가입에 성공하셨습니다");
				location.href = "login";
			</script>
		</c:when>
		<c:otherwise>
			<script>
				alert("회원가입에 실패하셨습니다. 여러번 실패 시 관리자에게 문의하세요");
				location.href = "register";
			</script>
		</c:otherwise>
</c:choose>
</body>
</html>