<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/header.css" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />


<script>
        function stop(nav) {
          var x = document.getElementById("nav");
            var btn = document.getElementById("nav_btn");
            console.log(x.style.left);
          if (x.style.left == '-95%' || x.style.left == '') {
            x.style.left = 0;
              btn.innerHTML="<i class='fas fa-angle-left fa-2x'></i>";
          } else {
            x.style.left = '-95%';
              btn.innerHTML="<i class='fas fa-angle-right fa-2x'></i>";
          }
        }
</script>
<title>Insert title here</title>
</head>
<body>
	<div id="wrap">

		<header>
			<ul id="top">
				<li>
					<c:choose>
						<c:when test="${userId == null }">
							<a href="login">로그인</a>
						</c:when>
						<c:otherwise>
							<a href="logout">${userId } 로그아웃</a>
						</c:otherwise>
					</c:choose>
				</li>|
				<c:if test="${userId == null }">
					<li><a href="register">회원가입</a></li>|
				</c:if>
				<li><a href="board">리뷰게시판</a></li>
			</ul>
				<a href="http://localhost:8989/practice/">
			<h1 id="logo">
			</h1>
				</a>

			<nav id="nav">
				<ul>
					<li><a href="#"></a></li>
					<li><a href="#"></a></li>
					<li><a href="#"></a></li>
				</ul>
				<button id="nav_btn" onclick="stop('nav')">
					<i class="fas fa-angle-right fa-2x"></i>
				</button>
			</nav>
			<hr>
		</header>
		<div id="contents">
</body>
</html>