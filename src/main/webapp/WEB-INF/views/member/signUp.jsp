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
			alert("νμκ°μ μ±κ³΅, νμ ν©λλ€.");
			location.href = "main.do";
		</script>
	</c:if>
	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("νμκ°μμ μ€ν¨νμ΅λλ€");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result==-1 }">
		<script type="text/javascript">
			alert("μ€λ³΅λ μμ΄λ μλλ€");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result==-2 }">
		<script type="text/javascript">
			alert("μ€λ³΅λ λλ€μ μλλ€");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>