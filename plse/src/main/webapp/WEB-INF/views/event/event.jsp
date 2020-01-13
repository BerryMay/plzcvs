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
<script>
	function select_cvs() {
		function getParameterByName(name) {
		    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		        results = regex.exec(location.search);
		    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
		}

		var cvs = parseInt(getParameterByName('cvs'));
	
		
		  var i, tablink;
		  tablink = document.getElementsByClassName("tablink");

		  if(isNaN(cvs)){cvs=0;}
		  else{
			for (i = 0; i < tablink.length; i++) {
				  tablink[i].className = tablink[i].className.replace(" active", "");
			  }
			
		}
			tablink[cvs].className +=" active";

		

	}
</script>
</head>
<body onload="select_cvs()">
<jsp:include page="../default/header.jsp" />
<div class="mymenu_div">
		<ul class="myMenu eventMenu">
			<li><button class="tablink active" onclick="location.href='event?cvs=0'">GS25</button></li>
			<li><button class="tablink myboard" onclick="location.href='slevent?cvs=1'">세븐일레븐</button></li>
			<li><button class="tablink myheart" onclick="location.href='cuevent?cvs=2'">CU</button></li>
		</ul>
	</div>	

<ul class="event_priduct">
	<c:forEach var="list" items="${list }">
		<li class="eventli">
			${list }
		</li>
	</c:forEach>
</ul>

<jsp:include page="../default/footer.jsp" />
</body>
</html>