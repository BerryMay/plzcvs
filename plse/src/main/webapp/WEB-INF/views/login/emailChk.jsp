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
	<c:when test="${ Authstatus == '1' }">
			<script>
				alert("회원가입을 축하드립니다");
				location.href = "loginChk?id=${dto.id}&pw=${dto.pw}";
			</script>
		</c:when>
		<c:otherwise>
			<script>
				alert("이메일 인증 오류");
				location.href = "http://localhost:8989/practice/";
			</script>
		</c:otherwise>
</c:choose>

</body>
</html>