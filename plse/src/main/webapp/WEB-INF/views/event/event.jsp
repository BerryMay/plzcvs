<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/event.css" type="text/css" />
</head>
<body>
<jsp:include page="../default/header.jsp" />
<div class="bigdiv">
	<div><a href="event">GS25</a></div>
	<div><a href="slevent">세븐일레븐</a></div>
	<div><a href="cuevent">CU</a></div>
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