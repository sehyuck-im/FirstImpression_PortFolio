<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="../include.jsp"%>
<c:set var="id" value='${sessionScope.id}'></c:set>
<c:set var="nick" value='${sessionScope.nick}'></c:set>
<meta charset="UTF-8">
<style>
caption {
	font-size: 30px;
}

page-section {
	color: black !important;
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
<!-- 채팅 -->
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

		var msg={
				type : "chatHeader",
				nick:$("#nick").val()};
		websocket.send(JSON.stringify(msg));

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
		document.getElementById("unreadCount").innerHTML = msg;
}
</script>
<!-- 채팅 -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<link rel="stylesheet" type="text/css"
	href="${path}/resources/bootstrap/css/bootstrap.watch.css">
<script type="text/javascript"
	src="${path}/resources/bootstrap/js/bootstrap.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
<script src="${path}/resources/layout/js/scripts.js"></script>
<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
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
<header>
	<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3"
		id="mainNav">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="siMain.do">First Impression</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
		
				<ul class="navbar-nav ms-auto my-2 my-lg-0">
				
					<li class="nav-item"><a class="nav-link" href="chatingList.do"><div id="unreadCount">Chat</div></a>
					<input type="hidden" id="nick" value="${id}">
					</li>
						
					<li class="nav-item"><a class="nav-link" href="matching.do">Matching</a></li>
					<li class="nav-item"><a class="nav-link" href="likeList.do">Who
							Like Me</a></li>
					<li class="nav-item"><a class="nav-link"
						href="updateProfileForm.do">Profile</a></li>
					<li class="nav-item"><a class="nav-link"></a></li>
				</ul>
				<div class="btn-group" role="group" aria-label="Button group with nested dropdown">
					<a	class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
						href="#" role="button" aria-haspopup="true" aria-expanded="false">${id }</a>
						<div class="dropdown-menu"
							style="position: absolute; inset: 0px auto auto 0px; margin: 0px; transform: translate(0px, 42px);"
							data-popper-placement="bottom-start">
							<a class="dropdown-item" href="memberUpdateForm.do" style="color: black;">Account</a> 
							<a class="dropdown-item" href="myAppointment.do" style="color: black;">Appointment</a>
							<a class="dropdown-item" href="likeFeed.do" style="color: black;">Like</a>
							<a class="dropdown-item" href="myCard.do" style="color: black;">My Card</a> 
							<a class="dropdown-item" href="myFeed.do" style="color: black;">My Feed</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="signOut.do" style="color: black;">Sign Out</a>
						</div>
					</div>
			</div>
		</div>
	</nav>
</header>
