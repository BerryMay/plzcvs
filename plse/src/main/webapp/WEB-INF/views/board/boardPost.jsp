<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<script  type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/bootstrap-rating.js"></script> <!-- 별점js -->
	<link rel="stylesheet" href="css/boardpost.css" type="text/css" />
    <!-- Font Awesome CSS -->
 	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.min.css" />
	<meta charset="UTF-8">
	<title>Insert title here</title>	
</head>
<body>
<c:if test="${userId == null }">
	<script type="text/javascript">
		alert("로그인한 사람만 글쓰기가 가능합니다")
		location.href="login";
	</script>
</c:if>
<jsp:include page="../default/header.jsp" /><!-- header파일 불러오기 -->

	    <div class="container">
    		<h2>게시글 등록하기</h2>
    		
<<<<<<< HEAD
<<<<<<< HEAD
=======
    		<form class="postform" action="board_reg" method="POST">
    		<input type="hidden" name="nickname" value="${userId }">
=======


>>>>>>> branch 'master' of https://github.com/BerryMay/plzcvs.git
    		

    		<form class="postform" action="board_reg" method="POST">
    		<input type="hidden" name="nickname" value="${userId }">

				<div class="form-group"><!-- 편의점, 상품명 div -->
				<div class="cvsnum_div">
					<label for="cvsnum">편의점</label> 
					<select name="cvsnum" class="form-cvsnum form-control">
						<option value="1">GS25</option>
						<option value="2">세븐일레븐</option>
						<option value="3">CU</option>
					</select> 
					</div>
					<div class="productname_div">
					<label for="productname">상품명</label> 
					<input type="text" class="form-productname form-control " name="productname" />
					</div>
				</div><!-- 편의점, 상품명 div -->

    		    <div class="form-group star_div"><!-- 별점 div  -->
    		        <label for="star">별점</label>
    		        <!-- 별점시작  -->
    		       
    		         <input type="hidden" class="rating" name="stars" data-fractions="2"/>
				   
				     <script>
					      $(function () {
						        $('input.check').on('change', function () { alert('Rating: ' + $(this).val());	});
						        $('#programmatically-set').click(function () {
						          $('#programmatically-rating').rating('rate', $('#programmatically-value').val());
						        });
						        $('#programmatically-get').click(function () {	alert($('#programmatically-rating').rating('rate'));	 });
						        $('#programmatically-reset').click(function () { $('#programmatically-rating').rating('rate', '');	});
					        
					        
						        $('.rating-tooltip').rating({
						          extendSymbol: function (rate) {
						            $(this).tooltip({
						              container: 'body',
						              placement: 'bottom',
						              title: 'Rate ' + rate
						            });
						          }
						        });
					        
					        
						        $('.rating-tooltip-manual').rating({
						          extendSymbol: function () {
							            var title;
							            
							            $(this).tooltip({
								              container: 'body',
								              placement: 'bottom',
								              trigger: 'manual',
								              title: function () {  return title; }
							            });
			
							            $(this).on('rating.rateenter', function (e, rate) {
								              title = rate;
								              $(this).tooltip('show');
							            }).on('rating.rateleave', function () { $(this).tooltip('hide'); });
						          }
						        });
						        
					        
						        $('.rating').each(function () {
						          $('<span class="label label-default"></span>').text($(this).val() || ' ').insertAfter(this); });
						        $('.rating').on('change', function () { 
						        	$(this).next('.label').text($(this).val()); 
						        	$('.rating').value($(this).val());					        	
						        });
					      });
				    </script>
				    <!-- 별점 끝 -->	        
    		    </div><!-- 별점 div-->
    		    
    		    <div class="form-group"><!-- 제목란 -->
	   		        <label for="title">제목</label>
	   		        <input type="text" class="form-control" name="title" />
   		   	 	</div>
   		   	 	
    		    <div class="form-group"> <!-- 내용 -->
    		        <label for="content">내용</label>
    		        <textarea rows="15" class="form-control" name="content" ></textarea>
    		    </div>

    		    <div class=" filebox"><!-- 파일첨부 -->
    		       <label for="pic" class="uploadlabel">파일첨부</label>   		       
    		       <input class="upload-name" value="파일선택" disabled="disabled">    
    		       <label for="ex_filename" class="upload">업로드</label> 
    		       <input type="file" id="ex_filename" class="upload-hidden">
    		       
				<!-- 파일 선택하면 파일명 보여지기 -->
				<script>
					$(document).ready(function(){ 
						var fileTarget = $('.filebox .upload-hidden'); 
						fileTarget.on('change', function(){ // 값이 변경되면
							if(window.FileReader){ // modern browser 
								var filename = $(this)[0].files[0].name; 
							} else { // old IE 
								var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
							} 			
							$(this).siblings('.upload-name').val(filename); // 추출한 파일명 삽입 
						}); 
					});
				</script>
    		    </div><!-- 파일첨부 div -->

				<div class="btns">
					<button type="submit" class="btn btn-primary">등록</button>
					<button class="btn btn-default">취소</button>
				</div>
				</form>
		</div><!-- container end -->
		
<jsp:include page="../default/footer.jsp" />
</body>
</html>