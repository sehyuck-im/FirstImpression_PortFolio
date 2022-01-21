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
	<c:if test="${result == 1 }">
		<script type="text/javascript">
		    $(function() {  
		        // Geolocation API에 액세스할 수 있는지를 확인
		        if (navigator.geolocation) {
		            //위치 정보를 얻기
		            navigator.geolocation.getCurrentPosition (function(pos) {
		            var latitude=pos.coords.latitude;   // 위도
		            var longitude=pos.coords.longitude; // 경도
		            alert("Welcome Back!");
					/* location.href = "siMain.do"; */
					location.href = "siMain.do?latitude="+latitude+"&longitude="+longitude;
		            });
		        } else {
		            alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.");
		            history.go(-1);
		        }
		    });
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("로그인 실패, 다시 시도해주세요");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == 2 }">
		<script type="text/javascript">
			alert("이메일 인증을 완료해주세요.");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == -1 }">
		<script type="text/javascript">
			alert("없는 아이디 입니다. 다시 확인 해주세요");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == -2 }">
		<script type="text/javascript">
			alert("암호가 다릅니다. 다시 확인 해주세요");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == -3 }">
		<script type="text/javascript">
			alert("정지된 아이디 입니다. 관리자 심사 중입니다.");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == 4 }">
		<script type="text/javascript">
			alert("관리자모드로 로그인 하셨습니다");
			location.href = "masterSiMain.do"
		</script>
	</c:if>

</body>
</html>