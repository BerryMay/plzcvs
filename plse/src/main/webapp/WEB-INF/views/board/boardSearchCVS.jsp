<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 리스트</title>
<!-- js파일-->
    <script type="text/javascript" src="resources/jquery-3.4.1.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    

    
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

<script type="text/javascript">

	$(function(){
		$("#cvssearchs").change(function(){
			if(cvssearchs.value ='9'){
				location.href="board"
			}else{
				document.cvsSearchForm.submit();
			}
		});
	});
</script>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now }" pattern="yyyy.MM.dd" var="today"/>
<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="nowdate"></fmt:parseNumber>

</head>
<body>
	<jsp:include page="../default/header.jsp" />
	<div id="container">
		<div id="list">
			<h1>편의점 별 리뷰 게시판</h1> 
			<br><br>
		</div>
		
		<form action="cvs_search" id="cvsSearchForm" name="cvsSearchForm">
	<select name="cvsnum" id="cvssearchs" class="form-cvsnum form-control">
		<option value="0">편의점선택</option>
		<option value="9">모두보기</option>
		<option value="1">GS25</option>
		<option value="2">세븐일레븐</option>
		<option value="3">CU</option>
	</select>
	</form>
	

		<div align="center">
			<table class="table table-striped table-bordered table-hover" style="width: 100%;">
				<thead>
					<tr height="42px" >
						<th style=" border-radius: 10px 0 0 0;" width="5%" >번호</th>
						<th width="10%">편의점</th>
						<th width="15%">상품명</th>
						<th width="40%">제목</th>
						<th width="10%">작성자</th>
						<th width="10%">작성일</th>
						<th style=" border-radius: 0 10px 0 0;" width="10%">조회</th>
					</tr>
				</thead>
				<tbody>

				<!-- 베스트 게시글 3개띄우기 -->	
				<c:forEach var="bestDto" items="${best_list }">
					<fmt:formatDate value="${bestDto.savedate}" pattern="yyyy.MM.dd" var="savedate"/>
					<fmt:formatDate value="${bestDto.newproduct}" pattern="yyyy.MM.dd" var="newproducts"/>
					<fmt:parseNumber value="${bestDto.newproduct.time / (1000*60*60*24)}" integerOnly="true" var="chgDttm"></fmt:parseNumber>
				
					<tr class="best_tr">
						<td style="text-align: center">${bestDto.num }</td>
						<td style="text-align: center">
							<c:choose>
								<c:when test="${bestDto.cvsnum == 1 }">GS25</c:when>
								<c:when test="${bestDto.cvsnum == 2 }">세븐일레븐</c:when>
								<c:when test="${bestDto.cvsnum == 3 }">CU</c:when>
							</c:choose>
						</td>
						
						<!-- new 상품명 뜨는곳  --> 
						<td style="text-align: center" title="${bestDto.productname }" >${bestDto.productname }
							<c:if test="${nowdate - chgDttm < 30}">
								<span class="new">new!</span>
							</c:if>
						</td>
						
						<td><a href="detail?num=${bestDto.num}" class="aw100" title="${bestDto.title }">${bestDto.title }
							<c:if test="${bestDto.gdsimg != null }">
								<input type="text" class="contentimg" readonly="readonly">
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
						<td style="text-align: center" colspan="7">검색결과가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="dto" items="${list }">
				<fmt:formatDate value="${dto.savedate}" pattern="yyyy.MM.dd" var="savedate"/>
				<fmt:formatDate value="${dto.newproduct}" pattern="yyyy.MM.dd" var="newproducts"/>
				<fmt:parseNumber value="${dto.newproduct.time / (1000*60*60*24)}" integerOnly="true" var="chgDttm"></fmt:parseNumber>
					<tr>
						<td style="text-align: center">${dto.num }</td>
						<td style="text-align: center"><c:choose>
								<c:when test="${dto.cvsnum == 1 }">GS25</c:when>
								<c:when test="${dto.cvsnum == 2 }">세븐일레븐</c:when>
								<c:when test="${dto.cvsnum == 3 }">CU</c:when>
							</c:choose></td>					
						
							
						<!-- new 상품명 뜨는곳  --> 
						<td style="text-align: center" title="${dto.productname }" >${dto.productname }
							<c:if test="${nowdate - chgDttm < 30}">
								<span class="new">new!</span>
							</c:if>
						</td>
						
						<td><a href="detail?num=${dto.num}" class="aw100" title="${dto.title }">${dto.title }
							<!-- 댓글갯수 -->
							<c:if test="${dto.replycnt != 0 }">
								<span class="replycnt">(${dto.replycnt}) </span>
							</c:if> 
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
		        <!--  현재 페이지 번호 -->
				<c:choose>
					<c:when test="${param.start == null}">
						<!-- 처음엔 start값이 없으니깐 만들어주기위함 -->
						<c:set var="start" value="1" scope="session" />
					</c:when>
					<c:otherwise>
						<!-- 링크 클릭시 start값을 넘겨주니깐 그대로 받는다. -->
						<c:set var="start" value="${param.start}" scope="session" />
					</c:otherwise>
				</c:choose>
				
				<!-- 계산해서 페이지 번호 나타내주기 -->
				<c:forEach begin="1" end="${pc.totEndPage }" step="1" var="cnt">
					<a href="cvs_search?start=${cnt }">[${cnt }]</a>		
				</c:forEach><br>
				
				<!-- 전체페이지 출력 -->
				${start} / ${pc.totEndPage}
		      </div>
			<div align="right">
				<button class="btn" type="button" onclick="location.href='post'"><i class="fas fa-pen-fancy"></i> &nbsp; 글쓰기</button>
			</div>
		</div>
		<div align="center">
			<form action="board_search" id="searchForm" name="searchForm">
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