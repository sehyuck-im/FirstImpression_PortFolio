<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>💘첫인상 - First Impression</title>

<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />
<link rel="stylesheet" type="text/css" href="resources/css/chat.css">
<style type="text/css">
body {
	background-image: linear-gradient(90deg, #33b7e2, #5e62b0, #dc307c) !important;
}
.rounded {
    border-radius: 0.25rem !important;
}
.py-2 {
    padding-top: 1rem !important;
    padding-bottom: 1rem !important;
}
.px-3 {
    padding-right: 2rem !important;
    padding-left: 2rem !important;
}
.bg-light {
    --bs-bg-opacity: 1;
    background-color: rgba(var(--bs-light-rgb), var(--bs-bg-opacity)) !important;
}
</style>
<script type="text/javascript">
var websocket;//전역변수,여러 function에서 사용
var nickname;
$(function() {
	$('#sendBtn').click(function() {
		send();
	});
	//엔터키 눌렀을때 처리
	$('#chatMsg').keypress(function() {
		var keycode=event.keyCode?event.keyCode:event.which;
		if(keycode==13)
			{
				send();
			}
	});
});
$(function connect() {
	//서버와 연결						serverip:포트번호		servelet-context에 등록된 이름
	websocket=new WebSocket("wss://${pageContext.request.serverName}:443/chat-ws.do");
	websocket.onopen=Open;
	websocket.onmessage=onMessage;
}); 
function register() {
	var msg={
			type : "register",
			target:$("#targetUser").val()+","+nickname,
			chatRoomNo:$("#chatRoomNo").val(),
			userid:nickname+","+$("#targetUser").val()};
	websocket.send(JSON.stringify(msg));
	}
function enter() {
	var msg={
			type : "enter",
			from:$("#nickname").val(),
			target:$("#targetUser").val()+","+nickname,
			chatRoomNo:$("#chatRoomNo").val(),
			userid: nickname+","+$("#targetUser").val()};
	websocket.send(JSON.stringify(msg));
	}
function disconnect() {
	websocket.close();
}
function send() {
	var msg={
			type:"chat",
			from:$("#nickname").val(),
			userid: nickname+","+$("#targetUser").val(),
			nick:$("#targetUser").val(),
			chatRoomNo:$("#chatRoomNo").val(),
			target:$("#targetUser").val()+","+nickname,
			message:$('#chatMsg').val()
	};
	websocket.send(JSON.stringify(msg));
	$('#chatMsg').val("");//메세지에 입력한 글 지우기
}
function Open() {
	nickname=$('#nickname').val();//별명 가져오기
	register();
	enter();
	
}
function onMessage(event) {
	var msg= event.data;//메세지는 event의 데이터 속성에 값으로 들어온다
	appendMessage(msg);
}
function appendMessage(msg) {
	$('#chatMessage').append(msg);//메세지 붙이고 줄바꿈
	if (!msg.includes('<br>----여기까지 읽으셨습니다----<br>'))
	{
		var objDiv=document.getElementById('chatMessage');
		//채팅창에 글이 꽉차면 최신길이 하단에 보이게. 이게 없으면 scroll bar를 움직여야 최신글이 보인다
		objDiv.scrollTop = objDiv.scrollHeight;
	}
}
</script>
<style type="text/css">
	#chatMessage { overflow: scroll; }
</style>
</head>
<body>
<header><jsp:include page="../layout/headerchat.jsp"></jsp:include></header>
<div class="container">
 <section class="page-section" id="contact">
<div class="container px-4 px-lg-5">
<div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-lg-8 col-xl-6 text-center">
                        <hr class="divider" />
                        <p class="text-muted mb-5">
                        	<h3>첫인상을 남기실 준비가 되셨나요?</h3>
                        </p>
                    </div>
                </div>
<input type="hidden" id="nickname" value="${chatRoom.enterUser1 }">
<input type="hidden" id="targetUser" value="${chatRoom.enterUser2 }">
<input type="hidden" id="chatRoomNo" value="${chatRoom.chatRoomNo }">
<div class="row gx-4 gx-lg-5 justify-content-center mb-5">
                    <div class="col-lg-6">
<div id="chatMessage" class="form-control" style="height: 30rem; color: black;"></div>
<div class="form-group">
 <div class="input-group mb-3">
      <input type="text" class="form-control" id="chatMsg" aria-label="Recipient's username" aria-describedby="button-addon2" style="color: black;">
      <button class="btn btn-primary" id="sendBtn" type="button" id="button-addon2">✉</button>
    </div>
    </div>
</div>
</div>
</div>
</section>
</div>
<footer><jsp:include page="../layout/footer.jsp"></jsp:include></footer>
</body>
</html>