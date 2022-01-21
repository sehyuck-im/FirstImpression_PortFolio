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
	<c:if test="${result>0 }">
		<script type="text/javascript">
			alert("회원가입 성공, 환영 합니다.");
			location.href = "main.do";
		</script>
	</c:if>
	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("회원가입에 실패했습니다");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result==-1 }">
		<script type="text/javascript">
			alert("중복된 아이디 입니다");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result==-2 }">
		<script type="text/javascript">
			alert("중복된 닉네임 입니다");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>