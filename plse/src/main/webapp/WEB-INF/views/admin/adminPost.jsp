<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="css/adminPost.css" type="text/css" />
<title>관리자 물품등록</title>
</head>
<body>
	<jsp:include page="../default/header.jsp"/>
	<div align="center" style="margin-top: 50px">
	<form role="form" method="POST" autocomplete="off" id="postform"
		  enctype="multipart/form-data" action="adminPostOk">
		<div class="inputArea">
			<label>편의점</label> <select class="cvsnum" name="cvsnum">
				<option value="1">GS25</option>
				<option value="2">세븐일레븐</option>
				<option value="3">CU</option>
			</select>
		</div>
		
		<div class="productnum">
			<label for="gdsName">상품번호</label> <input type="text" id="productnum"
				name="productnum" />
		</div>
		<div class="productname">
			<label for="gdsName">상품명</label> <input type="text" id="productname"
				name="productname" />
		</div>

		<div class="price">
			<label for="gdsPrice">상품가격</label> <input type="text" id="price"
				name="price" />
		</div>

		<div>
			<label>상품사진</label> <input type="file" name="file">
		</div>

		<div class="inputArea">
			<button type="submit" id="register_Btn" class="btn btn-primary">등록</button>
			<button class="btn btn-default" type="reset" onclick="javascript:history.back()">취소</button>
		</div>
		
	</form>
	</div>
	<jsp:include page="../default/footer.jsp"/>
</body>
</html>