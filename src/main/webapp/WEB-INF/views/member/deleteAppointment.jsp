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
</head>
<body>
	<c:if test="${result>0 }">
		<script type="text/javascript">
			alert("μ½μ λͺ©λ‘ μ­μ  μλ£");
			location.href = "myAppointment.do";
		</script>
	</c:if>
	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("μ½μ λͺ©λ‘ μ­μ  μ€ν¨");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>