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
                    title : "조회수 통계",
       
                    width : 800,
                    height : 500
                });
    }
 
</script>
</head>
<body>
 <jsp:include page="../default/header.jsp" />
    <!-- 차트 출력 영역 -->
    <div id="chart_div" align="center"></div>
    <!-- 차트가 그려지는 영역 -->
    
    <jsp:include page="../default/footer.jsp" />
</body>
</html>