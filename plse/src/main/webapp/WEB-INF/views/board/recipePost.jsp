<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
   <script type="text/javascript">
      function bChk(){
         if(document.postform.stars.value==""){
            alert("별점을을 입력해주세요")
        
         }else if(document.postform.title.value==""){
            alert("제목을 입력해주세요")
         }else if(document.postform.content.value==""){
            alert("내용을 입력해주세요")
         }else{
            document.postform.submit();
         }
      }
   </script>
   
   <script  type="text/javascript" src="js/jquery.js"></script><!-- 별점관련 jquery -->
   <script type="text/javascript" src="resources/jquery-3.4.1.min.js"></script> <!-- 기본 jquery -->
   <script  type="text/javascript" src="js/jquery-ui.js"></script><!-- 자동완성관련 -->
   <script type="text/javascript" src="js/bootstrap-rating.js"></script> <!-- 별점js -->
   <link rel="stylesheet" href="css/boardpost.css" type="text/css" /> <!-- 페이지 기본 css -->
   <link rel="stylesheet" href="css/jquery-ui.css" type="text/css" /><!-- 자동완성관련 css -->
   
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
   });
      </script>
   <meta charset="UTF-8">
   <title>레시피 게시판 등록</title>   
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
   <div class="row">
       <div class="col-md-8 col-md-offset-2">
          <h2>레시피 등록하기</h2>
          <form name="postform" id="postform" class="postform" action="recipeBoard_reg" method="POST" enctype="multipart/form-data">
          <input type="hidden" name="nickname" value="${userId }">
          <input type="hidden" name="cat" value='2'>
          
            <div class="form-group"><!-- 편의점, 상품명 div -->
                  
              
            </div><!-- 편의점, 상품명 div -->

              <div class="form-group"><!-- 별점 div  -->
                  <label for="star">별점</label>
                  <input type="hidden" name="stars" class="rating" data-fractions="2"/> 
              </div><!-- 별점 div-->
              
              <div class="form-group"><!-- 제목란 -->
                    <label for="title">제목</label>
                    <input type="text" class="form-control" id="title" name="title" />
                   </div>
                   <!-- 사진 보여주는 div -->
              <div class="select_img"><img src="" /></div>
              <div class="form-group"> <!-- 내용 -->
                  <label for="content">내용</label>
                  <textarea rows="5" class="form-control" id="content" name="content" ></textarea>
              </div>

              <div class=" filebox"><!-- 파일첨부 -->
                 <label for="pic" class="uploadlabel">파일첨부</label>                
                 <input class="upload-name" value="파일선택" disabled="disabled">    
                 <label for="ex_filename" class="upload">업로드</label> 
                 <input multiple="multiple" type="file" name="file" id="ex_filename" class="upload-hidden">
                 
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
              </div><!-- 파일첨부 div -->
               <%=request.getRealPath("/") %>
               <!-- 
                     무슨 경로가 떠서 놀라셨죠..?
                     절대경로 확인 후에 servlet에서 업로드 패스 설정 (34번줄) value값 변경  맨 뒤에 \resources 추가할것. "질문은 시훈씨에게..." 
                     resources(css,js,img폴더있는곳)에 imgUpload 폴더 생성해두기
                     
                     후에 업로드 되는 이미지들이 서버에 저장되면 이럴 필요가 없다고 합니다.
                -->
            <div class=" btns">
               <button type="button" class="btn btn-primary" onclick="javascript:bChk()">등록</button>
               <button class="btn btn-default" type="reset" onclick="javascript:history.back()">취소</button>
            </div>
            </form>
      </div><!-- col-md-8 col-md-offset-2 end -->
      
   </div><!-- row end -->
</div> <!-- container end -->
<jsp:include page="../default/footer.jsp" />
</body>
</html>