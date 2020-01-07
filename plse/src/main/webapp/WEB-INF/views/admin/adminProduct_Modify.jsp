<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="resources/jquery-3.4.1.min.js"></script><!-- 기본 jquery -->
<script src="resources/js/moment.js"></script><!-- 시간띄우기 -->

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.min.css" />
<link rel="stylesheet" href="css/board.css" type="text/css" />
<link rel="stylesheet" href="css/mypage.css" type="text/css" />
<link rel="stylesheet" href="css/adminPost.css" type="text/css" />
<!-- 사진 클릭시 지우기 -->
<script type="text/javascript">
	function deleteImgAction(index) {
		sel_files.splice(index, 1);
		var img_id = "#img_id_" + index;
		$(img_id).remove();
	}
</script>
<title>관리자 물품수정</title>
</head>
<body>
	<c:if test="${userId != '관리자' }">
		<script type="text/javascript">
			alert("관리자가 아닙니다")
			location.href="http://localhost:8989/practice/";
	   </script>
	</c:if>
	<jsp:include page="../default/header.jsp" />
	
	
	<h2>물품 수정 페이지</h2>
	<!-- 메뉴 -->
	<div class="mymenu_div">
		<ul class="myMenu">
			<li><a href="adminPost"><button class="tablink active">상품등록</button></a></li>
			<li><a href="adminMember"><button class="tablink">멤버보기</button></a></li>
			<li><a href="adminProduct"><button class="tablink">상품보기</button></a></li>
		</ul>
	</div>	
	<div align="center" style="margin-top: 50px">
	<form role="form" method="POST" autocomplete="off" id="postform"
		  enctype="multipart/form-data" action="adminProduct_ModifyOk">
		<div class="inputArea">
			<label>편의점</label> <select class="cvsnum" name="cvsnum">
				<option value="1" <c:if test="${product.cvsnum == 1 }">selected="selected"</c:if>>GS25</option>
				<option value="2" <c:if test="${product.cvsnum == 2 }">selected="selected"</c:if>>세븐일레븐</option>
				<option value="3" <c:if test="${product.cvsnum == 3 }">selected="selected"</c:if>>CU</option>
			</select>
		</div>
		
		<div class="productnum">
			<label for="gdsName">상품번호</label> <input type="text" id="productnum"
				name="productnum" value="${product.productnum }"/>
		</div>
		<div class="productname">
			<label for="gdsName">상품명</label> <input type="text" id="productname"
				name="productname" value="${product.productname }"/>
		</div>

		<div class="price">
			<label for="gdsPrice">상품가격</label> <input type="text" id="price"
				name="price" value="${product.price }"/>
		</div>
		<div>
			<label>상품사진</label> <input type="file" name="file" value="${product.gdsimg }">
			<input type="hidden" name="gdsimg" value="${product.gdsimg }">
		</div>
		<div class="select_img">
			<label>사진</label> <img src="${product.gdsimg }"/></div>
		</div>
		
		<div class="inputArea">
			<button type="submit" id="register_Btn" class="btn btn-primary">수정</button>
			<button class="btn btn-default" type="reset" onclick="javascript:history.back()">취소</button>
		</div>
		<!-- 이미지 미리보기 -->
            <script type="text/javascript">
            var sel_files = [];
            $(document).ready(function(){
            	$("#ex_filename").on("change", handImg);
            });
            function fileUploadAction(){
            	$("#ex_filename").trigger('click');
            }
            function handImg(e){
            	sel_files = [];
            	$(".select_img").empty();
            	
            	var files = e.target.files;
            	var filesArr = Array.prototype.slice.call(files);
            	var index = 0;
            	filesArr.forEach(function(f) {
            		if(!f.type.match("image.*")){
            			alert("확장자는 이미지 확장자만 가능합니다.");
            			return;
            		}
            		sel_files.push(f);
            		
            		var reader = new FileReader();
            		reader.onload = function(e){
            			var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImgAction("+index+")\" id=\"img_id_"+index+"\">"
            			+"<img src=\""+e.target.result+"\" data-file="+f.name+"' class='ProductImg' title='클릭 시 지워집니다'>";
            			
            			$(".select_img").append(html);
            			index++;
            		}
            		reader.readAsDataURL(f);
            	});
            }
            </script>
	</form>
	</div>
	<jsp:include page="../default/footer.jsp"/>
</body>
</html>