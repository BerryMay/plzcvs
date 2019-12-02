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
    
    
   <!-- js파일-->
    <script type="text/javascript" src="resources/jquery-3.4.1.min.js"></script>
    <script>
    $(function() {
	    $('#likebtn').click(function(){
	    	  if($("button").hasClass('btn_unlike')){
	    	    $("button").removeClass('btn_unlike');
	    	    $('.ani_heart_m').removeClass('hi');
	    	    $('.ani_heart_m').addClass('bye');
	    	  }
	    	  else{
	    	    $("button").addClass('btn_unlike');
	    	    $('.ani_heart_m').addClass('hi');
	    	    $('.ani_heart_m').removeClass('bye');
	    	  }
	    	});
    	})
    </script>


</head>
<body>
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
        <button type="button" class="btn_like" id="likebtn">
            <span class="img_emoti">좋아요</span>
            <span class="ani_heart_m"></span>
        </button>
    </div>


    <!-- 댓글 -->
	 <div class="container">
        
            <div class="panel panel-white post panel-shadow">

                <div class="post-footer">

                    <ul class="comments-list">
                        <li class="comment">

                            <div class="comment-body">
                                <div class="comment-heading">
                                    <h4 class="user">Gavino Free</h4>
                                    <h5 class="time">5 minutes ago</h5>
                                </div>
                                <p>Sure, oooooooooooooooohhhhhhhhhhhhhhhh</p>
                            </div>
                        </li>
                    </ul>
                    <form class="contentsbox">
                        <div class="input-group">
                            <input class="form-control" placeholder="Add a comment" type="text">
                            <input type="submit" value="등록" class="sub">
                        </div>
                    </form>
                </div>
            </div>
        </div>
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