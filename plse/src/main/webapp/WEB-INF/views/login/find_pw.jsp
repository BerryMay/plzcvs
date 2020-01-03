<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="css/login.css" type="text/css" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../default/header.jsp" />
<div class="d-flex justify-content-center h-100">
		<div class="card">
			<div class="card-header">
				<h3>비밀번호 찾기</h3>
			</div>
			<div class="card-body">
				<form action="find_pw_Chk">
					<!-- 아이디 아이콘 -->
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i>ID</i>
						</div>
						<input type="text" name="id" class="form-control" placeholder="username">
					</div>
					
					<!-- 이메일 아이콘 -->
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i>Mail</i></span>
						</div>
						<input type="text" name="mail" class="form-control" placeholder="xxx@xxx.com">
					</div>
					<!-- 비번찾기 버튼 -->
					<div class="form-group">
						<input type="submit" value="비밀번호 찾기" class="btn float-right findPw_btn">
					</div>
				</form>
			</div>
			<div class="card-footer">
				<div class="d-flex justify-content-center links">
					<a href="login" style="color: #ffffff;">로그인 하러가기</a>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="../default/footer.jsp" />
</body>
</html>