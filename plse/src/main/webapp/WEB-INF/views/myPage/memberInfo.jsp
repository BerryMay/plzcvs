<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

	<script  type="text/javascript" src="js/jquery-confirm.js"></script><!-- confirm띄우기  -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"><!-- confirm css  -->
<script>
$(document).ready(function($) {

	//회원탈퇴
	$("#conf_btn").click(function(){
		var user = '<%=(String)session.getAttribute("userId")%>';
		$.confirm({
		    title: '회원탈퇴',
		    content: '정말로 탈퇴하시겠습니까?',
		    buttons: {
		        "예": function () {
		            alert("회원탈퇴가 정상적으로 이루어졌습니다. 안녕히 가세요!");
					location.href='withdrawal?nickname='+user;
		        },
		        "아니요": function () {
		            location.href='mypage?nickname='+user;
		        }  
		    }
		}); 
		
	});

	
	
	//회원정보수정
	// şifre kurallı değilse butonu disable et
	$('#reg_userpassword').keyup(function() {
		var password = $('#reg_userpassword').val();
		var confirmpassword = $('#reg_userpasswordconfirm').val();

		if (checkStrength(password) == false) {
			$('#reg_submit').attr('disabled', true);
		}
	});

	// password-rule divi hide/show
	$('#reg_userpassword').keyup(
		function() {
			if ($('#reg_userpassword').val()) {
				$('#reg_passwordrules').removeClass('hide');
				$('#reg-password-strength').removeClass('hide');
			} else {
				$('#reg_passwordrules').addClass('hide');
				$('#reg-password-quality').addClass('hide')
				$('#reg-password-quality-result').addClass('hide')
				$('#reg-password-strength').addClass('hide')
			}
	});

	// password-confirm error divi hide/show
	$('#reg_userpasswordconfirm').blur(function() {
		if ($('#reg_userpassword').val() !== $('#reg_userpasswordconfirm').val()) {
			$('#error-confirmpassword').removeClass('hide');
			$('#reg_submit').attr('disabled', true);
		} else {
			$('#error-confirmpassword').addClass('hide');
			$('#reg_submit').attr('disabled', false);
		}
	});

	$('#reg_submit').hover(function() {
		if ($('#reg_submit').prop('disabled')) {
			$('#reg_submit').popover({
				html : true,
				trigger : 'hover',
				placement : 'below',
				offset : 20,
				content : function() {
					return $('#sign-up-popover').html();
				}
			});
		}
	});
	// karakter doğrulama
	function checkStrength(password) {
		var strength = 0;

		//대소문자체크
		if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) {
			strength += 1;
			$('.low-upper-case').addClass('text-success');
			$('.low-upper-case i').removeClass('fa-check').addClass('fa-check');
			$('#reg-password-quality').addClass('hide');

		} else {
			$('.low-upper-case').removeClass('text-success');
			$('.low-upper-case i').addClass('fa-check').removeClass('fa-check');
			$('#reg-password-quality').removeClass('hide');
		}

		//숫자체크
		if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)) {
			strength += 1;
			$('.one-number').addClass('text-success');
			$('.one-number i').removeClass('fa-check').addClass('fa-check');
			$('#reg-password-quality').addClass('hide');

		} else {
			$('.one-number').removeClass('text-success');
			$('.one-number i').addClass('fa-check').removeClass('fa-check');
			$('#reg-password-quality').removeClass('hide');
		}

		//특수기호체크
		if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) {
			strength += 1;
			$('.one-special-char').addClass('text-success');
			$('.one-special-char i').removeClass('fa-check').addClass('fa-check');
			$('#reg-password-quality').addClass('hide');

		} else {
			$('.one-special-char').removeClass('text-success');
			$('.one-special-char i').addClass('fa-check').removeClass('fa-check');
			$('#reg-password-quality').removeClass('hide');
		}

		if (password.length > 7) {//패스워드 글자수체크
			strength += 1;
			$('.eight-character').addClass('text-success');
			$('.eight-character i').removeClass('fa-check').addClass('fa-check');
			$('#reg-password-quality').removeClass('hide');

		} else {
			$('.eight-character').removeClass('text-success');
			$('.eight-character i').addClass('fa-check').removeClass('fa-check');
			$('#reg-password-quality').removeClass('hide');
		}
		// ------------------------------------------------------------------------------
		// If value is less than 2
		if (strength == 4) {
			$('#reg-password-quality-result').removeClass()
			$('#reg-password-quality-result').addClass('strong');
			$('#password-strength').removeClass('progress-bar-warning');
			$('#password-strength').addClass('progress-bar-success');
			$('#reg-password-quality-result').addClass('text-success').text('조건에 만족합니다.');
			$('#password-strength').css('width', '100%');
			return 'Strong'
		} else {
			$('#reg-password-quality-result').removeClass()
			$('#password-strength').addClass('progress-bar-danger');
			
			$('#reg-password-quality-result').addClass('text-danger').text('조건에 만족하지 않습니다.');
			$('#password-strength').css('width', '10%');
		}
	}
});

