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
				alert("해당 이메일로 임시 비밀번호를 발급했습니다");
				location.href = "login";
			</script>
		</c:when>
		<c:otherwise>
			<script>
				alert("아이디 또는 이메일을 확인해주세요")
			</script>
		</c:otherwise>
</c:choose>
</body>
</html>