<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>편의점 이벤트상품</title>
<link rel="stylesheet" href="css/event.css" type="text/css" />
<link rel="stylesheet" href="css/mypage.css" type="text/css" />
</head>
<body>
<jsp:include page="../default/header.jsp" />
<div class="mymenu_div">
		<ul class="myMenu">
			<li><button class="tablink" onclick="location.href='event'">GS25</button></li>
			<li><button class="tablink myboard" onclick="location.href='slevent'">세븐일레븐</button></li>
			<li><button class="tablink myheart" onclick="location.href='cuevent'">CU</button></li>
		</ul>
	</div>	

<ul>
	<c:forEach var="list" items="${list }">
		<li class="eventli">
			${list }
		</li>
	</c:forEach>
</ul>
<jsp:include page="../default/footer.jsp" />
</body>
</html>