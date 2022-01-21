<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>💘첫인상 - First Impression</title>

<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />
</head>
<body>
	<c:if test="${result == 1 }">
		<script type="text/javascript">
			alert("이메일을 발송 하였습니다.");
			location.href = "main.do";
		</script>
	</c:if>
	<c:if test="${result != 1 }">
		<script type="text/javascript">
			alert("이메일 발송 실패,"+<br>+"필수 입력 사항을 다시 한번 확인해주세요");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>