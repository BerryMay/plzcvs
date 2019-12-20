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
<!-- js파일-->
    <script type="text/javascript" src="resources/jquery-3.4.1.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

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
<!-- 실시간검색어  -->
<script type="text/javascript">
	function searchList(){
		var output="";
		$.ajax({
			url:"board_searchCnt",
			type:"POST",
			success:function(data){
				$("#searchCntTable").empty();
				output += "<tr><th colspan='2'><b>실시간검색어</b></th></tr>"
				for(i=0; i<data.length; i++){
					output += "<tr>"
					output += "<th>"+(i+1)+"</th>"
					output += "<th><a href=board_search?content="+data[i].title+">"+data[i].title+"</a></th>";
					output += "</tr>"
					if(i == 4) break;
				}
				$("#searchCntTable").append(output);
			},
			error:function(){
				$("#searchCntTable").empty();
				output += "<tr><th colspan='2'><b>실시간검색어</b></th></tr>"
				console.log("실시간검색어 에러")
				output += "<tr>"
				output += "<td colspan='2'>검색 데이터가 없습니다</td>";
				output += "</tr>"
				$("#searchCntTable").append(output);
			}
		});
	}
	setInterval(searchList, 5000)


</script>
<title>Insert title here</title>
</head>
<body onload="searchList()">
	<div id="wrap" >

		<header>
			<ul id="top">
				<li><c:choose>
						<c:when test="${userId == null }">
							<a href="login">로그인</a>
						</c:when>
						<c:otherwise>
							<a href="logout">${userId } 로그아웃</a>
						</c:otherwise>
					</c:choose></li>|
				<c:if test="${userId == null }">
					<li><a href="register">회원가입</a></li>|
				</c:if>
				<li><a href="board">리뷰게시판</a></li>
			</ul>
				
			<h1 id="logo">
				<a class="logo" href="http://localhost:8989/practice/"></a>
			</h1>

		<aside id="search_aside">
			<div>
				<!-- 실시간검색어 테이블 -->
				<table id="searchCntTable">
				</table>
			</div>
		</aside>
			<nav id="nav">
				<ul>
					<li><a href="board">리뷰 게시판</a></li>
					<li><a href="#">레시피 게시판</a></li>
					<li><a href="#">그래프</a></li>
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