// Şifre gizle göster
function togglePassword() {
	var element = document.getElementById('reg_userpassword');
	element.type = (element.type == 'password' ? 'text' : 'password');
};

</script>
</head>
<body>
<div class="info_div">
		<form action="member_modify" method="post">
			<div class="form-group">
				<label>ID</label> <input type="text"
					id="reg_username" name="id" class="form-control" value="${dto.id }"
					required readonly>
			</div>
			<!-- NickName -->
			<div class="form-group">
				<label>Nickname</label> <input type="text"
					id="reg_nickname" name="nickname" class="form-control"
					value="${dto.nickname }" placeholder="Nickname" required readonly>
			</div>
			<!-- point -->
			<div class="form-group">
				<label>Point</label> <input type="text" id="point" name="point" class="form-control"
					value="${dto.point }" required readonly>
			</div>
			
			<div class="form-group" style="text-align: left">
			<label>성별 </label> 	
				<input type="radio" name="gender" value="male" <c:if test='${dto.gender=="male"}'>checked</c:if> >남
				&nbsp; <input type="radio" name="gender" value="female" <c:if test='${dto.gender=="female"}'>checked</c:if> >여
			</div>
			
			<div class="form-group" style="text-align: left">
				<label>생년월일</label> 	  
				<input id="age" name="age" type="date" class="form-control"  value="${dto.age.split(' ')[0]}">
				
			</div>
			<div class="form-group">
				<label>E-mail Address</label> 
				<input
					type="email" id="reg_useremail" name="mail"
					class="form-control" value="${dto.mail }" placeholder="xxx@xxx.com" required readonly>
			</div>
			
			<!-- password group -->
			<div class="form-goup">
				<!-- password label -->
				<label>Password</label>
				<!-- password input -->
				<div class="input-group">
					<input type="password" id="reg_userpassword"
						name="pw" class="form-control"
						data-placement="bottom" data-toggle="popover"
						data-container="body" data-html="true" value=""
						placeholder="Password" required>

					<div class="input-group-append">
						<button class="btn btn-outline-secondary" type="button"
							id="buttonappend1" onclick="togglePassword()">
							<i class="fa fa-eye" aria-hidden="true"></i>
						</button>
					</div>
				</div>
				<!-- password progresbar -->
				<div class="progress mt-1" id="reg-password-strength">
					<div id="password-strength"
						class="progress-bar progress-bar-success" role="progressbar"
						aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"
						style="width: 0%"></div>
				</div>
				
				<!-- Password Rules -->
				<div id="reg_passwordrules" class="hide password-rule mt-2">
					<small>
						<ul class="list-unstyled">
							<li class=""><br><span class="eight-character"><i
									class="fa fa-check-circle" aria-hidden="true"></i></span> 최소
								8글자 입력하여야 합니다.</li>
							<li class=""><span class="low-upper-case"><i
									class="fa fa-check-circle" aria-hidden="true"></i></span> 최소
								한글자의 대문자와 소문자를 포함하여야 합니다.</li>
							<li class=""><span class="one-number"><i
									class="fa fa-check-circle" aria-hidden="true"></i></span> 숫자를
								포함하여야 합니다.</li>
							<li class=""><span class="one-special-char"><i
									class="fa fa-check-circle" aria-hidden="true"></i></span> 특수기호를
								포함하여야합니다. (!@#$%^&*)</li>
						</ul>
					</small>
				</div>

			</div>

			<!-- password-confirm group -->
			<div class="form-group">

				<!-- password-confirm label -->
				<label class="sr-only">Password Confirm</label>
				<!-- password-confirm input -->
				<div class="input-group">
					<input type="password" id="reg_userpasswordconfirm"
						class="form-control" data-placement="bottom"
						data-toggle="popover" data-container="body" data-html="true"
						placeholder="Password Confirm" required>

					<div class="input-group-append">
						<button class="btn btn-outline-secondary" type="button"
							id="button-append2" onclick="togglePassword()">
							<i class="fa fa-eye" aria-hidden="true"></i>
						</button>
					</div>

				</div>
				<!-- password-confirm error message -->
				<div class="help-block text-right">
					<small><span id="error-confirmpassword"
						class="hide pull-right block-help"> <i
							class="fa fa-info-circle text-danger" aria-hidden="true"></i>Don't match password
					</span></small>
				</div>

			</div>
			<hr>
			<div class="form-btn">
				<input id="reg_submit" type="submit" value="수정" class="form-btn_btn">
				<div id="sign-up-popover" class="hide">
					<p>is empty</p>
				</div>
			</div>
			<div class="form-btn">
				<input  class="form-btn_btn"  type="button" id="conf_btn" value="회원 탈퇴" />
					<div id="confirm" title="회원 탈퇴"  class="hide">
						<p>정말로 탈퇴하시겠습니까?</p>
					</div>
			</div>
		</form>
	</div>
</body>
</html>