<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 리스트</title>
<!-- Bootstrap -->
<link rel="stylesheet" href="css/board.css" type="text/css" />
</head>
<body>
	<jsp:include page="../default/header.jsp" />
	<div id="container">
		<div id="list">
			<h1>게시판</h1> 
			<br><br>
		</div>
		<div align="center">
			<table class="table table-striped table-bordered table-hover" style="width: 100%;">
				<thead>
					<tr>
						<th style=" border-radius: 10px;" width="10%" height="30px" >번호</th>
						<th style=" border-radius: 10px;" width="50%" height="30px">제목</th>
						<th style=" border-radius: 10px;" width="10%" height="30px">작성자</th>
						<th style=" border-radius: 10px;" width="20%" height="30px">작성일</th>
						<th style=" border-radius: 10px;" width="10%" height="30px">조회</th>
					</tr>
				</thead>
				<tbody>
					<!-- hit 뜨게하는 코드 -->
					<c:if test="${article.hit >= 20}">
                  		<span class="hit">best!</span>
                	</c:if>
				</tbody>
				<c:forEach var="dto" items="${list }">
					<tr>
						<td style="text-align: center">${dto.num }</td>
						<td><a href="detail?num=${dto.num}">${dto.title }</td>
						<td>${dto.nickname }</td>
						<td style="text-align: center">${dto.savedate }</td>
						<td style="text-align: center">${dto.hit }</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="4"></td>
					<th>
					<input type="button" value="글쓰기" onclick="location.href='post'" style=" border-radius: 10px;" height="30px"></th>
				</tr>
			</table>
			 <div id="paging">
		        <!-- 페이징 구간 -->
		      </div>
		</div>
	</div>
	<jsp:include page="../default/footer.jsp" />
</body>
</html>