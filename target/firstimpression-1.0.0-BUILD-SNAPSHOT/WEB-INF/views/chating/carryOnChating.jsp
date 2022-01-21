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
	<c:if test="${result==1 }">
		<script type="text/javascript">
		    alert("상대방도 좋아요 버튼을 누르면 다음단계 채팅으로 진행됩니다");
			/* location.href = "siMain.do"; */
			location.href = "chatingList.do";
		</script>
	</c:if>
	<c:if test="${result==2 }">
		<script type="text/javascript">
		    alert("다음 단계 채팅으로 진행됩니다");
			/* location.href = "siMain.do"; */
			location.href = "chatingList.do";
		</script>
	</c:if>
	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("등록실패");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>