<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>💘첫인상 - First Impression</title>

<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />
<script src="http://code.jquery.com/jquery-1.11.0.js"></script>
</head>
<body>
		<script type="text/javascript">
		    $(function() {  
		        // Geolocation API에 액세스할 수 있는지를 확인
		        if (navigator.geolocation) {
		            //위치 정보를 얻기
		            navigator.geolocation.getCurrentPosition (function(pos) {
		            var latitude=pos.coords.latitude;   // 위도
		            var longitude=pos.coords.longitude; // 경도
		            alert("위치 정보가 수정되었습니다");
					/* location.href = "siMain.do"; */
					location.href = "siMain.do?latitude="+latitude+"&longitude="+longitude;
		            });
		        } else {
		            alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.");
		            history.go(-1);
		        }
		    });
		</script>
	
</body>
</html>