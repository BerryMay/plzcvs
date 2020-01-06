<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript">
		function bChk(){
			if(document.postform.stars.value==""){
				alert("별점을 매겨주세요")
			}else if(document.postform.title.value==""){
				alert("제목을 입력해주세요")
			}else if(document.postform.content.value==""){
				alert("내용을 입력해주세요")
			}else{
				document.postform.submit();
			}
		}
	</script>	
	<script  type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/bootstrap-rating.js"></script> <!-- 별점js -->
	<link rel="stylesheet" href="css/boardpost.css" type="text/css" />
    <!-- Font Awesome CSS -->
 	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.min.css" />

	<script type="text/javascript">
		//별점 script
        $(function () {
          $('input.check').on('change', function () { alert('Rating: ' + $(this).val());   });
          $('#programmatically-set').click(function () {
            $('#programmatically-rating').rating('rate', $('#programmatically-value').val());
          });
          $('#programmatically-get').click(function () {   alert($('#programmatically-rating').rating('rate'));    });
          $('#programmatically-reset').click(function () { $('#programmatically-rating').rating('rate', '');   });
          
          
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
          $('.rating').on('change', function () { $(this).next('.label').text($(this).val()); });
        });//별점끝
      </script>
<meta charset="UTF-8">
	<title>레시피 게시글 수정</title>
</head>
<body>
<jsp:include page="../default/header.jsp" /><!-- header파일 불러오기 -->

	    <div class="container">
    		<h2>레시피 게시글 수정하기</h2>
    		
    		<form id="postform" name="postform" class="postform" action="recipeBoard_modifyOk" method="POST" enctype="multipart/form-data">
    			<input type="hidden" name="num" value="${dto.num }"/>
    			

    		    <div class="form-group star_div"><!-- 별점 div  -->
    		        <label for="star">추천도</label>
    		         <input type="hidden" id="stars" name="stars" class="rating" data-fractions="2" value="${dto.stars }"/>
    		    </div><!-- 별점 div-->
    		    
    		    <div class="form-group"><!-- 제목란 -->
	   		        <label for="title">제목</label>
	   		        <input type="text" class="form-control" id="title" name="title" value="${dto.title }"/>
   		   	 	</div>
   		   	 	<div class="form-group-img"><!-- 사진 보여주는 div -->
              		<label for="content">사진</label>
              		<div class="select_img">
	              		<c:forEach var="lmglist" items="${imgList }">
	    	          		<img src="${lmglist.gdsimg }" class="ProductImg">
    	          		</c:forEach>
              		</div>
              	</div>
    		    <div class="form-group"> <!-- 내용 -->
    		        <label for="content">내용</label>
    		        <textarea rows="15" class="form-control" id="content" name="content" >${dto.content }</textarea>
    		    </div>

    		    <div class=" filebox"><!-- 파일첨부 -->
    		       <label for="pic" class="uploadlabel">파일첨부</label>   		       
    		       <input class="upload-name" value="파일선택" disabled="disabled">    
    		       <label for="ex_filename" class="upload">업로드</label> 
    		       <input type="file" name="file" id="ex_filename" class="upload-hidden" multiple="multiple">
    		       <input type="hidden" name="gdsimg" value="${dto.gdsimg }">
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
				<!-- 파일 선택하면 파일명 보여지기 -->
				<!--
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
                     if(this.files && this.files[0]) { // 사진 보여주는 스크립트
                    	    var reader = new FileReader;
                    	    reader.onload = function(data) {
                    	     $(".select_img img").attr("src", data.target.result);        
                    	    }
                    	    reader.readAsDataURL(this.files[0]);
                    	   }
                  }); 
               });
            </script>
             -->
              </div><!-- 파일첨부 div -->

				<div class="btns">
					<button type="button" class="btn btn-primary" onclick="javascript:bChk()">수정</button>
					<button type="button" class="btn btn-default" onclick="javascript:history.back()">취소</button>
				</div>
				</form>
		</div><!-- container end -->
		
<jsp:include page="../default/footer.jsp" />
</body>
</html>