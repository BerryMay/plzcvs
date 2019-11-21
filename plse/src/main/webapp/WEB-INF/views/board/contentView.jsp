<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">  -->

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
            <p class="date">날짜 :</p>
            <div class="profile-head">
                <div class="col-md- col-sm-4 col-xs-12">
                    <img src=" " class="img-responsive" />
                    <h6>Jenifer Smith</h6>
                </div>
                <!--col-md-4 col-sm-4 col-xs-12 close-->


                <div class="col-md-5 col-sm-5 col-xs-12">
                    <h5>글제목</h5>
                    <p>별점: </p>
                    <ul>

                        <li> 글쓴이 : </li>
                        <li> 편의점 : </li>
                        <li> 상품명 : </li>
                        
                    </ul>


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
                                                내용출력부분
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
    <jsp:include page="../default/footer.jsp" />
</body>
</html>