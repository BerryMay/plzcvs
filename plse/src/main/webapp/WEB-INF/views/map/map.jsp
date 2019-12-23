<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ddf9f8fbb28e88c7a683a59280cef4d7"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../default/header.jsp" />
	<div id="map" style="width:500px;height:400px;"></div>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(37.554330, 126.969547),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
	</script>
	<jsp:include page="../default/footer.jsp" />
</body>
</html>