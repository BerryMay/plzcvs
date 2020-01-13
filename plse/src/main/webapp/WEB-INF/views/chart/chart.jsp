<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<!-- 구글 차트 호출을 위한 js 파일 -->
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	  
<script>
//구글 차트 라이브러리 로딩
//google객체는 위쪽 google src안에 들어있음
google.load('visualization','1',{
    'packages' : ['corechart']
});

    google.setOnLoadCallback(drawChart);
    google.setOnLoadCallback(drawChart2);
    google.setOnLoadCallback(drawChart3);
    
    function drawChart() {
        var jsonData = $.ajax({ 
            url : "chart_list",
            dataType : "json",
            async : false
        }).responseText; 
        console.log(jsonData);

        var data = new google.visualization.DataTable(jsonData);
        var chart
          = new google.visualization.ColumnChart(document.getElementById('chart_div'));
               
                chart.draw(data, {
                    //title : "조회수 통계",
       
                    width : 700,
                    height : 500
                });
    }
    
    function drawChart2() {
        var jsonData = $.ajax({ 
            url : "chart_w",
            dataType : "json",
            async : false
        }).responseText; 
        console.log(jsonData);

        var data = new google.visualization.DataTable(jsonData);
        var chart = new google.visualization.PieChart(document.getElementById('chart_w')); //원형 그래프
                chart.draw(data, {
                    //title : "여성선호식품",
       
                    width : 400,
                    height : 300,
                });
    }
    
    function drawChart3() {
        var jsonData = $.ajax({ 
            url : "chart_m",
            dataType : "json",
            async : false
        }).responseText; 
        console.log(jsonData);

        var data = new google.visualization.DataTable(jsonData);
       /*  var chart
          = new google.visualization.ColumnChart(document.getElementById('chart_m')); */
          var chart = new google.visualization.PieChart(document.getElementById('chart_m')); //원형 그래프
               
                chart.draw(data, {
                    //title : "남성선호식품",
       
                    width : 400,
                    height : 300,
                  
                });
    }
 
</script>
<style>
article hr{width:60%; margin: 20px auto;}
article{
	margin-top: 20px;
}
.chart_gender hr{
	float: left;
	width:250px;
	transform:rotate(90deg);
	position:relative; top:180px; left:-120px; z-index: 10;
}
.chart_gender rect{width:120px;}
article h3{width:200px; margin:0 auto 20px;}
</style>
</head>
<body>
 <jsp:include page="../default/header.jsp" />
    <!-- 차트 출력 영역 -->
    <article>
    	<h3>조회  수 통계</h3>
	    <div id="chart_div" align="center"></div>
	     <hr>
    </article>
    
   
 	<div class="chart_gender" align="center" style="width: 800px; margin: 0 auto; ">
 		<article style="float: left;">
    		<h3>여성 선호 식품</h3>
	    	<div id="chart_w" align="center"></div>
	    </article>
	    <hr>
	    <article  style="float: right;">
    		<h3>남성 선호 식품</h3>
			<div id="chart_m" align="center"></div>
		</article>
    </div>
    
    <jsp:include page="../default/footer.jsp" />
</body>
</html>