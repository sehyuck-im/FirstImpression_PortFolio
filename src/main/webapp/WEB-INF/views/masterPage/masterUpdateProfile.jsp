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
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("프로필 변경 실패, 다시 시도해주세요");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == 1 }">
		<script type="text/javascript">
			alert("관리자의 프로필을 변경 하였습니다.");
			location.href = "masterSiMain.do"
		</script>
	</c:if>
	
</body>
</html>