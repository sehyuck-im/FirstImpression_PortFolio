<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include.jsp"%>
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
			alert("피드 수정 완료!");
			location.href = "siMain.do"
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("입력 실패, 다시 시도해주세요");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>