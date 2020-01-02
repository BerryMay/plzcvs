<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Sorry...</title>

</head>
<body>
	<script>
	var agent = navigator.userAgent.toLowerCase();//브라우저 체크하기
	
	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
	alert("해당 사이트는 익스플로러를 지원하지 않습니다.");
	window.close();
	}
	
	
</script>

</body>
</html>