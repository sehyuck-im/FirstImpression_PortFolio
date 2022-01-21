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
</head>
<body>
	<c:if test="${result == 1 }">
		<script type="text/javascript">
			alert("회원 탈퇴 성공");
			location.href = "main.do";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("탈퇴 실패, 다시 시도하세요");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == -1 }">
		<script type="text/javascript">
			alert("비밀번호가 틀립니다.");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>