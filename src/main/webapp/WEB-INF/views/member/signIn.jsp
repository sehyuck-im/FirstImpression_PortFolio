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
	<c:if test="${result == 1 }">
		<script type="text/javascript">
		    $(function() {  
		        // Geolocation API์ ์ก์ธ์คํ  ์ ์๋์ง๋ฅผ ํ์ธ
		        if (navigator.geolocation) {
		            //์์น ์ ๋ณด๋ฅผ ์ป๊ธฐ
		            navigator.geolocation.getCurrentPosition (function(pos) {
		            var latitude=pos.coords.latitude;   // ์๋
		            var longitude=pos.coords.longitude; // ๊ฒฝ๋
		            alert("Welcome Back!");
					/* location.href = "siMain.do"; */
					location.href = "siMain.do?latitude="+latitude+"&longitude="+longitude;
		            });
		        } else {
		            alert("์ด ๋ธ๋ผ์ฐ์ ์์๋ Geolocation์ด ์ง์๋์ง ์์ต๋๋ค.");
		            history.go(-1);
		        }
		    });
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("๋ก๊ทธ์ธ ์คํจ, ๋ค์ ์๋ํด์ฃผ์ธ์");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == 2 }">
		<script type="text/javascript">
			alert("์ด๋ฉ์ผ ์ธ์ฆ์ ์๋ฃํด์ฃผ์ธ์.");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == -1 }">
		<script type="text/javascript">
			alert("์๋ ์์ด๋ ์๋๋ค. ๋ค์ ํ์ธ ํด์ฃผ์ธ์");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == -2 }">
		<script type="text/javascript">
			alert("์ํธ๊ฐ ๋ค๋ฆ๋๋ค. ๋ค์ ํ์ธ ํด์ฃผ์ธ์");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == -3 }">
		<script type="text/javascript">
			alert("์ ์ง๋ ์์ด๋ ์๋๋ค. ๊ด๋ฆฌ์ ์ฌ์ฌ ์ค์๋๋ค.");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == 4 }">
		<script type="text/javascript">
			alert("๊ด๋ฆฌ์๋ชจ๋๋ก ๋ก๊ทธ์ธ ํ์จ์ต๋๋ค");
			location.href = "masterSiMain.do"
		</script>
	</c:if>

</body>
</html>