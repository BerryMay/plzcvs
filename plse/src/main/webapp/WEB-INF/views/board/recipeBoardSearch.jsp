<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 리스트</title>
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
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now }" pattern="yyyy.MM.dd" var="today"/>
</head>
<body>
	<jsp:include page="../default/header.jsp" />
	<div id="container">
		<div id="list">
			<h1>레시피 게시판</h1> 
			<br><br>
		</div>
		<div align="center">
			<table class="table table-striped table-bordered table-hover" style="width: 100%;">
				<thead>
					<tr height="42px" >
						<th style=" border-radius: 10px 0 0 0;" width="10%" >번호</th>
						<th width="50%">제목</th>
						<th width="10%">작성자</th>
						<th width="20%">작성일</th>
						<th style=" border-radius: 0 10px 0 0;" width="10%">조회</th>
					</tr>
				</thead>
				<tbody>
					<!-- 레시피 베스트글 -->
				<c:forEach var="bestDto" items="${best_list }">
					<fmt:formatDate value="${bestDto.savedate}" pattern="yyyy.MM.dd" var="savedate"/>
					
					
					<tr class="best_tr">
						<td style="text-align: center">${bestDto.num }</td>
					
						
						<td><a href="recipeDetail?num=${bestDto.num}" class="aw100" title="${bestDto.title }">${bestDto.title }
						
							<c:if test="${bestDto.gdsimg != null }">
								<input type="text" class="contentimg" readonly="readonly">
							</c:if>
							<!-- 댓글갯수 -->
							<c:if test="${bestDto.replycnt != 0 }">
								<span class="replycnt">(${bestDto.replycnt})</span>
							</c:if> 
							<!-- hit 뜨게하는 코드 -->
							<c:if test="${bestDto.hit >= 20}">
		                  		<span class="hit">best!</span>
		                	</c:if>
						</a></td>
						<td>${bestDto.nickname }</td>
						<td style="text-align: center">
							<c:if test="${today == savedate }"><fmt:formatDate value="${bestDto.savedate}" pattern="kk:mm"/></c:if>
							<c:if test="${today != savedate }">${savedate }</c:if>
						</td>
						<td style="text-align: center">${bestDto.hit }</td>
					</tr>
				</c:forEach>
				<c:if test="${dto.size() == 0 }">
					<tr>
						<td style="text-align: center" colspan="5">검색결과가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="dto" items="${dto }">
				<fmt:formatDate value="${dto.savedate}" pattern="yyyy.MM.dd" var="savedate"/>
					<tr>
						<td style="text-align: center">${dto.num }</td>
						<td><a href="detail?num=${dto.num}">${dto.title }
							<c:if test="${dto.gdsimg != null }">
								<input type="text" class="contentimg" readonly="readonly">
							</c:if> 
							<!-- hit 뜨게하는 코드 -->
							<c:if test="${dto.hit >= 20}">
	                  			<span class="hit">best!</span>
	                		</c:if>
                		</a></td>
						<td>${dto.nickname }</td>
						<td style="text-align: center">
							<c:if test="${today == savedate }"><fmt:formatDate value="${dto.savedate}" pattern="kk:mm"/></c:if>
							<c:if test="${today != savedate }">${savedate }</c:if>
						</td>
						<td style="text-align: center">${dto.hit }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			 <div id="paging">
		        <!-- 페이징 구간 -->
		      </div>
			<div align="right">
				<button class="btn" type="button" onclick="location.href='post'"><i class="fas fa-pen-fancy"></i> &nbsp; 글쓰기</button>
			</div>
		</div>
		<div align="center">
			<form action="recipeBoard_search" id="searchForm" name="searchForm">
			<select name="title" class="form-cvsnum form-control">
				<option value="productname">상품명</option>
				<option value="title">제목</option>
				<option value="nickname">작성자</option>
			</select>
			<input type="text" class="search_text" name="content"/>
			<input type="button" class="btn search_btn" value="검색" onclick="javascript:sChk()"/>
			</form>
		</div>
	</div>
	<jsp:include page="../default/footer.jsp" />
</body>
</html>