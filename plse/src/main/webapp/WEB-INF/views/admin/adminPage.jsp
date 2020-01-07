<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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

	<c:if test="${userId == null }">
	   <script type="text/javascript">
	      location.href="login";
	   </script>
	</c:if>
	<jsp:include page="../default/header.jsp" />
	
	
	<h2>마이 페이지</h2>
	<!-- 메뉴 -->
	<div class="mymenu_div">
		<ul class="myMenu">
			<li><button class="tablink active" onclick="openSection(event, 'mypage')">회원정보</button></li>
			<li><button class="tablink myboard" onclick="openSection(event, 'mypost')">내가 쓴 글</button></li>
			<li><button class="tablink myheart" onclick="openSection(event, 'heartpost')">좋아요한 글</button></li>
		</ul>
	</div>	
	
	<!-- 상품등록  -->
	<section id="mypage"  class="sec_content">
	<h3>상품등록</h3>
	<%@ include file="./adminPost.jsp" %>
	</section>
	
	
	<!-- 멤버보기 -->
	<section id="mypost" class="sec_content">
		<%@ include file="./adminMember.jsp" %>

	</section>

	<!-- 상품보기 -->
	<section id="heartpost" class="sec_content">
		<%@ include file="./adminProduct.jsp" %>
	</section>
	
	<jsp:include page="../default/footer.jsp" />
	
	<script>
	//myMenu : section 열기 -tab기능
	function openSection(evt, secName) {
		  var i, tabcontent, tablink;
		  tabcontent = document.getElementsByClassName("sec_content");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablink = document.getElementsByClassName("tablink");
		  for (i = 0; i < tablink.length; i++) {
			  tablink[i].className = tablink[i].className.replace(" active", "");
		  }
		  document.getElementById(secName).style.display = "block";
		  evt.currentTarget.className += " active";
	}
	//내가쓴글 : Article 열기 -tab기능
	function openArticle(evt, secName) {
		  var i, tabcontent, tablink;
		  tabcontent = document.getElementsByClassName("art_content");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablink = document.getElementsByClassName("art_tablink");
		  for (i = 0; i < tablink.length; i++) {
			  tablink[i].className = tablink[i].className.replace(" active", "");
		  }
		  document.getElementById(secName).style.display = "block";
		  evt.currentTarget.className += " active";
		
  
	}

	</script>


</body>
</html>