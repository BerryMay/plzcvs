<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="resources/js/moment.js"></script>
    <script>
      var pagesu =10;  //페이지 번호 갯수
	  var currentPage = 0; //현재페이지
	  var numPerPage = 3;  //페이징시 표출되는 목록의갯수
	  var endPage;	//끝페이지
	  var comnum;	//전체댓글수
	  var wantpg=3;	//출력시 3페이지로 나누기 위한 변수
    
    
    $(function(){
    	$('#btn_comment').click(function(){
    		$.ajax({
    			url:"board_comment",
    			type:"POST",
    			data:$("#board_comment").serialize(),
    			success:function(data){
    				commentList();
    			},
    			error:function(){
    				alert("세션이 만료되었거나, 댓글을 입력해주세요")
    	    	}
    		}) //ajax끝
    	})
    })
    function commentList(){
    	$.ajax({
			url:"board_commentList",
			type:"POST",
			data:$("#board_comment").serialize(),
			success:function(data){
				$("#comment").text("");
				var output;
				output += "<tbody style='width:100%'>"; 
				console.log(data);
				comnum = data.length
				endPage = Math.ceil(comnum/wantpg); 
				
				for(i=0; i< comnum; i++){
					var user =  "<%=(String)session.getAttribute("userId")%>";
					var savedate = moment(data[i].savedate).format('YYYY.MM.DD HH:mm');
					output += "<thread><tr>"
						output += "<td style='width:20%'>"+data[i].nickname+"</td>";
						output += "<td style='width:60%'>"+data[i].content+"</td>";
						output += "<td style='width:20%'><h6 style='color:#aaa''>"+savedate+"</h6></td>";
						if(data[i].nickname == user){
							output += "<td>수정</td>"
							output += "<td>삭제</td>"
						}
						output += "</tr></thead>"
					
						
				}
				output += "</tbody>"; 
				
				$("#comment").append(output);
				page();
			},
			error:function(){
	    		alert("댓글리스트  오류발생")
	    	}
		});
    }
    
    
 // 만들어진 테이블에 페이지 처리
	function page(){ 
		
		var reSortColors = function($table) {
		  $('tbody tr:odd td', $table).removeClass('even').removeClass('listtd').addClass('odd');
		  $('tbody tr:even td', $table).removeClass('odd').removeClass('listtd').addClass('even');
		 };
		 
		 
		 
		 $('table.paginated').each(function() {
		 
		  var $table = $(this);    
		  
		  
		  //length로 원래 리스트의 전체길이구함
		  var numRows = comnum;
		  //Math.ceil를 이용하여 반올림
		  var numPages = endPage;
		  //리스트가 없으면 종료
		  if (numPages==0) return;
		  //pager라는 클래스의 div엘리먼트 작성
		  var $pager = $('<td align="center" id="remo" colspan="10"><div class="pager"></div></td>');
		  
		  var nowp = currentPage;
		  var endp = endPage;
		  
		  //페이지를 클릭하면 다시 셋팅
		  $table.bind('repaginate', function() {
			  
		  //기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다
		   $table.find('tbody tr').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();
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
		   $('<br /><span class="page-number" cursor: "pointer">[처음]</span>').bind('click', {newPage: page},function(event) {
		          currentPage = 0;   
		          $table.trigger('repaginate');  
		          $($(".page-number")[2]).addClass('active').siblings().removeClass('active');
		      }).appendTo($pager).addClass('clickable');
		    // [이전]
		      $('<span class="page-number" cursor: "pointer">&nbsp;&nbsp;&nbsp;[이전]&nbsp;</span>').bind('click', {newPage: page},function(event) {
		          if(currentPage == 0) return; 
		          currentPage = currentPage-1;
		    $table.trigger('repaginate'); 
		    $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
		   }).appendTo($pager).addClass('clickable');
		    // [1,2,3,4,5,6,7,8]
		   for (var page = nowp ; page < endp; page++) {
		    $('<span class="page-number" cursor: "pointer" style="margin-left: 8px;"></span>').text(page + 1).bind('click', {newPage: page}, function(event) {
		     currentPage = event.data['newPage'];
		     $table.trigger('repaginate');
		     $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
		     }).appendTo($pager).addClass('clickable');
		   } 
		    // [다음]
		      $('<span class="page-number" cursor: "pointer">&nbsp;&nbsp;&nbsp;[다음]&nbsp;</span>').bind('click', {newPage: page},function(event) {
		    if(currentPage == numPages-1) return;
		        currentPage = currentPage+1;
		    $table.trigger('repaginate'); 
		     $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
		   }).appendTo($pager).addClass('clickable');
		    // [끝]
		   $('<span class="page-number" cursor: "pointer">&nbsp;[끝]</span>').bind('click', {newPage: page},function(event) {
		           currentPage = numPages-1;
		           $table.trigger('repaginate');
		           $($(".page-number")[endp-nowp+1]).addClass('active').siblings().removeClass('active');
		   }).appendTo($pager).addClass('clickable');
		     
		     $($(".page-number")[2]).addClass('active');
		reSortColors($table);
		  });
		   $pager.insertAfter($table).find('span.page-number:first').next().next().addClass('active');   
		   $pager.appendTo($table);
		   $table.trigger('repaginate');
		 });
		}
    
    
    
    
    
    
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
    
    </script>

