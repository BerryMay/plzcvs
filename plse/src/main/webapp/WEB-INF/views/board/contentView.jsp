<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">  -->
	<script type="text/javascript" src="js/bootstrap-rating.js"></script>
	<link rel="stylesheet" href="css/contentView.css" type="text/css" />

    <!--댓글-->
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="resources/js/moment.js"></script>
   <!-- js파일-->
    <script type="text/javascript" src="resources/jquery-3.4.1.min.js"></script>
    <script>
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
				var output = "<table style='width:100%'>";
				output += "<tbody style='width:100%'>"; 
				for(var i in data){
					var user =  "<%=(String)session.getAttribute("userId")%>";
					var savedate = moment(data[i].savedate).format('YYYY년 MM월 DD일 HH:mm:ss');
					output += "<tr>"
					output += "<td style='width:20%'>"+data[i].nickname+"</td>";
					output += "<td style='width:60%'>"+data[i].content+"</td>";
					output += "<td style='width:20%'>"+savedate+"</td>";
					output += "</tr>"
				}
				output += "</tbody>"; 
				output += "</table>"
				$("#comment").append(output);
			},
			error:function(){
	    		alert("댓글리스트  오류발생")
	    	}
		})
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
    
    </script>

</head>
<body onload="heartChk();heartCnt();commentList()">
<jsp:include page="../default/header.jsp" />
	 <section class="sec">

        <div class="container" style="margin-top: 30px;">
            <p class="date"> <fmt:formatDate value="${dto.savedate}" pattern="yyyy.MM.dd kk:mm"/></p>
            <div class="profile-head">
                <div class="col-md- col-sm-4 col-xs-12">
                    <img src=" " class="img-responsive" />
                    <h6>Jenifer Smith</h6>
                </div>
                <!--col-md-4 col-sm-4 col-xs-12 close-->

                <div class="col-md-5 col-sm-5 col-xs-12">
                    <ul>
                    	<li><h5>${dto.title }</h5></li>
                        <li> 작성자 : ${dto.nickname }</li>
                        <li id="cvs"> 편의점 : &nbsp;</li>
                       <script>
                           var cvs ="";
                           switch(${ dto.cvsnum }){
                              case 1: cvs="GS25"; break;
                              case 2: cvs="세븐일레븐"; break;
                              case 3: cvs="CU"; break;
                           }
                           document.getElementById("cvs").innerText+=cvs
                        </script>
                        <li> 상품명: ${dto.productname }</li>
                        <li> 가격: ${price }</li>
                    </ul>
                    <p class="form-group star_div">별점:
                   <input type="hidden" class="rating" name="stars" value="${ dto.stars }" disabled/>
                </p>  

                </div>
                <!--col-md-8 col-sm-8 col-xs-12 close-->
            </div>
            <!--profile-head close-->
        </div>
        <!--container close-->

        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane fade active in" id="profile">
                <div class="container">

                    <br clear="all" />
                    <div class="row">

                        <div class="col-md-6">

                            <div class="table-responsive responsiv-table">
                                <table class="table bio-table">
                                    <tbody>
                                        <tr>
                                            <td>내 용</td>

                                        </tr>
                                        <tr>
                                            <td>
                                                ${dto.content }
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                            <!--table-responsive close-->
                        </div>
                        <!--col-md-6 close-->

                    </div>
                    <!--row close-->

                </div>
                <!--container close-->
            </div>
            <!--tab-pane close-->

        </div>
        <!--tab-content close-->


    </section>
    <!--section close-->

	<div>
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
	</div>

	<!-- 댓글 -->
	 <div class="container">
        
            <div class="panel panel-white post panel-shadow">
                <div class="post-footer">
					<div id="comment">
		
					</div>
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
        <div align="right">
        <input class="btn btn-primary" type="button" value="목록으로" onclick="javascript:location.href='board'">
        	<c:if test="${userId == dto.nickname }">
	        	<input class="btn btn-primary" type="button" value="수정" onclick="javascript:location.href='board_modify?num=${dto.num}'">
	        	<input class="btn btn-primary" type="button" value="삭제" onclick="javascript:location.href='board_delete?num=${dto.num}'">
        	</c:if>
        </div>
    <jsp:include page="../default/footer.jsp" />
</body>
</html>