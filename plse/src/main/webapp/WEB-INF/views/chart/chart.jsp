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
//�ε��� �Ϸ�Ǹ� drawChart �Լ��� ȣ��
    google.setOnLoadCallback(drawChart); //���̺귯���� �ҷ����� �۾��� �Ϸ�Ǿ����� drawChart�۾��� �����϶�� ��.
    function drawChart() {
        var jsonData = $.ajax({ //�񵿱��� ������� ȣ���Ѵٴ� �ǹ��̴�.
            url : "cart_money_list.do",

            //chart01������ json�� �ּҸ� ���� �������� �� ������������ ��Ʈ�ѷ��� �̵��� �����ؼ� ���̽��� ��������
            //��������� �� ���� json�� ���� ������.
            
            
            
            
            //chart01���� ���� ��� url : "${path}/json/sampleData.json",
            //json�� sampleData.json������ �ҷ��´�.
            //Ȯ���ڰ� json�̸� url ������ �� ���־�� �Ѵ�. �����ָ� �ڹ��������� �˰� 404������ �߻��Ѵ�.
            //�׷��� ������ servlet-context���Ͽ��� ���ҽ��� �������ش�.
            dataType : "json",
            async : false
        }).responseText; //���̽������� text���Ϸ� �о���δٴ� ��
        console.log(jsonData);
        //���������̺� ����
        var data = new google.visualization.DataTable(jsonData);
        //���̽� ������ ������ ���̺� �������� �ٲ��ֱ� ���ؼ� �������
        //��Ʈ�� ����� div
        //LineChart, ColumnChart, PieChart�� ���� ��Ʈ�� ������ �ٲ��.
        
        //var chart = new google.visualization.PieChart(
                //document.getElementByld('chart_div')); //���� �׷���
        
        //var chart = new google.visualization.LineChart(document.getElementById('chart_div')); //�� �׷��� 
                
        var chart
          = new google.visualization.ColumnChart(document.getElementById('chart_div'));
                //��Ʈ ��ü.draw(������ ���̺�, �ɼ�) //����׷���
                
                //cuveType : "function" => �ó��
                
                //�����͸� ������ (Ÿ��Ʋ, ����, �ʺ�) ��Ʈ�� �׸���.
                chart.draw(data, {
                    title : "��ȸ�� ���",
                    //curveType : "function", //curveType�� ��Ʈ�� ����� ����� �ٲ�ٴ� ��
                    width : 600,
                    height : 400
                });
    }
 
</script>
</head>
<body>
 <jsp:include page="../default/header.jsp" />
    <!-- ��Ʈ ��� ���� -->
    <div id="chart_div"></div>
    <!-- ��Ʈ�� �׷����� ���� -->
    <!-- ��Ʈ ���ΰ�ħ ��ư -->
    <button id="btn" type="button" onclick="drawChart()">refresh</button>
    <jsp:include page="../default/footer.jsp" />
</body>
</html>