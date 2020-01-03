<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<!--Bootsrap 4 CDN-->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<!--Fontawesome CDN-->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/login.css" type="text/css" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${userId != null }">
	<script type="text/javascript">
		alert("이미 로그인 하셨습니다")
		location.href="http://localhost:8989/practice/";
	</script>
</c:if>
	<jsp:include page="../default/header.jsp" />

	<div class="d-flex justify-content-center h-100">
		<div class="card">
			<div class="card-header">
				<h3>LOGIN</h3>
			</div>
			<div class="card-body">
				<form action="loginChk">
					<!-- 아이디 아이콘 -->
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-user"></i></span>
						</div>
						<input type="text" name="id" class="form-control" placeholder="username">
					</div>
					
					<!-- 비밀번호 아이콘 -->
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-key"></i></span>
						</div>
						<input type="password" name="pw" class="form-control" placeholder="password">
					</div>
					
					<!-- 기억하기 체크 박스 -->
					<div class="row align-items-center remember">
						<input type="checkbox">Remember Me
					</div>
					
					<!-- 로그인 버튼 -->
					<div class="form-group">
						<input type="submit" value="Login" class="btn float-right login_btn">
					</div>
				</form>
			</div>
			<div class="card-footer">
				<div class="d-flex justify-content-center links">
					<a href="register" style="color: #ffffff;">회원가입 하러가기</a>
				</div>
				<div class="d-flex justify-content-center">
					<a href="find_pw" style="color: #ffffff;">비밀번호 찾기</a>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../default/footer.jsp" />
</body>
</html>