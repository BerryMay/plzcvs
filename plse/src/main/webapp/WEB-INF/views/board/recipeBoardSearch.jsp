<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 리스트</title>
<!-- Bootstrap -->
<link rel="stylesheet" href="css/board.css" type="text/css" />
<script type="text/javascript">
	function sChk(){
		if(document.searchForm.content.value==""){
			alert("검색어를 입력해주세요")
		}else{
			document.searchForm.submit();
		}
	}
</script>
</head>
<body>
	<jsp:include page="../default/header.jsp" />
	<div id="container">
		<div id="list">
			<h1>레시피게시판</h1> 
			<br><br>
		</div>
		<div align="center">
			<table class="table table-striped table-bordered table-hover" style="width: 100%;">
				<thead>
					<tr>
						<th style=" border-radius: 10px;" width="10%" height="30px" >번호</th>
						<th style=" border-radius: 10px;" width="10%" height="30px" >상품명</th>
						<th style=" border-radius: 10px;" width="40%" height="30px">제목</th>
						<th style=" border-radius: 10px;" width="10%" height="30px">작성자</th>
						<th style=" border-radius: 10px;" width="20%" height="30px">작성일</th>
						<th style=" border-radius: 10px;" width="10%" height="30px">조회</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
				<c:forEach var="dto" items="${dto }">
					<tr>
						<td style="text-align: center">${dto.num }</td>
						<td style="text-align: center">${dto.productname }</td>
						<td><a href="detail?num=${dto.num}">${dto.title }</a>
						<!-- hit 뜨게하는 코드 -->
						<c:if test="${dto.hit >= 20}">
                  			<span class="hit">best!</span>
                		</c:if></td>
						<td>${dto.nickname }</td>
						<td style="text-align: center"><fmt:formatDate value="${dto.savedate}" pattern="yyyy.MM.dd kk:mm"/></td>
						<td style="text-align: center">${dto.hit }</td>
					</tr>
				</c:forEach>
			</table>
			 <div id="paging">
		        <!-- 페이징 구간 -->
		      </div>
			<div align="right">
				<input type="button" value="글쓰기" onclick="location.href='post'"
					style="border-radius: 10px;" height="30px">
			</div>
		</div>
		<div align="center">
			<form action="recipeBoard_search" id="searchForm" name="searchForm">
			<select name="title" class="form-cvsnum form-control">
				<option value="productname">상품명</option>
				<option value="title">제목</option>
				<option value="nickname">작성자</option>
			</select>
			<input type="text" name="content"/>
			<input type="button" value="검색" onclick="javascript:sChk()"/>
			</form>
		</div>
	</div>
	<jsp:include page="../default/footer.jsp" />
</body>
</html>