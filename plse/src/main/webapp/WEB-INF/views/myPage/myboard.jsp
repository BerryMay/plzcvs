<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript">
$(document).ready(function() {
var pagesu =10;  //페이지 번호 갯수
  var currentPage ; //현재페이지
  var numPerPage = 5;  //페이징시 표출되는 목록의갯수
  var endPage;	//끝페이지
  var comnum;	//전체댓글수
  var wantpg=5;	//출력시 5페이지로 나누기 위한 변수


/* 내가 쓴 글 부르기 */
 $(".myboard").click(function(){
			  var i, tabcontent, tablink;
			  tabcontent = document.getElementsByClassName("art_content");
			  for (i = 0; i < tabcontent.length; i++) {
			    tabcontent[i].style.display = "none";
			  }
			  tablink = document.getElementsByClassName("art_tablink");
			  for (i = 0; i < tablink.length; i++) {
				  tablink[i].className = tablink[i].className.replace(" active", "");
			  }

	 document.getElementById("review").style.display = "block";
	 $(".review_btn").addClass( 'active' );
	 myboard_list(1);   	 	 
 });
 $(".review_btn").click(function(){
	 myboard_list(1);   	 
 });
 $(".recipe_btn").click(function(){
	 myboard_list(2);   	 
 });
 
 //내가 쓴 글 목록부르기
 function myboard_list(category){
	 currentPage = 0; 
	
	var category =category;//카테고리
 	var now = moment(); //현재시간
	 
	var user = '<%=(String)session.getAttribute("userId")%>';
 	var nick = {"nickname":user};
 	 
    $.ajax({
       type:"POST",
       url:"myboard_list",
       data: nick,
      
       success:function(data){
    	   var html = "";
          
           comnum = data.length;
			
           
           if(data.length > 0){
               for(i=0; i<data.length; i++){
            	   var c= Number(data[i].cat);
            	   if(category != c) {comnum -= 1; continue;}	//카테고리가 다르면 넘긴다
            	   
            	   var savedate = moment(data[i].savedate).format('YYYY.MM.DD');
            	   var sd_dayCnt= moment.duration(now.diff(savedate)).asDays(); //현재시간과 savedate일수 차이
            	   
            	  if(category ==1){//리뷰 선택시
            		  console.log("리뷰 선택시 : "+ category);
   	               if(comnum <1){
	            	   $(".table-list tbody").html("<td colspan='7'>좋아요 한 게시글이 없습니다.</td>");
	            	}
                	   var newproductdate = moment(data[i].newproduct).format('YYYY.MM.DD');
                	   var np_dayCnt= moment.duration(now.diff(newproductdate)).asDays(); //현재시간과 newproductdate일수 차이
						
                	   //편의점분류
                	   var cvs ="";
                	   if(data[i].cvsnum == 1 ){cvs ="GS25"}
                	   else if(data[i].cvsnum == 2 ){cvs ="세븐일레븐"}
                	   else{cvs ="CU"}
                	   
                	 //데이터 출력
                       html += "<tr>";
                       html += "<td style='text-align: center'>"+data[i].num +"</td>";
                       html += "<td style='text-align: center'>"+cvs +"</td>";
                       
                       html += "<td style='text-align: center' title='"+data[i].productname +"'>"+data[i].productname;
                       
                       //new띄우기
                       if(np_dayCnt < 30){ html += "<span class='new'>new!</span>";	}  
                       
                       html += "</td>";
                       html += "<td><a href='detail?num="+data[i].num+"' class='aw100' title='"+data[i].title +"'>"+data[i].title;
                       	//댓글 수 표시하기				
						if(data[i].replycnt != 0 ){
							html += "<span class='replycnt'>("+data[i].replycnt+")</span>";
						}
                       	//베스트 띄우기
                       if(data[i].hit >= 20){  html += "<span class='hit'>best!</span>"; }

                       html += "</a></td><td style='text-align: center'>";
                       //작성일 표시하기
                       if(sd_dayCnt < 1){ html +=moment(data[i].savedate).format('kk:mm')+"</td>";}
                       else{ html += savedate+"</td>";}
                       
                       html += "<td style='text-align: center'>"+data[i].hit+"</td>";

                       
                       html += "</tr>";
                	   
                	   
                	   
                	   
            	  }else{//레시피 선택시
            		  console.log("레시피 선택시 : "+ category);
            		  if(comnum <1){
                   	   $(".table-list tbody").html("<td colspan='5'>작성된 게시글이 없습니다.</td>");
                   	}
            		//데이터 출력
                      html += "<tr>";
                      html += "<td style='text-align: center'>"+data[i].num +"</td>";
                      
                      html += "<td><a href='detail?num="+data[i].num+"' class='aw100' title='"+data[i].title +"'>"+data[i].title;
                      //댓글 수 표시하기				
	   						if(data[i].replycnt != 0 ){
	   							html += "<span class='replycnt'>("+data[i].replycnt+")</span>";
	   						}
                      //베스트 띄우기
                      		if(data[i].hit >= 20){  html += "<span class='hit'>best!</span>"; }

                      html += "</a></td>";
                      
                      html += "<td style='text-align: center'>";
                      //작성일 표시하기
                      if(sd_dayCnt < 1){ html +=moment(data[i].savedate).format('kk:mm')+"</td>";}
                      else{ html += savedate+"</td>";}
                      
                      html += "<td style='text-align: center'>"+data[i].hit+"</td>";

                      
                      html += "</tr>";
            	  }//카테고리별보기 if/else end
           	}//for end 
           	
               $(".table-list tbody").html(html);
               endPage = Math.ceil(comnum/wantpg); 

               list_page(category);
               
           }
          
           
           

       },
       error:function(data){console.log("에러");},
    });
 
 };



 
 // 내가 쓴 글 페이지 처리
	function list_page(category){ 
	
		 $('.table-list-'+category+' tbody').each(function() {
			
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
	   				 
				$pager.insertAfter($('.table-list-'+category));
	   			$table.trigger('repaginate');

		 });

	}//페이지 처리 끝   
 

    
    
}); 
     

     


