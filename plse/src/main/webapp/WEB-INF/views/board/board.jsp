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
			<b>게시판 </b>
		</div>
		<div align="center">
			<table class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th width="10%">번호</th>
						<th width="50%">제목</th>
						<th width="10%">작성자</th>
						<th width="20%">작성일</th>
						<th width="10%">조회</th>
					</tr>
				</thead>
				
				<tbody>
					<!-- hit 뜨게하는 코드 -->
					<c:if test="${article.hit >= 20}">
                  		<span class="hit">best!</span>
                	</c:if>
				</tbody>
			</table>
			 <div id="paging">
		        <!-- 페이징 구간 -->
		      </div>
		</div>
	</div>
	<jsp:include page="../default/footer.jsp" />
</body>
</html>