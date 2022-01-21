<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>💘첫인상 - First Impression</title>

<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />
<script type="text/javascript">
var websocket;//전역변수,여러 function에서 사용
var count;
$(function connect() {
	//서버와 연결						serverip:포트번호		servelet-context에 등록된 이름
	websocket=new WebSocket("wss://${pageContext.request.serverName}:443/chat-ws.do");
	websocket.onopen=Open;
	websocket.onmessage=onMessage;
});
function register() {
	for(i=1;i<=count;i++){
		var msg={
				type : "chatRoomList",
				target:$("#targetUser"+i).val()+","+$("#nickname"+i).val(),
				chatRoomNo:$("#chatRoomNo"+i).val(),
				nick:$("#nick"+i).val(),
				userid:$("#nickname"+i).val()+","+$("#targetUser"+i).val()};
		websocket.send(JSON.stringify(msg));
	}
	}
function Open() {
	count=$('#count').val();
	register();
}
function onMessage(event) {
	var msg= event.data;//메세지는 event의 데이터 속성에 값으로 들어온다
	appendMessage(msg);
}
function appendMessage(msg) {
	for(i=1;i<=count;i++){
	if (msg.includes("<input type='hidden' id='readCount' value='"+$("#chatRoomNo"+i).val()+","+$("#nick"+i).val()+"'>"))
	{
		document.getElementById(i).innerHTML = msg;
	}
	if (msg.includes("<input type='hidden' value='"+$("#chatRoomNo"+i).val()+","+$("#nick"+i).val()+"'><div class="))
	{
		document.getElementById("text"+i).innerHTML = msg;
	}
	}
}
</script>
<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />
<link
	href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic"
	rel="stylesheet" type="text/css" />
<!-- SimpleLightbox plugin CSS-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${path}/resources/bootstrap/css/bootstrap.watch.css">
<script type="text/javascript"
	src="${path}/resources/layout/js/scripts.js"></script>
<link href="${path}/resources/layout/css/styles.css" rel="stylesheet" />
<style type="text/css">
page-section {
	color: black !important;
}
.finalMessage{
height:34px;
overflow:hidden;
}
.card {
	position: relative;
	display: -ms-flexbox;
	display: flex;
	-ms-flex-direction: column;
	flex-direction: column;
	min-width: 0;
	word-wrap: break-word;
	background-color: transparent;
	background-clip: border-box;
	border: 1px solid rgba(255, 255, 255, .2);
	border-radius: .5rem;
	color: black;
}

.list-group-item {
	position: relative;
	display: block;
	padding: 1rem 2rem;
	color: #fff;
	text-decoration: none;
	background-color: transparent;
	border: 0 solid rgba(255, 255, 255, .2)
}
</style>
</head>
<body>
	<header><jsp:include page="../layout/headerchat.jsp"></jsp:include></header>
	<!-- Masthead-->
	<div class="bs-docs-section">
		<div class="row">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="page-section">
				<c:set var="i" value="0" />
				<h2>나를 좋아요 한 채팅</h2>
				<table  style="width: 100%"  class="table table-striped table-hover table-hover">
					<c:if test="${empty chatRooms }">
					<tr align="center">
					<th align="center">채팅이 없습니다</th>
					</tr>
					</c:if>
					<c:if test="${not empty chatRooms }">
					<c:forEach var="chatRoom" items="${chatRooms }">
					<tr>
					<th>
					<c:set var="i" value="${i + 1}" />
					<a class="nav-link" href="chat.do?enterUser1=${chatRoom.enterUser1}&enterUser2=${chatRoom.enterUser2}">${chatRoom.enterUser2}님과의 채팅</a> <div class="finalMessage" id="text${i}">&nbsp;</div>
					<input type="hidden" id="nickname${i}" value="${chatRoom.enterUser1 }">
					<input type="hidden" id="targetUser${i}" value="${chatRoom.enterUser2 }">
					<input type="hidden" id="chatRoomNo${i}" value="${chatRoom.chatRoomNo }">
					<input type="hidden" id="nick${i}" value="${profile.nick}"></th><th><div class="btn btn-info btn-sm" id="${i}"></div></th>
				
					
					
					</tr>
					</c:forEach>
					</c:if>
				</table>
				<h2>약속을 잡아주세요</h2>
				<table  style="width: 100%;" class="table table-striped table-hover table-hover">
					<c:if test="${empty chatRooms2 }">
					<tr align="center">
					<th>채팅이 없습니다</th>
					</tr>
					</c:if>
					<c:if test="${not empty chatRooms2 }">
					<c:forEach var="chatRoom" items="${chatRooms2 }">
					<tr>
					<th>
					<c:set var="i" value="${i + 1}" />
					<a class="nav-link" href="chat.do?enterUser1=${chatRoom.enterUser1}&enterUser2=${chatRoom.enterUser2}">${chatRoom.enterUser2}님과의 채팅</a> <div class="finalMessage" id="text${i}">&nbsp;</div>
					<input type="hidden" id="nickname${i}" value="${chatRoom.enterUser1 }">
					<input type="hidden" id="targetUser${i}" value="${chatRoom.enterUser2 }">
					<input type="hidden" id="chatRoomNo${i}" value="${chatRoom.chatRoomNo }">
					<input type="hidden" id="nick${i}" value="${profile.nick}"></th><th><div class="btn btn-info btn-sm" id="${i}"></div></th>
					
					</tr>
					</c:forEach>
					</c:if>
				</table>
				<input type="number" id="count" value="${i}" hidden="hidden">
				</div>
				
			</div>
			<div class="col-lg-4"></div>
		</div>
	</div>
	<footer><jsp:include page="../layout/footer.jsp"></jsp:include></footer>
</body>
</html>