</script>
</head>
<body>
<!-- 리뷰보기 / 레시피보기  -->
		<div align="center">
		<ul class="list_select_ul">
			<li><button class="art_tablink active review_btn" onclick="openArticle(event, 'review')">리뷰</button></li>
			<li><button class="art_tablink recipe_btn" onclick="openArticle(event, 'recipe')">레시피</button></li>
		</ul>
	</div>	
	<!-- 리뷰보기 -->
	<article  id="review" class="art_content" >
		<table class="table table-striped table-list table-list-1 table-hover" style="width: 100%;">
				<thead>
					<tr height="42px">
						<th style=" border-radius: 10px 0 0 0;" width="5%" >번호</th>
						<th width="10%">편의점</th>
						<th width="20%">상품명</th>
						<th width="45%">제목</th>
						<th width="15%">작성일</th>
						<th style=" border-radius: 0 10px 0 0;" width="5%">조회</th>
					</tr>
				</thead>
				<tbody>
					<!-- 글 불러오는 곳 -->			
				</tbody>
			</table>
			
	</article>
	
	<!-- 레시피 보기 -->
	<article  id="recipe" class="art_content" >
	
		<table class="table table-striped table-list table-list-2 table-hover" style="width: 100%;">
				<thead>
					<tr height="42px">
						<th style=" border-radius: 10px 0 0 0;" width="10%" >번호</th>
						<th width="65%">제목</th>
						<th width="15%">작성일</th>
						<th style=" border-radius: 0 10px 0 0;" width="10%">조회</th>
					</tr>
				</thead>
				<tbody>
					<!-- 글 불러오는 곳 -->			
				</tbody>
			</table>
			
	</article>
</body>
</html>