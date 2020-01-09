<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="resources/jquery-3.4.1.min.js"></script><!-- 기본 jquery -->
<script src="resources/js/moment.js"></script><!-- 시간띄우기 -->

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.min.css" />
<link rel="stylesheet" href="css/board.css" type="text/css" />
<link rel="stylesheet" href="css/mypage.css" type="text/css" />
<link rel="stylesheet" href="css/adminPost.css" type="text/css" />
<title>관리자 물품등록</title>
</head>
<body>
	<c:if test="${dto.verify != 9 }">
		<script type="text/javascript">
			alert("관리자가 아닙니다")
			location.href="http://localhost:8989/practice/";
	   </script>
	</c:if>
	<jsp:include page="../default/header.jsp" />
	
	<h2>관리자 페이지</h2>
	<!-- 메뉴 -->
	<div class="mymenu_div">
		<ul class="myMenu">
			<li><a href="adminPost?nickname=${userId }"><button class="tablink">상품등록</button></a></li>
			<li><a href="adminMember?nickname=${userId }"><button class="tablink">멤버보기</button></a></li>
			<li><a href="adminProduct?nickname=${userId }"><button class="tablink active">상품보기</button></a></li>
		</ul>
	</div>
	<div class="product_div">
	<table class="product_table">
		<tr>
			<c:forEach var="product" items="${product }" varStatus="cnt">
				<td><div><a href="adminProduct_modify?productnum=${product.productnum }&nickname=${userId}">
				<img src="${product.gdsimg }" class="productimg"></div>
					<div>${product.productname }</div>
					<div>${product.price }</div>
				</a></div></td>
				<c:if test="${(cnt.index+1) % 5 == 0 }"></tr><tr></c:if>
			</c:forEach>
		</tr>
	</table>
	</div>
	<jsp:include page="../default/footer.jsp"/>
</body>
</html>
