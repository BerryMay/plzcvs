<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>


<script src='https://www.google.com/recaptcha/api.js'></script>

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/register.css" type="text/css" />

<script>
	$(document)
			.ready(
					function() {
						// şifre kurallı değilse butonu disable et
						$('#reg_userpassword')
								.keyup(
										function() {
											var password = $(
													'#reg_userpassword').val();
											var confirmpassword = $(
													'#reg_userpasswordconfirm')
													.val();

											if (checkStrength(password) == false) {
												$('#reg_submit').attr(
														'disabled', true);
											}
										});

						// password-rule divi hide/show
						$('#reg_userpassword').keyup(
								function() {
									if ($('#reg_userpassword').val()) {
										$('#reg_passwordrules').removeClass(
												'hide');
										$('#reg-password-strength')
												.removeClass('hide');
									} else {
										$('#reg_passwordrules')
												.addClass('hide');
										$('#reg-password-quality').addClass(
												'hide')
										$('#reg-password-quality-result')
												.addClass('hide')
										$('#reg-password-strength').addClass(
												'hide')

									}
								});

						// password-confirm error divi hide/show
						$('#reg_userpasswordconfirm')
								.blur(
										function() {
											if ($('#reg_userpassword').val() !== $(
													'#reg_userpasswordconfirm')
													.val()) {
												$('#error-confirmpassword')
														.removeClass('hide');
												$('#reg_submit').attr(
														'disabled', true);
											} else {
												$('#error-confirmpassword')
														.addClass('hide');
												$('#reg_submit').attr(
														'disabled', false);
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
						
						
						$('#reg_submit').click(function() {
							
						
								alret("help~~");
						});
						
						
						
						
						
						// karakter doğrulama
						function checkStrength(password) {
							var strength = 0;

							//If password contains both lower and uppercase characters, increase strength value.
							if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) {
								strength += 1;
								$('.low-upper-case').addClass('text-success');
								$('.low-upper-case i').removeClass('fa-check')
										.addClass('fa-check');
								$('#reg-password-quality').addClass('hide');

							} else {
								$('.low-upper-case')
										.removeClass('text-success');
								$('.low-upper-case i').addClass('fa-check')
										.removeClass('fa-check');
								$('#reg-password-quality').removeClass('hide');
							}

							//If it has numbers and characters, increase strength value.
							if (password.match(/([a-zA-Z])/)
									&& password.match(/([0-9])/)) {
								strength += 1;
								$('.one-number').addClass('text-success');
								$('.one-number i').removeClass('fa-check')
										.addClass('fa-check');
								$('#reg-password-quality').addClass('hide');

							} else {
								$('.one-number').removeClass('text-success');
								$('.one-number i').addClass('fa-check')
										.removeClass('fa-check');
								$('#reg-password-quality').removeClass('hide');
							}

							//If it has one special character, increase strength value.
							if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) {
								strength += 1;
								$('.one-special-char').addClass('text-success');
								$('.one-special-char i')
										.removeClass('fa-check').addClass(
												'fa-check');
								$('#reg-password-quality').addClass('hide');

							} else {
								$('.one-special-char').removeClass(
										'text-success');
								$('.one-special-char i').addClass('fa-check')
										.removeClass('fa-check');
								$('#reg-password-quality').removeClass('hide');
							}

							if (password.length > 7) {
								strength += 1;
								$('.eight-character').addClass('text-success');
								$('.eight-character i').removeClass('fa-check')
										.addClass('fa-check');
								$('#reg-password-quality').removeClass('hide');

							} else {
								$('.eight-character').removeClass(
										'text-success');
								$('.eight-character i').addClass('fa-check')
										.removeClass('fa-check');
								$('#reg-password-quality').removeClass('hide');
							}
							// ------------------------------------------------------------------------------
							// If value is less than 2
							if (strength == 4) {
								$('#reg-password-quality-result').removeClass()
								$('#reg-password-quality-result').addClass(
										'strong');
								$('#password-strength').removeClass(
										'progress-bar-warning');
								$('#password-strength').addClass(
										'progress-bar-success');
								$('#reg-password-quality-result').addClass(
										'text-success').text('조건에 만족합니다.');
								$('#password-strength').css('width', '100%');
								return 'Strong'
							} else {
								$('#reg-password-quality-result').removeClass()
								$('#password-strength').addClass(
										'progress-bar-danger');

								$('#reg-password-quality-result').addClass(
										'text-danger').text('조건에 만족하지 않습니다.');
								$('#password-strength').css('width', '10%');
							}
						}
					});

	// Şifre gizle göster
	function togglePassword() {

		var element = document.getElementById('reg_userpassword');
		element.type = (element.type == 'password' ? 'text' : 'password');

	};
	
	$(document).ready(function() {
		//아이디 중복 
		$("#id").blur(function() {
		var id = $('#id').val();
		console.log(id);
		$.ajax({
			url : 'user/idCheck?id='+id,
			type : 'get',
			success : function(data) {
				console.log("1 = 중복o / 0 = 중복x : "+ data);							
				
				if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다 :p");
						$("#id_check").css("color", "red");
						
					} else {
						$("#id_check").text("사용가능한 아이디입니다 :p");
						$("#id_check").css("color", "red");
							
					}
				}, error : function() {
						console.log("실패");
				}
			});
		});
	});
	