</head>
<body onload="heartChk();heartCnt();commentList()">
<jsp:include page="../default/header.jsp" />
	 <section class="sec">

       <div class="container" style="margin: 30px auto;">
            <p class="date"> <fmt:formatDate value="${dto.savedate}" pattern="yyyy.MM.dd kk:mm"/></p>
            <div class="profile-head">
                <div class="col-md-4 col-sm-4 col-xs-12">
                    <img src="${productimg }" class="img-responsive" />
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
                            <c:if test="${dto.gdsimg != null }">
                             	<div><img src="${dto.gdsimg }"/></div>
                             </c:if>
                            <div class="content_div"> ${dto.content }</div>

                        </div> <!--col-md-6 close-->
                </div> <!--container close-->
               
                
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
                
            </div><!--tab-pane close-->
        </div><!--tab-content close-->
        

	
 </section>
    <!--section close-->
	<!-- 댓글 -->
	 <div class="container">
        
            <div class="panel panel-white post panel-shadow">
                <div class="post-footer">
					<div >
						<table class="comment paginated" id="comment" style='width:100%'>
						
						
						</table>
					</div></br>
                    <form class="contentsbox" id="board_comment">
                        <div class="input-group">
                            <input class="form-control" name="content" placeholder="Add a comment" type="text">
                            <input type="button" id="btn_comment" value="등록" class="sub">
                            <input type="hidden" name="bnum" value="${dto.num }">
                            <input type="hidden" name="nickname" value="${userId }">
                        </div>
                    </form>
                </div>
            </div>
        </div> <!-- 댓글  -->
        <!--게시글 수정/삭제/목록 버튼들 -->
        <div align="right">
        <input class="btn btn-primary" type="button" value="목록으로" onclick="javascript:location.href='board'">
           <c:if test="${userId == dto.nickname }">
              <input class="btn btn-primary" type="button" value="수정" onclick="javascript:location.href='board_modify?num=${dto.num}'">
              <input class="btn btn-primary" type="button" value="삭제" onclick="javascript:location.href='board_delete?num=${dto.num}'">
           </c:if>
        </div> 

    <jsp:include page="../default/footer.jsp" />
     <script>
         var cvs ="";
         switch(${ dto.cvsnum }){
            case 1: cvs="GS25"; break;
            case 2: cvs="세븐일레븐"; break;
            case 3: cvs="CU"; break;
         }
         document.getElementById("cvs").innerText+=cvs
      </script>
</body>
</html>