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
       
                    width : 800,
                    height : 500
                });
    }
 
</script>
</head>
<body>
 <jsp:include page="../default/header.jsp" />
    <!-- ��Ʈ ��� ���� -->
    <div id="chart_div" align="center"></div>
    <!-- ��Ʈ�� �׷����� ���� -->
    
    <jsp:include page="../default/footer.jsp" />
</body>
</html>