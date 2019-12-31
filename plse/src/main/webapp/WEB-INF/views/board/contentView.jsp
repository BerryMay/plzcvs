<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <!-- js파일-->
    <script type="text/javascript" src="resources/jquery-3.4.1.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
   <script type="text/javascript" src="js/bootstrap-rating.js"></script>
   <link rel="stylesheet" href="css/contentView.css" type="text/css" />
   <link rel="stylesheet" href="css/contentView2.css" type="text/css" />

    <!--댓글-->
    <script src="resources/js/moment.js"></script>
   

   <!-- js파일-->
    
    <script>
    
    $(document).ready(function($) {

    var pagesu =10;  //페이지 번호 갯수
     var currentPage = 0; //현재페이지
     var numPerPage = 3;  //페이징시 표출되는 목록의갯수
     var endPage;   //끝페이지
     var comnum;   //전체댓글수
     var wantpg=3;   //출력시 3페이지로 나누기 위한 변수
     cvsnum();
     heartCnt();
     heartChk();
     
  
    var num=0;


	  cvsnum();//편의점 분류하기
	  heartCnt(); //좋아요 카운트
	  heartChk();	//좋아요 했는지 체크
    });
    function replaceAll(str, searchStr, replaceStr) {
    	  return str.split(searchStr).join(replaceStr);
    }
    //좋아요 버튼 클릭시
    $(function() {
       $('#likebtn').click(function(){
          if(${userId != null}){
            if($("button").hasClass('btn_unlike')){
              $("button").removeClass('btn_unlike');
              $('.ani_heart_m').removeClass('hi');
              $('.ani_heart_m').addClass('bye');
              $.ajax({
                 url:"board_unheart",
                 type:"POST",
                 data:$("#board_heart").serialize(),
                 success:function(data){
                    heartCnt();
                 },
                 error:function(){
                    alert("좋아요  오류발생")
                 }
              });
            }
            else{
              $("button").addClass('btn_unlike');
              $('.ani_heart_m').addClass('hi');
              $('.ani_heart_m').removeClass('bye');
              $.ajax({
                 url:"board_heart",
                 type:"POST",
                 data:$("#board_heart").serialize(),
                 success:function(data){
                    heartCnt();
                 },
                 error:function(){
                    alert("좋아요 취소 오류발생")
                 }
              });
            }
          }else{
             alert("로그인 해주세요")
             location.href="login";
          }
          });
       })

    //좋아요 눌렀는지 체크
    function heartChk(){
       $.ajax({
          url:"board_heartChk",
          type:"POST",
          data:$("#board_heart").serialize(),
         success:function(data){
            $("button").addClass('btn_unlike');
              $('.ani_heart_m').addClass('hi');
              $('.ani_heart_m').removeClass('bye');
         },
         error:function(){
            
         }
       });
    }
    
    //좋아요 갯수 가져옴
    function heartCnt() {
      $.ajax({
         url:"board_heartCnt",
         type:"POST",
         data:$("#board_heart").serialize(),
         success:function(data){
            $("#result").text(data);
         },
         error:function(){
            alert("좋아요 total 오류발생")
         }
      });
   }
       
    //편의점분류
    function cvsnum(){
       var cvs ="";
        
        switch(${ dto.cvsnum }){
           case 1: cvs="GS25"; break;
           case 2: cvs="세븐일레븐"; break;
           case 3: cvs="CU"; break;
        }
        document.getElementById("cvs").innerText+=cvs
     
    }

    
    /* 댓글수정 클릭시  폼으로 바꾸기*/
    function modComment(btn, cnum){ 
  	  
  	 	var content_comment=$(btn).parent().parent().next().html();
  	 	var con =  replaceAll(content_comment,"<br>","\r\n");
  	 	//var con = content_comment.replace("<br>","\r\n");
  		var user = "<%=(String)session.getAttribute("userId")%>";
    	var htmls = "";
    	 
    	htmls += "<form id='modcommentform'><div class='input-group  modbox'>";
    	htmls += "<textarea class='form-control' id='con' name='content' row='3'>"+con+"</textarea>";
    	htmls += "<input type='button' class='btn sub' id='btn_comment_modify' value='완료' />";
    	htmls += "<input type='hidden' name='cnum' value='"+ cnum +"'>";
    	htmls += "<input type='hidden' name='nickname' value='"+ user +"'>";
    	htmls += "</div'></form>";

    	 
    	$(btn).parent().parent().next().html(htmls);
    	
    	
	      //댓글 수정완료 버튼 클릭 이벤트(ajax로처리)
	      $('#btn_comment_modify').click(function(){
	        console.log("완료버튼을 누름");
	         
	        $.ajax({
	            type:"POST",
	            url:"comment_modify",
	            data:$("#modcommentform").serialize(),
	           
	            success:function(data){
	         	   console.log("댓글 수정하기");
					console.log(data.content);
					
					var mod_comment=data.content.replace("\r\n","<br>");
					
					
	         	  $(btn).parent().parent().next().html(mod_comment);
	         	   
	            },error:function(data){console.log("에러");},
	         })
	         
	      });
     }
     
     
    /* 댓글삭제 클릭시*/
    function delComment(btn, cnum){ 
		var dnum = {"cnum":cnum};
    	
    	$.ajax({
	            type:"POST",
	            url:"comment_delete",
	            data: dnum,
	            dataType: 'text',
	           
	            success:function(data){
	         	   console.log("댓글 삭제하기");
	         	  	listReply();
	         	  
	         	   
	            },error:function(data){console.log("에러");},
	         })
    	
     }

    //댓글 페이징 관련
    var pagesu =10;  //페이지 번호 갯수
	  var currentPage = 0; //현재페이지
	  var numPerPage = 3;  //페이징시 표출되는 목록의갯수
	  var endPage;	//끝페이지
	  var comnum;	//전체댓글수
	  var wantpg=3;	//출력시 3페이지로 나누기 위한 변수
    
	  var num=0;
       //댓글
       $(document).ready(function(){
         listReply(); //댓글 목록불러오기

         //댓글 쓰기 버튼 클릭 이벤트(ajax로처리)
         $('#btn_comment').click(function(){
           
            $.ajax({
               type:"POST",
               url:"reply_insert" ,
               data:$(".contentsbox").serialize(),
               success:function(data){
                  console.log("등록하기");
                   listReply(); 
                  $("#con").val("");
               },
               error:function(){
                  alert("세션이 만료되었거나, 댓글을 입력해주세요")
                } 
            })//ajax끝
            
         });
         


      });
       

       //댓글 목록
       function listReply(){
          var user =  "<%=(String)session.getAttribute("userId")%>";
         
          $.ajax({
             type:"POST",
             url:"comment_list",
             data:$(".contentsbox").serialize(),
            
             success:function(data){
                var html = "";
                 var cCnt = data.length;
                
                 comnum = data.length;
            endPage = Math.ceil(comnum/wantpg); 
                 
                 if(data.length > 0){
                     for(i=0; i<data.length; i++){

		                   var savedate = moment(data[i].savedate).format('YYYY년 MM월 DD일 HH:mm:ss');
		                   var content = data[i].content.replace("\r\n", "<br>");
		                   //var content = replaceAll(data[i].content,"\r\n","<br>");

                         html += "<li class='comment'>";
                         html += "<div class='comment-body'><div class='comment-heading'>";
                         html += "<h4 class='user'>"+data[i].nickname+" </h4>"
                         
                         if(user==data[i].nickname){
                              html += "<p class='com_btns'>";
                              html += "<button type='button' class='com_btn modcom_btn' onClick='modComment(this, "+data[i].cnum+");'>수정</button> |&nbsp;";
                              html += "<button type='button' class='com_btn' onClick='delComment(this, "+data[i].cnum+");'>삭제</button>";
                              html += "</p>";
                         }
                         html += "<h5 class='time'>"+savedate+"</h5>";
                         html += "</div>";
                         html += "<pre class='com_con' id='"+num++ +"'>"+content+"</pre>";
                         html += "</div>";
                         html += "</li>";
                     }
                     
                 } else {
                     
                     html += "<div>";
                     html += "<div><table class='table'><h6><strong>등록된 댓글이 없습니다.</strong></h6>";
                     html += "</table></div>";
                     html += "</div>";
                     
                 }
                 
                 $("#cCnt").html(cCnt);
                 $(".comments-list").html(html);
                 page();

             },
             error:function(data){console.log("에러");},
          });
       
       };
       
       
      // 댓글 페이지 처리
        function page(){ 

            var reSortColors = function($ul) {
             $('li:odd', $ul).removeClass('even').removeClass('listtd').addClass('odd');
             $('li:even', $ul).removeClass('odd').removeClass('listtd').addClass('even');
            }; 
            
            
            
            $('ul.paginated').each(function() {
            
             var $ul = $(this);    
             
             
             //length로 원래 리스트의 전체길이구함
             var numRows = comnum;
             //Math.ceil를 이용하여 반올림
             var numPages = endPage;
             //리스트가 없으면 종료
             if (numPages==0) return;
             //pager라는 클래스의 div엘리먼트 작성
             var $pager = $('<div class="pager" align="center" id="remo"></div>');
             
             var nowp = currentPage;
             var endp = endPage;
           
             //페이지를 클릭하면 다시 셋팅
             $ul.bind('repaginate', function() {
                
             //기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다
              $ul.find('li').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();
              $("#remo").html("");
              
              if (numPages > 1) {     // 한페이지 이상이면
                     if (currentPage < 5 && numPages-currentPage >= 5) {   // 현재 5p 이하이면
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
              $('<span class="page-number" cursor: "pointer">[처음]</span>').bind('click', {newPage: page},function(event) {
                     currentPage = 0;   
                     $ul.trigger('repaginate');  
                     $($(".page-number")[2]).addClass('actived').siblings().removeClass('actived');
                 }).appendTo($pager).addClass('clickable');
               // [이전]
                 $('<span class="page-number" cursor: "pointer">[이전]</span>').bind('click', {newPage: page},function(event) {
                     if(currentPage == 0) return; 
                     currentPage = currentPage-1;
               $ul.trigger('repaginate'); 
               $($(".page-number")[(currentPage-nowp)+2]).addClass('actived').siblings().removeClass('actived');
              }).appendTo($pager).addClass('clickable');
               // [1,2,3,4,5,6,7,8]
              for (var page = nowp ; page < endp; page++) { 
               $('<span class="page-number" cursor: "pointer" style="margin-left: 8px;"></span>').text(page + 1).bind('click', {newPage: page}, function(event) {
                currentPage = event.data['newPage'];
                $ul.trigger('repaginate');
                $($(".page-number")[(currentPage-nowp)+2]).addClass('actived').siblings().removeClass('actived');
                }).appendTo($pager).addClass('clickable');
              } 
               // [다음]
                 $('<span class="page-number" cursor: "pointer">[다음]</span>').bind('click', {newPage: page},function(event) {
               if(currentPage == numPages-1) return;
                   currentPage = currentPage+1;
               $ul.trigger('repaginate'); 
                $($(".page-number")[(currentPage-nowp)+2]).addClass('actived').siblings().removeClass('actived');
              }).appendTo($pager).addClass('clickable');
               // [끝]
              $('<span class="page-number" cursor: "pointer">[끝]</span>').bind('click', {newPage: page},function(event) {
                      currentPage = numPages-1;
                      $ul.trigger('repaginate');
                      $($(".page-number")[endp-nowp+1]).addClass('actived').siblings().removeClass('actived');
              }).appendTo($pager).addClass('clickable');
                
               
               if(ck<="1"){   
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
             
              var ck = Number($('.actived').text());
            if($('ul.paginated').next().hasClass('pager')){    $("#remo").remove();   }
                    
            $pager.insertAfter($ul);
               $ul.trigger('repaginate');


            });
           }

     
    </script>
    <script type="text/javascript">
    /* 댓글수정 클릭시  폼으로 바꾸기*/
    function modComment(btn, cnum){ 
       
         var con=$(btn).parent().parent().next().text();
        var user = "<%=(String)session.getAttribute("userId")%>";
       var htmls = "";
        
       htmls += "<form id='modcommentform'><div class='input-group'>";
       htmls += "<textarea class='form-control' id='con' name='content' row='3'>"+con+"</textarea>";
       htmls += "<input type='button' class='btn sub' id='btn_comment_modify' value='완료' />";
       htmls += "<input type='hidden' name='cnum' value='"+ cnum +"'>";
       htmls += "<input type='hidden' name='nickname' value='"+ user +"'>";
       htmls += "</div'></form>";

        
       $(btn).parent().parent().next().html(htmls);
       
       
         //댓글 수정완료 버튼 클릭 이벤트(ajax로처리)
         $('#btn_comment_modify').click(function(){
           console.log("완료버튼을 누름");
            
           $.ajax({
               type:"POST",
               url:"comment_modify",
               data:$("#modcommentform").serialize(),
              
               success:function(data){
                  console.log("댓글 수정하기");
               console.log(data.content);
               
                 $(btn).parent().parent().next().html(data.content);
                  
               },error:function(data){console.log("에러");},
            })
            
         });
     }

     
    /* 댓글삭제 클릭시*/
    function delComment(btn, cnum){ 
      var dnum = {"cnum":cnum};
       
       $.ajax({
               type:"POST",
               url:"comment_delete",
               data: dnum,
               dataType: 'text',
              
               success:function(data){
                  console.log("댓글 삭제하기");
                 listReply();
                 
                  
               },error:function(data){console.log("에러");},
            })
       
     }
    


    </script>

</head>
<body >
<jsp:include page="../default/header.jsp" />
    <section class="sec">

        <div class="container" style="margin: 30px auto;">
            <p class="date"> <fmt:formatDate value="${dto.savedate}" pattern="yyyy.MM.dd kk:mm"/></p>
            <div class="profile-head">
                <div class="col-md-4 col-sm-4 col-xs-12">

                    <img src="${productimg}" class="img-responsive" />


                     <p class="form-group star_div">별점:
                         <input type="hidden" class="rating" name="stars" value="${ dto.stars }" disabled/>
                   </p>  
                </div>
                <!--col-md-4 col-sm-4 col-xs-12 close-->


                <div class="col-md-5 col-sm-5 col-xs-12">
                    <ul>
                       <li><h5>${dto.title }</h5></li>
                        <li> 작성자 : ${dto.nickname }</li>
                        <li id="cvs"> 편의점 : &nbsp;</li>
                      
                        <li> 상품명: ${dto.productname }</li>
                        <li> 가격: ${price }</li>
                    </ul>

                </div>
                <!--col-md-5 col-sm-5 col-xs-12 close-->

            </div>
            <!--profile-head close-->
        </div>
        <!--container close-->


        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane fade active in" id="profile">
                <div class="container">

                    <br clear="all" />

                        <div class="col-md-6">      
                       
                            <p style="display:none;">  내 용</p>
<<<<<<< HEAD
                            <c:if test="${imgList != null}">
        	                    <c:forEach var="img" items="${imgList }">
        	                    	<img src="${img.gdsimg }" class="ProductImg">
    	                        </c:forEach>
                            </c:if>
=======
                            <c:if test="${dto.gdsimg != null }">
                                <div><img src="${dto.gdsimg }"/></div>
                             </c:if>
>>>>>>> branch 'master' of https://github.com/BerryMay/plzcvs.git
                            <div class="content_div">${dto.content }</div>

                        </div> <!--col-md-6 close-->

                </div>
                <!--container close-->
                
            <!-- 좋아요  -->
             <div class="heart_div">
               <form id="board_heart">
                  <input type="hidden" name="num" value="${dto.num }" /> <input
                     type="hidden" name="nickname" value="${userId }" />
                  <button type="button" class="btn_like" id="likebtn">
                     <span class="img_emoti">좋아요</span> <span class="ani_heart_m"></span>
                  </button>
               </form>
               <div align="center">
                  좋아요 : <label id="result"></label>
               </div>
            </div><!-- 좋아요  끝-->
            
            
            </div>
            <!--tab-pane close-->
        </div>
        <!--tab-content close-->

      <!-- 댓글 -->
      <div class="panel panel-white post">
         <!-- 댓글 목록 생성되는 곳 -->
           <div class="post-footer ">
              <p>총 덧글 수 <span id="cCnt"></span></p>
               <ul class="comments-list paginated"></ul>
           </div>
         <div class="comment_div">
              <form class="contentsbox" id="frm">
                <div class="input-group">
                    <textarea class="form-control" id="con" name="content" placeholder="Add a comment" row="3"></textarea>
                    <input type="button" class="btn" id="btn_comment" value="등록" class="sub">
                    <input type="hidden" name="bnum" value="${dto.num }">
                    <input type="hidden" name="nickname" value="${userId }">
                </div>
            </form>
            </div>
       </div>
    
          <!--게시글 수정/삭제/목록 버튼들 -->
           <div align="right">
           <input class="btn btn-primary" type="button" value="목록으로" onclick="javascript:location.href='board'">
              <c:if test="${userId == dto.nickname }">
                 <input class="btn btn-primary" type="button" value="수정" onclick="javascript:location.href='board_modify?num=${dto.num}'">
                 <input class="btn btn-primary" type="button" value="삭제" onclick="javascript:location.href='board_delete?num=${dto.num}'">
              </c:if>
           </div> 
    </section>
    <!--section close-->

    <jsp:include page="../default/footer.jsp" />
    
    
</body>
</html>