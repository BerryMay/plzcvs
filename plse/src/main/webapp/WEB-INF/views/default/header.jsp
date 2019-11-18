<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<li><a href="#">로그인</a></li>|
				<li><a href="#">회원가입</a></li>|
				<li><a href="#">리뷰게시판</a></li>
			</ul>
			<h1 id="logo">
				<a href="#"></a>
			</h1>


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