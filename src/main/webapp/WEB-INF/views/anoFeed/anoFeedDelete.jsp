<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>πμ²«μΈμ - First Impression</title>

<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />
<script src="http://code.jquery.com/jquery-1.11.0.js"></script>
</head>
<body>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("μ­μ  μ€ν¨, λ€μ μλν΄μ£ΌμΈμ");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == 1 }">
		<script type="text/javascript">
			alert("κΈμ μ­μ νμ΅λλ€");
			location.href = "siMain.do"
		</script>
	</c:if>
	
</body>
</html>