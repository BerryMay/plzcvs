<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>마이페이지</title>
	<script type="text/javascript" src="resources/jquery-3.4.1.min.js"></script> <!-- 기본 jquery -->
	<script  type="text/javascript" src="js/jquery-confirm.js"></script><!-- confirm띄우기  -->

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"><!-- confirm창 css  -->
	<link
		href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
		rel="stylesheet" id="bootstrap-css"> 
		
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>	
	<script src="resources/js/moment.js"></script><!-- 시간띄우기 -->
	
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.min.css" />
	<link rel="stylesheet" href="css/board.css" type="text/css" />
	<link rel="stylesheet" href="css/mypage.css" type="text/css" />



</head>
<body>
	<c:if test="${userId == null }">
	   <script type="text/javascript">
	      location.href="login";
	   </script>
	</c:if>
	<%@ include file="../default/header_ajax.jsp" %> 
	
	
	
	<h2>마이 페이지</h2>
	<!-- 메뉴 -->
	<div class="mymenu_div">
		<ul class="myMenu">
			<li><button class="tablink active" onclick="openSection(event, 'mypage')">회원정보</button></li>
			<li><button class="tablink myboard" onclick="openSection(event, 'mypost')">내가 쓴 글</button></li>
			<li><button class="tablink myheart" onclick="openSection(event, 'heartpost')">좋아요한 글</button></li>
		</ul>
	</div>	
	
	<!-- 회원정보  -->
	<section id="mypage"  class="sec_content">
	<h3>회원정보</h3>
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
				<label>Point</label> 
				<input type="text" id="point" name="point" class="form-control"
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
					class="form-control" value="${dto.mail }" placeholder="xxx@xxx.com">
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
			</div>
		</form>
	</div>

		<!-- 쪽지 포인트 등급은 나중에 -->
	</section>
	
	
	<!-- 내가 쓴 글 -->
	<section id="mypost" class="sec_content">
	
		<div align="center">
			<form action="#" id="categoryForm">
			<label for ="category">게시판 선택</label>
				<select name="category" id="category" class ="selectboard" on
				change="myboard_list_before(this.value)">
					<option value="0" selected="selected">모두보기</option>
					<option value="1" >리뷰게시판</option>
					<option value="2">레시피게시판</option>
				</select>
			</form>
			<table class="table table-striped table-list table-hover" style="width: 100%;">
				<thead>
					<tr height="42px">
						<th style=" border-radius: 10px 0 0 0;"width="7.5%">번호</th>
						<th width="15%">게시판</th>
						<th width="20%">상품명</th>
						<th width="30%">제목</th>
						<th width="20%">작성일</th>
						<th style=" border-radius: 0 10px 0 0;"width="7.5%">조회</th>
					</tr>
				</thead>
				<tbody>
					<!-- 글 불러오는 곳 -->			
				</tbody>
			</table>
		
		 </div>

	</section>
	
	
	
	<!-- 좋아요 한 글 -->
	<section id="heartpost" class="sec_content">
	
		<div align="center">
			<table class="table table-striped table-hover table-heart" style="width: 100%;">
				<thead>
					<tr height="42px">
						<th style=" border-radius: 10px 0 0 0;" width="10%">번호</th>
						<th width="10%">상품명</th>
						<th width="40%">제목</th>
						<th width="10%">작성자</th>
						<th width="20%">작성일</th>
						<th style=" border-radius: 0 10px 0 0;"  width="10%">조회</th>
					</tr>
				</thead>
				<tbody>
					<!-- 글 불러오는 곳 -->			
				</tbody>
			</table>
		
		 </div>
	</section>
	
	<jsp:include page="../default/footer.jsp" />
	
	<script>
	$(document).ready(function() {

		//회원탈퇴
		$("#conf_btn").click(function(){
			var user = '<%=(String)session.getAttribute("userId")%>';
			$.confirm({
			    title: '회원탈퇴',
			    content: '작성했던 글이 모두 삭제됩니다.<br>정말로 탈퇴하시겠습니까?',
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
	
	function openSection(evt, secName) {
		  var i, tabcontent, tablink;
		  tabcontent = document.getElementsByClassName("sec_content");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablink = document.getElementsByClassName("tablink");
		  for (i = 0; i < tablink.length; i++) {
			  tablink[i].className = tablink[i].className.replace(" active", "");
		  }
		  document.getElementById(secName).style.display = "block";
		  evt.currentTarget.className += " active";
		}
	
	
	//내가 쓴 글
	//---------------------------------------------------------------
	
	var pagesu =10;  //페이지 번호 갯수
	  var currentPage = 0; //현재페이지
	  var numPerPage = 5;  //페이징시 표출되는 목록의갯수
	  var endPage;	//끝페이지
	  var comnum;	//전체댓글수
	  var wantpg=5;	//출력시 5페이지로 나누기 위한 변수

	 


     $(".myboard").click(function(){
    	 myboard_list();   	 
     });
	  
     $(".selectboard").click(function myboard_list_before (){
    	 myboard_list(k);   	 
     });
     
     //내가 쓴 글 목록부르기
     function myboard_list(k){
    	 console.log(k);
    	 currentPage = 0; 
    	 if(k!=null){ console.log("k is not null");}

    	
    	 var category =document.getElementById("category").value;
    	 
    	 var user= "<%=(String)session.getAttribute("userId")%>";
     	 var nick = {"nickname":user};
    	
        $.ajax({
           type:"POST",
           url:"myboard_list",
           data: nick,
          
           success:function(data){
        	   var html = "";
               var cCnt = data.length;
              
               comnum = data.length;
				
               
               if(data.length > 0){
                   for(i=0; i<data.length; i++){
                	   var c= Number(data[i].cat);
                	  
                	   
                	   if(category != 0){//0이면 모두, 1이면 리뷰, 2면 레시피
                		   
                	   		if(category != c) {comnum -= 1; continue;}
                	   		
                	   }
                	  
                	   var cat = (c==1)?"리뷰":"레시피";
                	   var savedate = moment(data[i].savedate).format('YYYY.MM.DD');
                	   
                       html += "<tr>";
                       html += "<td style='text-align: center'>"+data[i].num +"</td>";
                       html += "<td style='text-align: center'>"+cat +"</td>";
                       html += "<td style='text-align: center' title='"+data[i].productname +"'>"+data[i].productname +"</td>";
                       html += "<td><a href='detail?num="+data[i].num+"' class='aw100' title='"+data[i].title +"'>"+data[i].title;
                       
                       if(data[i].hit >= 20){
                    	   html += "<span class='hit'>best!</span>";
                       }

                       html += "</a></td>";
                       
                       html += "<td style='text-align: center'>"+savedate+"</td>";
                       html += "<td style='text-align: center'>"+data[i].hit+"</td>";

                       
                       html += "</tr>";
                   }
                   
               } 
               
               $(".table-list tbody").html(html);
                           
               endPage = Math.ceil(comnum/wantpg); 
               
               list_page(k);

           },
           error:function(data){console.log("에러");},
        });
     
     };
  // 내가 쓴 글 페이지 처리
  	function list_page(j){ 
	  var k = j;
	  this.k=k;
	 
	  
  		 $('.table-list tbody').each(function() {
  			
  			//length로 원래 리스트의 전체길이구함
	  		  var numRows = comnum;
	  		  //Math.ceil를 이용하여 반올림
	  		  var numPages = endPage;
	  		  //리스트가 없으면 종료
	  		  if (numPages==0) return;

	  		var nowp = currentPage;
	  		  var endp = endPage;
	  		  
  		  var $table = $(this);     		 
  		  var $pager = $('<div class="pager" align="center" id="remo"></div>');
  		var ck = 0;
  		
  		if(k!=null){ck=1; currentPage=1; nowp = currentPage;}
  		else{ck = Number($('#mypost').find(".actived").text());}
  		  
  		  $table.on('repaginate', function() {
  			//기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다
	  		   $table.find('tr').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();
	  		   $("#remo").html("");
	  		   
	  		   if (numPages > 1) {     // 한페이지 이상이면
	  				    if (currentPage < 5 && (numPages-currentPage) >= 5) {   // 현재 5p 이하이면
	  				     nowp = 0;     // 1부터 
	  				     endp = pagesu;    // 10까지
	  				    }else{
	  				     nowp = currentPage -5;  // 6넘어가면 2부터 찍고
	  				     endp = nowp+pagesu;   // 10까지
	  				     pi = 1;
	  			    }
	  			    
	  			    if (numPages < endp) {   // 10페이지가 안되면
	  				     endp = numPages;   // 마지막페이지를 갯수 만큼
	  				     nowp = numPages-pagesu;  // 시작페이지를   갯수 -10
	  			    }
	  			    
	  			    if (nowp < 1) {     // 시작이 음수 or 0 이면
	  			     	nowp = 0;     // 1페이지부터 시작
	  			    }
	  		   }else{       // 한페이지 이하이면
	  			    nowp = 0;      // 한번만 페이징 생성
	  			    endp = numPages;
	  		   }
	  		   
	  		   // [처음]
	  		   $('<span class="page-number" cursor: "pointer"><i class="fas fa-angle-double-left"></i></span>').bind('click', {newPage: page},function(event) {
	  		          currentPage = 0;   
	  		          $table.trigger('repaginate');  
	  		          $($(".page-number")[2]).addClass('actived').siblings().removeClass('actived');
	  		      }).appendTo($pager).addClass('clickable');
	  		    // [이전]
	  		      $('<span class="page-number" cursor: "pointer"><i class="fas fa-angle-left"></i></span>').bind('click', {newPage: page},function(event) {
	  		          if(currentPage == 0) return; 
	  		          currentPage = currentPage-1;
	  		    $table.trigger('repaginate'); 
	  		    $($(".page-number")[(currentPage-nowp)+2]).addClass('actived').siblings().removeClass('actived');
	  		   }).appendTo($pager).addClass('clickable');
	  		    // [1,2,3,4,5,6,7,8]
	  		   for (var page = nowp ; page < endp; page++) { 
	  		    $('<span class="page-number" cursor: "pointer" style="margin-left: 8px;"></span>').text(page + 1).on('click', {newPage: page}, function(event) {
	  		     currentPage = event.data['newPage'];
	  		     $table.trigger('repaginate');
	  		     $($(".page-number")[(currentPage-nowp)+2]).addClass('actived').siblings().removeClass('actived');
	  		     }).appendTo($pager).addClass('clickable');
	  		   } 
	  		    // [다음]
	  		      $('<span class="page-number" cursor: "pointer"><i class="fas fa-angle-right"></i></span>').bind('click', {newPage: page},function(event) {
	  		    if(currentPage == numPages-1) return;
	  		        currentPage = currentPage+1;
	  		    $table.trigger('repaginate'); 
	  		     $($(".page-number")[(currentPage-nowp)+2]).addClass('actived').siblings().removeClass('actived');
	  		   }).appendTo($pager).addClass('clickable');
	  		    // [끝]
	  		   $('<span class="page-number" cursor: "pointer"><i class="fas fa-angle-double-right"></i></span>').on('click', {newPage: page},function(event) {
	  		           currentPage = numPages-1;
	  		           $table.trigger('repaginate');
	  		           $($(".page-number")[endp-nowp+1]).addClass('actived').siblings().removeClass('actived');
	  		   }).appendTo($pager).addClass('clickable');
	  		     
	  		 //console.log(k);
	  		   if(k!=null){
	  			   ck=1;
	  		 		$($(".page-number")[2]).addClass('actived');
	  		 		
	  		   }
	  		   console.log(ck);
	  		    if(ck<="1" || ck== 'Nan'){	
	   				 //0, 1페이지라면    				
	   				$($(".page-number")[2]).addClass('actived');
	   				 
	   			 }else{
	   				 //1페이지가 아니라면		
	   				$($(".page-number")[2]).removeClass('actived');
		 				if(ck>numPages){
	   			 	$($(".page-number")[endp-nowp+1]).addClass('actived');
		 				}else{
		 				$($(".page-number")[ck+1]).addClass('actived');
						
		 				}
	  			}
  		  });

				if($('.table-list').next().hasClass('pager')){ 	$("#remo").remove();	}
	   			 	 
				$pager.insertAfter($('.table-list'));
	   			$table.trigger('repaginate');

  		 });

  	}//페이지 처리 끝
  
  
  //좋아요 한 글
		//---------------------------------------------------------------
		 $(".myheart").click(function(){
			myheart_list();   	 
	     });
	     
	     //좋아요한 글 목록
	     function myheart_list(){
	    	 var user= "<%=(String)session.getAttribute("userId")%>";
	     	 var nick = {"nickname":user};
	    	
	        $.ajax({
	           type:"POST",
	           url:"myheart_list",
	           data: nick,
	          
	           success:function(data){
	        	   var html = "";
	               var cCnt = data.length;
	              
	               comnum = data.length;
					endPage = Math.ceil(comnum/wantpg); 
	               
	               if(data.length > 0){
	                   for(i=0; i<data.length; i++){
	                	   
			                   var savedate = moment(data[i].savedate).format('YYYY.MM.DD');
	                       html += "<tr>";
	                       html += "<td style='text-align: center'>"+data[i].num +"</td>";
	                       html += "<td style='text-align: center' title='"+data[i].productname +"'>"+data[i].productname +"</td>";
	                       html += "<td><a href='detail?num="+data[i].num+"' class='aw100' title='"+data[i].title +"'>"+data[i].title;
	                       
	                       if(data[i].hit >= 20){
	                    	   html += "<span class='hit'>best!</span>";
	                       }

	                       html += "</a></td>";
	                       
	                       html += "<td style='text-align: center'>"+data[i].nickname+"</td>";
	                       html += "<td style='text-align: center'>"+savedate+"</td>";
	                       html += "<td style='text-align: center'>"+data[i].hit+"</td>";

	                       
	                       html += "</tr>";
	                   }
	                   
	               } 
	               
	               $(".table-heart tbody").html(html);
	               heart_page(1);

	           },
	           error:function(data){console.log("에러");},
	        });
	     
	     };
		  // 좋아요 페이지 처리
		  	function heart_page(n){ 
				
		  		 $('.table-heart tbody').each(function() {
		  			 var currentPage =0;
		  			//length로 원래 리스트의 전체길이구함
			  		  var numRows = comnum;
			  		  //Math.ceil를 이용하여 반올림
			  		  var numPages = endPage;
			  		  //리스트가 없으면 종료
			  		  if (numPages==0) return;

			  		var nowp = currentPage;
			  		  var endp = endPage;
			  		  
		  		  var $table = $(this);    	  		  
		  		  var $pager = $('<div class="pager" align="center" id="remo"></div>');
		  		
		  		 ck = 0;
		  		console.log(ck);
		  		  //페이지를 클릭하면 다시 셋팅
		  		  $table.on('repaginate', function() {
		  			//기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다
			  		   $table.find('tr').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();
			  		   $(".pager").empty();
			  		   //$("#heartpost").find(".pager")
			  		   
			  		   if (numPages > 1) {     // 한페이지 이상이면
			  				    if (currentPage < 5 && (numPages-currentPage) >= 5) {   // 현재 5p 이하이면
			  				     nowp = 0;     // 1부터 
			  				     endp = pagesu;    // 10까지
			  				    }else{
			  				     nowp = currentPage -5;  // 6넘어가면 2부터 찍고
			  				     endp = nowp+pagesu;   // 10까지
			  				     pi = 1;
			  			    }
			  			    
			  			    if (numPages < endp) {   // 10페이지가 안되면
			  				     endp = numPages;   // 마지막페이지를 갯수 만큼
			  				     nowp = numPages-pagesu;  // 시작페이지를   갯수 -10
			  			    }
			  			    
			  			    if (nowp < 1) {     // 시작이 음수 or 0 이면
			  			     	nowp = 0;     // 1페이지부터 시작
			  			    }
			  		   }else{       // 한페이지 이하이면
			  			    nowp = 0;      // 한번만 페이징 생성
			  			    endp = numPages;
			  		   }
			  		   // [처음]
			  		   $('<span class="page-number" cursor: "pointer"><i class="fas fa-angle-double-left"></i></span>').bind('click', {newPage: page},function(event) {
			  		          currentPage = 0;   
			  		          $table.trigger('repaginate');  
			  		          $($(".page-number")[2]).addClass('actived').siblings().removeClass('actived');
			  		      }).appendTo($pager).addClass('clickable');
			  		    // [이전]
			  		      $('<span class="page-number" cursor: "pointer"><i class="fas fa-angle-left"></i></span>').bind('click', {newPage: page},function(event) {
			  		          if(currentPage == 0) return; 
			  		          currentPage = currentPage-1;
			  		    $table.trigger('repaginate'); 
			  		    $($(".page-number")[(currentPage-nowp)+2]).addClass('actived').siblings().removeClass('actived');
			  		   }).appendTo($pager).addClass('clickable');
			  		    // [1,2,3,4,5,6,7,8]
			  		   for (var page = nowp ; page < endp; page++) { 
			  		    $('<span class="page-number" cursor: "pointer" style="margin-left: 8px;"></span>').text(page + 1).bind('click', {newPage: page}, function(event) {
			  		     currentPage = event.data['newPage'];
			  		     $table.trigger('repaginate');
			  		     $($(".page-number")[(currentPage-nowp)+2]).addClass('actived').siblings().removeClass('actived');
			  		     }).appendTo($pager).addClass('clickable');
			  		   } 
			  		    // [다음]
			  		      $('<span class="page-number" cursor: "pointer"><i class="fas fa-angle-right"></i></span>').bind('click', {newPage: page},function(event) {
			  		    if(currentPage == numPages-1) return;
			  		        currentPage = currentPage+1;
			  		    $table.trigger('repaginate'); 
			  		     $($(".page-number")[(currentPage-nowp)+2]).addClass('actived').siblings().removeClass('actived');
			  		   }).appendTo($pager).addClass('clickable');
			  		    // [끝]
			  		   $('<span class="page-number" cursor: "pointer"><i class="fas fa-angle-double-right"></i></span>').bind('click', {newPage: page},function(event) {
			  		           currentPage = numPages-1;
			  		           $table.trigger('repaginate');
			  		           $($(".page-number")[endp-nowp+1]).addClass('actived').siblings().removeClass('actived');
			  		   }).appendTo($pager).addClass('clickable');
			  		
			  		    console.log(ck);
			  		    if(ck<="1" || ck== 'Nan'){	
			   				 //0, 1페이지라면    				
			   				$($(".page-number")[2]).addClass('actived');
			   			 }else{
			   				 //1페이지가 아니라면		
			   				$($(".page-number")[2]).removeClass('actived');
				 				if(ck>numPages){
			   			 			$($(".page-number")[endp-nowp+1]).addClass('actived');
				 				}else{
				 					$($(".page-number")[ck+1]).addClass('actived');								
				 				}
			  			}
		  		  });

						if($('.table-heart').next().hasClass('pager')){ 	$(".pager").remove();	}
							 
						$pager.insertAfter($('.table-heart'));
			   			$table.trigger('repaginate');
			   			
		  		 });
		  }


	</script>
</body>
</html>