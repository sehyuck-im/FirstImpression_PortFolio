<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>πμ²«μΈμ - First Impression</title>

<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />
</head>
<body>
	<c:if test="${result == 1 }">
		<script type="text/javascript">
			alert("μ΄λ©μΌμ λ°μ‘ νμμ΅λλ€.");
			location.href = "main.do";
		</script>
	</c:if>
	<c:if test="${result != 1 }">
		<script type="text/javascript">
			alert("μ΄λ©μΌ λ°μ‘ μ€ν¨,"+<br>+"νμ μλ ₯ μ¬ν­μ λ€μ νλ² νμΈν΄μ£ΌμΈμ");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>