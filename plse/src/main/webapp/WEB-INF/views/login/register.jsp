<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<link
		href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
		rel="stylesheet" id="bootstrap-css">
	<script
		src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script
		src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<!------ Include the above in your HEAD tag ---------->

	<link rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
		crossorigin="anonymous">
	<link rel="stylesheet" href="css/register.css" type="text/css" />
</head>

<body>
	<jsp:include page="../default/header.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-5">
				<div class="card cardbox">
					<div class="card-header" style="text-align: center">회원가입</div>
					<div class="card-body">
						<div class="form-group">
							<form id="login-nav" method="post" role="form" class="form" accept-charset="UTF-8">
								<div class="form-group">
									<label class="sr-only">Id</label> 
									<input type="text" id="reg_username" name="user_id" class="form-control" value="" placeholder="Id" required>
								</div>

								<!-- password group -->
								<div class="form-group">

									<!-- password label -->
									<label class="sr-only">Password</label>
									<!-- password input -->
									<div class="input-group">
										<input type="password" id="reg_userpassword"
											name="user_password" class="form-control"
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

										<span id="reg-password-quality"
											class="hide pull-left block-help"> <small>Password
												<span id="reg-password-quality-result"></span>
										</small>
										</span>
									</div>
									<!-- Password Rules -->
									<div id="reg_passwordrules" class="hide password-rule mt-2">
										<small>

											<ul class="list-unstyled">
												<li class=""><span class="eight-character"><i
														class="fa fa-check-circle" aria-hidden="true"></i></span>   min 8
													character</li>
												<li class=""><span class="low-upper-case"><i
														class="fa fa-check-circle" aria-hidden="true"></i></span>   min 1
													uppercase & 1 lowercase character</li>
												<li class=""><span class="one-number"><i
														class="fa fa-check-circle" aria-hidden="true"></i></span>   min 1
													number</li>
												<li class=""><span class="one-special-char"><i
														class="fa fa-check-circle" aria-hidden="true"></i></span>   min 1
													special char (!@#$%^&*)</li>
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
										id="reg_nickname" name="user_nickname" class="form-control"
										value="" placeholder="Nickname" required>
								</div>
								<!-- email group -->
								<div class="form-group">
									<label class="sr-only">E-mail Address</label> <input
										type="email" id="reg_useremail" name="user_email"
										class="form-control" value="" placeholder="xxx@xxx.com">
								</div>

								<!-- question group -->
								<div class="form-group" style="text-align: left">
									성별 : &emsp; <input type="radio" name="sex" value="male">남
									&nbsp; <input type="radio" name="sex" value="female">여
								</div>

								<div class="form-group" style="text-align: left">
									연령대 : &emsp; <input type="radio" name="age" value="10">10대
									<input type="radio" name="age" value="20">20대 <input
										type="radio" name="age" value="30">30대 <input
										type="radio" name="age" value="40">40대 <input
										type="radio" name="age" value="50">50대이상
								</div>

								<!-- Submit -->
								<div class="form-group">
									<button id="reg_submit" name="submit" value="1"
										class="btn btn-block btn-primary" disabled="disabled">Create
										user</button>
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
							이미 회원가입 하였습니다. <a href="#"><b>Login</b></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../default/footer.jsp" />
</body>
</html>
