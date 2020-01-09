<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="resources/jquery-3.4.1.min.js"></script><!-- 기본 jquery -->
<script src="resources/js/moment.js"></script><!-- 시간띄우기 -->

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.min.css" />
<link rel="stylesheet" href="css/board.css" type="text/css" />
<link rel="stylesheet" href="css/mypage.css" type="text/css" />
<link rel="stylesheet" href="css/adminPost.css" type="text/css" />
<title>관리자 물품등록</title>
<style>
	.btn.btn_admin{background: #ff9999;  color: #ddd;}
</style>





<script type="text/javascript">
$(document).ready(function() {


  myboard_list();
});

var pagesu =10;  //페이지 번호 갯수
var currentPage ; //현재페이지
var numPerPage = 10;  //페이징시 표출되는 목록의갯수
var endPage;	//끝페이지
var comnum;	//전체댓글수
var point;
var nickname;




 //내가 쓴 글 목록부르기
 function myboard_list(){
	 currentPage = 0; 


    $.ajax({
       type:"POST",
       url:"admin_member",
      
       success:function(data){
    	   var html = "";
          console.log(data)
           comnum = data.length;
			
           
           if(data.length > 0){
               for(i=0; i<data.length; i++){
            	
                	 //데이터 출력
                       html += "<form id='frm-"+i+"' action='#'>";
                       html += "<tr>";
                       html += "<td style='text-align: center'>"+data[i].nickname  +"</td>";
                       html += "<td style='text-align: center'>"+data[i].age +"</td>";
                       html += "<td style='text-align: center'>"+data[i].gender+"</td>";      
                       html += "<td style='text-align: center'>"+data[i].mail+"</td>";
         
                       //html += "<td style='text-align: center'><input style=' width:50px;'value="+data[i].point+"></input><button type='button' onClick='document.getElementById('frm').submit();'  ></button> </td>";
                      // html += "<input type='hidden' style=' width:50px;'value="+data[i].nickname+">";
                      // html += "<td style='text-align: center'><input style=' width:50px;'value="+data[i].point+"></input>";
                       //html += "<button onClick='repoint(this,'document.getElementById('frm-"+i+"'))'>수정</button> </td>";
                       html += "<td style='text-align: center'><input id='test"+i+"' style=' width:50px;' name='point' value="+data[i].point+"></input>&nbsp<button type='button' class='btn btn_admin' onClick='repoint(\""+data[i].nickname+"\" ,"+i+");'>수정</button></td>";
                       html += "<td style='text-align: center'><button type='button' class='btn btn_admin' onClick='delMember(this,\""+data[i].nickname+"\");'>삭제</button></td>";
                       html += "</tr>";
                       html += "</form>";
                       console.log($('#test'+i).val())
            	  
           		}//for end 
           	
               $(".table-list tbody").html(html);
               endPage = Math.ceil(comnum/numPerPage); 
               console.log(endPage)

               list_page();
               
           }

       },
       error:function(data){console.log("에러");},
    });
 
 };


 
 // 내가 쓴 글 페이지 처리
	function list_page(){ 
	
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
		  
		var ck =1;
		

		  
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
	  		   
	  		   //console.log("ck의 값 : " +ck);
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

			if($('.table-list').next().hasClass('pager')){ $('.table-list+.pager').remove()	}
	   				 
				$pager.insertAfter($('.table-list'));
	   			$table.trigger('repaginate');

		 });

		}//페이지 처리 끝   
	
     
		
		
		
		
     
		/* 댓글삭제 클릭시*/
		function delMember(btn, nickname){ 
				var nickname = {"nickname":nickname};
				console.log(nickname)
			$.ajax({
			            type:"POST",
			            url:"member_delete",
			            data: nickname,
			            dataType: 'text',
			           
			            success:function(data){
			         	   console.log("탈퇴하기");
			         	   myboard_list();
			         	  
			         	   
			            },error:function(data){console.log("에러");},
			         })
			
		 }
     
		/* 포인트수정*/
		function repoint(nickname,i){ 
				//var nickname = {"nickname":nickname};
				//console.log(nickname)
				var point = $('#test'+i).val()
				var data ={"nickname":nickname, "point":point};
				console.log("나오니")
				console.log(point);
			$.ajax({
			            type:"POST",
			            url:"repoint",
			            data: data,
			            dataType: 'text',
			           
			            success:function(data){
			         	   console.log("포인트수정");
			         	   myboard_list();
			         	  
			         	   
			            },error:function(data){console.log("에러");},
			         })
			
		 }


		
		
		


</script>




</head>
<<<<<<< HEAD
<body >
	<c:if test="${userId != '관리자' }">
=======
<body>
	<c:if test="${dto.verify != 9 }">
>>>>>>> branch 'master' of https://github.com/BerryMay/plzcvs.git
		<script type="text/javascript">
			alert("관리자가 아닙니다")
			location.href="/practice/";
	   </script>
	</c:if>
	
<jsp:include page="../default/header.jsp" /> 
	
	<h2>관리자 페이지</h2>
	<!-- 메뉴 -->
	<div class="mymenu_div">
		<ul class="myMenu">
			<li><a href="adminPost?nickname=${userId }"><button class="tablink">상품등록</button></a></li>
			<li><a href="adminMember?nickname=${userId }"><button class="tablink active">멤버보기</button></a></li>
			<li><a href="adminProduct?nickname=${userId }"><button class="tablink">상품보기</button></a></li>
		</ul>
	</div>
	
<!-- 리뷰보기 -->
	<article  id="review" class="art_content" >
		<table class="table table-striped table-list table-hover" style="width: 80%; margin: 0 auto;">
				<thead>
					<tr height="42px">
						<th style=" border-radius: 10px 0 0 0;" width="15%">닉네임</th>
						<th width="20%">생년월일</th>
						<th width="10%">성별</th>
						<th width="35%">이메일</th>
						<th width="20%">포인트</th>
						<th style=" border-radius: 0 10px 0 0;" width="15%"> </th>
						
						
					</tr>
				</thead>
				<tbody>
					<!-- 글 불러오는 곳 -->			
				</tbody>
		</table>
	</article>
	
	
	
	
	
	
	
	
	
	<jsp:include page="../default/footer.jsp"/>
</body>
</html>