</script>

</head>

<body>
<c:if test="${userId != null }">
	<script type="text/javascript">
		location.href="history.back()";
	</script>
</c:if>
	<jsp:include page="../default/header.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-5" style="box-shadow: rgba(0, 0, 0, 0.3) 7px 7px 7px; border-radius: 20px; border:3px solid  #ff9999; ">
				<div class="card-cardbox">
					<div class="card-header" style="text-align: center;">회원가입</div>
					<div class="card-body">
						<div class="form-group">
							<form action="registerChk" id="Mregister" method="post" role="form" class="form"
								accept-charset="UTF-8">
								
								
									
								<!-- id 지정 -->
								<div class="form-group">
								<input type="text" id="id" name="id" class="form-control" placeholder="Id" required>
							
								<div class="check_font" id="id_check"></div>	
							
								 </div>
								 
								<!-- password group -->
								<div class="form-group">

									<!-- password label -->
									<label class="sr-only">Password</label>
									<!-- password input -->
									<div class="input-group">
										<input type="password" id="reg_userpassword"
											name="pw" class="form-control"
											data-placement="bottom" data-toggle="popover"
											data-container="body" data-html="true" value=""
											placeholder="Password" required>

										<div class="input-group-append">
											<button class="btn btn-outline-secondary" type="button"
												id="button-append1" onclick="togglePassword()">
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
									<!-- password remember & results -->
									<div class="help-block text-right">
										<small><a href="#">Forgot Password</a></small> <span
											id="reg-password-quality" class="hide pull-left block-help">
											<small>Password <span
												id="reg-password-quality-result"></span></small>
										</span>
									</div>
									<!-- Password Rules -->
									<div id="reg_passwordrules" class="hide password-rule mt-2">
										<small>
											<ul class="list-unstyled">
												<li class=""><br><span class="eight-character"><i
														class="fa fa-check-circle" aria-hidden="true"></i></span>  최소
													8글자 입력하여야 합니다.</li>
												<li class=""><span class="low-upper-case"><i
														class="fa fa-check-circle" aria-hidden="true"></i></span>   최소
													한글자의 대문자와 소문자를 포함하여야 합니다.</li>
												<li class=""><span class="one-number"><i
														class="fa fa-check-circle" aria-hidden="true"></i></span>   숫자를
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
												class="fa fa-info-circle text-danger" aria-hidden="true"></i>Don't
												match password'
										</span></small>
									</div>

								</div>

								<!-- NickName -->
								<div class="form-group">
									<label class="sr-only">Nickname</label> <input type="text"
										id="reg_nickname" name="nickname" class="form-control"
										value="" placeholder="Nickname" required>
								</div>
								<!-- email group -->
								<div class="form-group">
									<label class="sr-only">E-mail Address</label> <input
										type="email" id="reg_useremail" name="mail"
										class="form-control" value="" placeholder="xxx@xxx.com">
								</div>

								<!-- question group -->
								<div class="form-group" style="text-align: left">
									성별 : &emsp; <input type="radio" name="gender" value="male">남
									&nbsp; <input type="radio" name="gender" value="female">여
								</div>

								<div class="form-group" style="text-align: left">
									생년월일 : <input id="age" name="age" type="date">
								</div>
								
								
   								<!-- recapcha -->
   								<div class="form-group">						
   									<div class="g-recaptcha" data-sitekey="6LcyXMcUAAAAAOA8wS0BEcF5PDkaN5bZjyfbmGJa"></div>
								</div>
								<br>							
								 
								<!-- Submit -->
								<div class="form-group">
									<input id="reg_submit" type="submit" value="Create user">
									<div id="sign-up-popover" class="hide">
										<p>is empty</p>
									</div>
								</div>
							</form>
						</div>


						<div class="login-or">
							<hr class="hr-or">
						</div>
						
						<!-- Links -->
						<div class="bottom text-center">
							이미 회원가입 하였습니다. <a href="login"><b>Login</b></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../default/footer.jsp" />
</body>
</html>
