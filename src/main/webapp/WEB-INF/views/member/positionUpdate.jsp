<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>๐์ฒซ์ธ์ - First Impression</title>

<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />
<script src="http://code.jquery.com/jquery-1.11.0.js"></script>
</head>
<body>
		<script type="text/javascript">
		    $(function() {  
		        // Geolocation API์ ์ก์ธ์คํ  ์ ์๋์ง๋ฅผ ํ์ธ
		        if (navigator.geolocation) {
		            //์์น ์ ๋ณด๋ฅผ ์ป๊ธฐ
		            navigator.geolocation.getCurrentPosition (function(pos) {
		            var latitude=pos.coords.latitude;   // ์๋
		            var longitude=pos.coords.longitude; // ๊ฒฝ๋
		            alert("์์น ์ ๋ณด๊ฐ ์์ ๋์์ต๋๋ค");
					/* location.href = "siMain.do"; */
					location.href = "siMain.do?latitude="+latitude+"&longitude="+longitude;
		            });
		        } else {
		            alert("์ด ๋ธ๋ผ์ฐ์ ์์๋ Geolocation์ด ์ง์๋์ง ์์ต๋๋ค.");
		            history.go(-1);
		        }
		    });
		</script>
	
</body>
</html>