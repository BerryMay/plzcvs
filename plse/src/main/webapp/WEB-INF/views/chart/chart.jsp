<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<!-- ���� ��Ʈ ȣ���� ���� js ���� -->
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	  
<script>
//���� ��Ʈ ���̺귯�� �ε�
//google��ü�� ���� google src�ȿ� �������
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
                    title : "��ȸ�� ���",
       
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
        var chart = new google.visualization.PieChart(document.getElementById('chart_w')); //���� �׷���
                chart.draw(data, {
                    title : "������ȣ��ǰ",
       
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
          var chart = new google.visualization.PieChart(document.getElementById('chart_m')); //���� �׷���
               
                chart.draw(data, {
                    title : "������ȣ��ǰ",
       
                    width : 400,
                    height : 300,
                  
                });
    }
 
</script>
</head>
<body>
 <jsp:include page="../default/header.jsp" />
    <!-- ��Ʈ ��� ���� -->
    <div id="chart_div" align="center"></div>
 	<div align="center" style="width: 800px; margin: 0 auto; ">
	    <div id="chart_w" align="center" style="float: left;"></div>
		<div id="chart_m" align="center" style="float: right;"></div>
    </div>
    
    <jsp:include page="../default/footer.jsp" />
</body>
</html>