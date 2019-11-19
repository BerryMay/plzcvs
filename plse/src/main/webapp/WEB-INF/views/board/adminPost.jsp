<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
.inputArea { margin:10px 0; }
select { width:100px; }
label { display:inline-block; width:70px; padding:5px; }
label[for='gdsDes'] { display:block; }
input { width:150px; }
textarea#gdsDes { width:400px; height:180px; }
</style>
<title>관리자 물품등록</title>
</head>
<body>
<form role="form" method="post" autocomplete="off">

<div class="inputArea"> 
 <label>편의점</label>
 <select class="category1">
  <option value="">GS25</option>
  <option value="">세븐일레븐</option>
  <option value="">CU</option>
 </select>
</div>

<div class="inputArea">
 <label for="gdsName">상품명</label>
 <input type="text" id="gdsName" name="gdsName" />
</div>

<div class="inputArea">
 <label for="gdsPrice">상품가격</label>
 <input type="text" id="gdsPrice" name="gdsPrice" />
</div>

<div>
	<label>상품사진</label>
	<input type="file" id="gdspic" name="gdspic">
</div>


<div class="inputArea">
 <button type="submit" id="register_Btn" class="btn btn-primary">등록</button>
</div>

</form>
</body>
</html>