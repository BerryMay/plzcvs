<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript" src="resources/jquery-3.4.1.min.js"></script> <!-- 기본 jquery -->
	<script src="resources/js/moment.js"></script><!-- 시간띄우기 -->

	<link
		href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
		rel="stylesheet" id="bootstrap-css"> 
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.min.css" />
	<link rel="stylesheet" href="css/board.css" type="text/css" />
	<link rel="stylesheet" href="css/mypage.css" type="text/css" />

<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<c:if test="${userId != '관리자' }">
		<script type="text/javascript">
			alert("관리자가 아닙니다")
			location.href="main";
	   </script>
	</c:if>
	<jsp:include page="../default/header.jsp" />
	
	
	<h2>관리자 페이지</h2>
	<!-- 메뉴 -->
	<div class="mymenu_div">
		<ul class="myMenu">
			<li><a href="adminPost"><button class="tablink active">상품등록</button></a></li>
			<li><a href="adminMember"><button class="tablink active">멤버보기</button></a></li>
			<li><a href="adminProduct"><button class="tablink active">상품보기</button></a></li>
		</ul>
	</div>	

</body>
</html>