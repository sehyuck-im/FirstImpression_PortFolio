<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>๐์ฒซ์ธ์ - First Impression</title>

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
var websocket;//์ ์ญ๋ณ์,์ฌ๋ฌ function์์ ์ฌ์ฉ
var nickname;
$(function() {
	$('#sendBtn').click(function() {
		send();
	});
	//์ํฐํค ๋๋ ์๋ ์ฒ๋ฆฌ
	$('#chatMsg').keypress(function() {
		var keycode=event.keyCode?event.keyCode:event.which;
		if(keycode==13)
			{
				send();
			}
	});
});
$(function connect() {
	//์๋ฒ์ ์ฐ๊ฒฐ						serverip:ํฌํธ๋ฒํธ		servelet-context์ ๋ฑ๋ก๋ ์ด๋ฆ
	websocket=new WebSocket("ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/chat-ws.do");
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
	$('#chatMsg').val("");//๋ฉ์ธ์ง์ ์๋ ฅํ ๊ธ ์ง์ฐ๊ธฐ
}
function Open() {
	nickname=$('#nickname').val();//๋ณ๋ช ๊ฐ์ ธ์ค๊ธฐ
	register();
	enter();
	
}
function onMessage(event) {
	var msg= event.data;//๋ฉ์ธ์ง๋ event์ ๋ฐ์ดํฐ ์์ฑ์ ๊ฐ์ผ๋ก ๋ค์ด์จ๋ค
	appendMessage(msg);
}
function appendMessage(msg) {
	$('#chatMessage').append(msg);//๋ฉ์ธ์ง ๋ถ์ด๊ณ  ์ค๋ฐ๊ฟ
	if (!msg.includes('<br>----์ฌ๊ธฐ๊น์ง ์ฝ์ผ์จ์ต๋๋ค----<br>'))
	{
		var objDiv=document.getElementById('chatMessage');
		//์ฑํ์ฐฝ์ ๊ธ์ด ๊ฝ์ฐจ๋ฉด ์ต์ ๊ธธ์ด ํ๋จ์ ๋ณด์ด๊ฒ. ์ด๊ฒ ์์ผ๋ฉด scroll bar๋ฅผ ์์ง์ฌ์ผ ์ต์ ๊ธ์ด ๋ณด์ธ๋ค
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
                        	<h3>์ฒซ์ธ์์ ๋จ๊ธฐ์ค ์ค๋น๊ฐ ๋์จ๋์?</h3>
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
      <button class="btn btn-primary" id="sendBtn" type="button" id="button-addon2">โ</button>
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