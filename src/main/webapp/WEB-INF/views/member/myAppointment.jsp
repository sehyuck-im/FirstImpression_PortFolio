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
	<header><jsp:include page="../layout/header.jsp"></jsp:include></header>
	<!-- Masthead-->
	<div class="bs-docs-section">
		<div class="row">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="page-section">

				<h2>내 약속</h2>
				<table  style="width: 100%"  class="table table-striped table-hover table-hover">
					<c:if test="${empty list }">
					<tr align="center">
					<th align="center">약속이 없습니다</th>
					</tr>
					</c:if>
					<c:if test="${not empty list }">
					<c:forEach var="appointment" items="${list }">
					<tr>
					<th>
						<a href="userProfile.do?nick=${appointment.profile.nick }"> <img
											src="resources/profiles/${appointment.profile.photo1 }"
											alt="user" width="50" height="50" class="rounded-circle"></a>
											<br>
						${appointment.profile.nick }님과의 약속
					</th>
					<th>
					 약속 날짜 
					 	<br>
					 	 ${appointment.appointmentdate}
					</th>
					<th>
					 약속 시간 
					 	<br>
					  ${appointment.appointmentTime}
					</th>
						<th>
					 약속 장소 
					 	<br>
					  ${appointment.location}
					</th>
					</tr>
					</c:forEach>
					</c:if>
				</table>
				
				<h2>내 과거 약속</h2>
				<table  style="width: 100%"  class="table table-striped table-hover table-hover">
					<c:if test="${empty list2 }">
					<tr align="center">
					<th align="center">약속이 없습니다</th>
					</tr>
					</c:if>
					<c:if test="${not empty list2 }">
					<c:forEach var="appointment" items="${list2 }">
					<tr>
					<th>
						<a href="userProfile.do?nick=${appointment.profile.nick }"> <img
											src="resources/profiles/${appointment.profile.photo1 }"
											alt="user" width="50" height="50" class="rounded-circle"></a>
							<br>${appointment.profile.nick }님과의 약속
					</th>
					<th>
					 약속 날짜 	<br> ${appointment.appointmentdate}
					</th>
					<th>
					 약속 시간 	<br> ${appointment.appointmentTime}
					</th>
						<th>
					 약속 장소 	<br> ${appointment.location}
					</th>
					<th>
					<a href="deleteAppointment.do?apNum=${appointment.apNum}" class="btn btn-primary btn-sm mt-1">삭제</a>
					</th>
					</tr>
					</c:forEach>
					</c:if>
				</table>
				
				
				</div>
				
			</div>
			<div class="col-lg-4"></div>
		</div>
	</div>
	<footer><jsp:include page="../layout/footer.jsp"></jsp:include></footer>
</body>
</html>