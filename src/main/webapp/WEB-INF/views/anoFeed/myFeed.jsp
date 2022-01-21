<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include.jsp"%>
<c:set value="${profile.nick }" var="UserNick"></c:set>
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
<link rel="stylesheet"
	href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
<style type="text/css">
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
</style>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k8221vnqwi"></script>
	<script type="text/javascript">
	$(document).on("click",".btndel",function() {
		let anNum = $(this).attr('idx');
		var con = confirm("게시글을 삭제하시겠습니까?");
		if (con) {
			location.href = "anoFeedDelete.do?anNum=" + anNum;
		}
	});
	</script>
</head>
<body>
<input type="hidden" value="${UserNick }" id="userNick">
	<header><jsp:include page="../layout/header.jsp"></jsp:include></header>
	<!-- Masthead-->
	<div class="bs-docs-section">
		<div class="row">
			<div class="col-lg-4"></div>
			<div class="col-lg-4 mb-2">
				<div class="page-section mb-2">
					<div id="appendPoint">
					<c:if test="${not empty list }">
						<c:forEach var="anoFeed" items="${list}">
						<c:if test="${anoFeed.anDel ne 'y' }">
							<div class="card mb-3">
								<h3 class="card-header">${anoFeed.anTitle }</h3>
								<div class="card-footer">
									<c:if test="${anoFeed.anCheck eq 'y' }">
										<img src="resources/pic/anonymous.png" alt="anonymous"
											width="50" height="50" class="rounded-circle">
										<span class="badge rounded-pill bg-secondary">익명</span>
									</c:if>
									<c:if test="${anoFeed.anCheck ne 'y'}">
										<a href="userProfile.do?nick=${anoFeed.profile.nick }"
												style="text-decoration: none;"> <c:if
													test="${anoFeed.profile.photo1 eq null }">
													<img src="resources/pic/sample.png" alt="user" width="50"
														height="50" class="rounded-circle">
												</c:if> <c:if test="${anoFeed.profile.photo1 ne null }">
													<img src="resources/profiles/${anoFeed.profile.photo1 }"
														alt="user" width="50" height="50" class="rounded-circle">
												</c:if>
											</a>
									</c:if>

									<c:if test="${anoFeed.likeChk eq 'y' }">
										<a idx="${anoFeed.anNum }" href="javascript:"
											class="heart-click heart_icon${anoFeed.anNum }"><svg
												xmlns="http://www.w3.org/2000/svg" width="16" height="16"
												fill="currentColor" class="bi bi-suit-heart-fill"
												viewBox="0 0 16 16">
														<path
													d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z" />
													</svg></a>
									</c:if>
									<c:if test="${anoFeed.likeChk ne 'y' }">
										<a idx="${anoFeed.anNum }" href="javascript:"
											class="heart-click heart_icon${anoFeed.anNum }"><svg
												xmlns="http://www.w3.org/2000/svg" width="16" height="16"
												fill="currentColor" class="bi bi-suit-heart"
												viewBox="0 0 16 16">
														<path
													d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
													</svg></a>
									</c:if>
									<span id="like${anoFeed.anNum }">${anoFeed.likeCount }</span>
									<span
								class="col-5"> <c:if test="${anoFeed.nick eq UserNick }">
									<a class="btndel btn btn-primary btn-sm mt-1"
												style="float: right;" idx="${anoFeed.anNum }">삭제</a>
									<a href="anoFeedUpdateForm.do?anNum=${anoFeed.anNum }"
										class="btn btn-primary btn-sm mt-1"
										style="text-decoration: none; float: right; margin-right: 5px;">수정</a>
								</c:if>
							</span>
								</div>
								<div class="card-footer">
									<c:if test="${empty anoFeed.hashTag }">
										<span class="badge rounded-pill bg-secondary">설정된 해시태그가
											없습니다</span>
									</c:if>
									<c:if test="${not empty anoFeed.hashTag  }">
										<c:forEach var="hashTag" items="${anoFeed.hashTag }">
											<span class="btn btn-primary btn-sm mt-1">#${hashTag.tag}</span>
										</c:forEach>
									</c:if>
								</div>
								<c:if test="${anoFeed.photo ne null }">
									<img height="auto" id="photo"
										src="resources/feed/${anoFeed.photo}" alt="이미지">
								</c:if>
								<div class="card-body">
									<pre>${ anoFeed.anContent}</pre>
								</div>
								<div id="reply-li${anoFeed.anNum }">
								<div class="card-footer">
									<div id="reply-list${anoFeed.anNum }">
											<div id="replyCount${anoFeed.anNum }">
												<a href="feedDetail.do?anNum=${anoFeed.anNum }"
													class="text-muted" style="text-decoration: none;">댓글
													${anoFeed.replyCount}개 전체보기</a>
											</div>
											<br>
										<c:if test="${not empty anoFeed.reply  }">
											<c:set var="i" value="1"></c:set>
											<c:forEach items="${anoFeed.reply }" var="reply">
												<c:if test="${i < 3}">
												<c:if test="${reply.ref_level eq 0 }">
													<c:if test="${reply.rpCheck eq 'y'}">
														<img src="resources/pic/anonymous.png" alt="anonymous"
															width="30" height="30" class="rounded-circle">
														<span class="text-muted"> 익명 </span>
													</c:if>
													<c:if test="${reply.rpCheck ne 'y'}">
														<a href="userProfile.do?nick=${reply.nick }"
															style="text-decoration: none;"> <img
															src="resources/profiles/${reply.profile.photo1 }"
															alt="user" width="30" height="30" class="rounded-circle">
															<span class="text-muted"> ${reply.nick} </span>
														</a>
													</c:if>
													<div>${reply.replyContent}</div>
													<br>
												<c:set var="i" value="${i+1}"></c:set>
												</c:if>
												</c:if>
											</c:forEach>
										</c:if>
										<c:if test="${empty anoFeed.reply  }">
											<span class="text-muted">댓글이 없습니다.</span>
										</c:if>
									</div>
								</div>
								</div>
								<form id="replyForm${anoFeed.anNum }"
									name="replyForm${anoFeed.anNum }" method="post">
									&nbsp;&nbsp; <input type="hidden" name="nick"
										value="${profile.nick}"> <input
										class="form-check-input mb-1" type="checkbox" name="rpCheck"
										value="y" id="rpCheck${anoFeed.anNum }"> <label
										class="text-muted mb-1" for="rpCheck${anoFeed.anNum }">익명
										🎭</label>
									<div class="input-group" style="margin-left: 2.5%; width: 90%;">
										<input type="text" class="form-control form-control-sm ml-1"
											name="replyContent" id="replyContent${anoFeed.anNum }"
											aria-describedby="rpBtn${anoFeed.anNum }"> <a
											idx="${anoFeed.anNum }"
											class="rpbtn btn btn-primary btn-sm mr-1" href="javascript:"
											id="rpBtn${anoFeed.anNum }">게시</a>
									</div>
								</form>
							</div>
							</c:if>
						</c:forEach>
					</c:if>
					</div>
					<c:if test="${empty list }">
					내 피드가 없습니다
					</c:if>
				</div>
			</div>
			<div class="col-lg-4"></div>
		</div>
	</div>
	<input type="hidden" id="lati" name="lati" value="${lati}">
	<input type="hidden" id="longi" name="longi" value="${longi}">

	<footer><jsp:include page="../layout/footer.jsp"></jsp:include></footer>

	<script>
		var latitude = document.getElementById('lati').value;
		console.log(latitude);
		var longitude = document.getElementById('longi').value;
		console.log(longitude);
		var position = new naver.maps.LatLng(latitude, longitude);

		var mapOptions = {
			center : position,
			zoom : 13
		};

		var map = new naver.maps.Map('map', mapOptions);
		var marker = new naver.maps.Marker({
			position : position,
			map : map
		});
	</script>
</body>
<script type="text/javascript">
	//로그인 한 상태에서 하트를 클릭했을 때 (로그인한 상태인 하트의 <a></a> class명: heart-click)
	$(document).on("click",".heart-click",function() {
					// 게시물 번호(no)를 idx로 전달받아 저장합니다.
					let no = $(this).attr('idx');

					// 빈하트를 눌렀을때
					if ($(this).children('svg').attr('class') == "bi bi-suit-heart") {

						$.ajax({
							url : 'addLike.do',
							type : 'get',
							data : {
								no : no,
							},
							success : function(likeCount) {

								var heart = likeCount;

								// 페이지, 모달창에 하트수 갱신
								$('#like' + no).text(heart);

							},
							error : function() {
								alert('서버 에러');
							}
						});

						// 꽉찬하트로 바꾸기
						$(this)
								.html(
										"<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
						$('.heart_icon' + no)
								.html(
										"<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");

						// 꽉찬 하트를 눌렀을 때
					} else if ($(this).children('svg').attr('class') == "bi bi-suit-heart-fill") {

						$.ajax({
							url : 'removeLike.do',
							type : 'get',
							data : {
								no : no,
							},
							success : function(likeCount) {

								let heart = likeCount;
								// 페이지, 모달창에 하트수 갱신
								$('#like' + no).text(heart);

							},
							error : function() {
								alert('서버 에러');
							}
						});

						// 빈하트로 바꾸기
						$(this)
								.html(
										'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');

						$('.heart_icon' + no)
								.html(
										'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
					}

				});


		$(document).on("click",".rpbtn",function() {
					// 게시물 번호(no)를 idx로 전달받아 저장합니다.
					let no = $(this).attr('idx');
					let rpCheck = $("input[name='rpCheck']:checked").val();
					let replyContent = $('#replyContent' + no).val();
					if (typeof rpCheck == 'undefined' || rpCheck == null
							|| rpCheck == '') {
						rpCheck = "n";
					}
					if (replyContent == " " || replyContent == "" || replyContent == null || replyContent == "  " || replyContent == "    ") {
						alert("댓글에 내용을 입력해주세요");
						return false;
					}
					$.ajax({
								url : 'insertReply.do',
								type : 'post',
								data : {
									no : no,
									rpCheck : rpCheck,
									replyContent : replyContent
								},
								success : function(replyList) {

									$('#replyContent' + no).val('');
									$('#rpCheck' + no).prop("checked",
											false).attr("checked", false)
											.removeAttr("checked");
									let anNum=no;
									// 댓글 목록을 html로 담기
									let listHtml = "<div class='card-footer'>";
									listHtml += "<div id='reply-list"+anNum+"'>";
									listHtml += "<div id='replyCount"+anNum+"'>"
									listHtml += "<a href='feedDetail.do?anNum="+anNum+"' class='text-muted' style='text-decoration: none;'>댓글 "+replyList.length+"개 전체보기</a></div><br>";
									if(replyList==null)
										{
										listHtml += "<span class='text-muted'>댓글이 없습니다.</span>";
										}
									else
										{
										let k=1;
										for ( const i in replyList) {
											let rpNum = replyList[i].rpNum;
											let nick = replyList[i].nick;
											let replyContent = replyList[i].replyContent;
											let photo = replyList[i].profile.photo1;
											let rpCheck = replyList[i].rpCheck;
											let ref = replyList[i].ref;
											let ref_step = replyList[i].ref_step;
											let ref_level = replyList[i].ref_level;
											console.log("rpNum : "+rpNum);
											console.log("nick : "+nick);
											console.log("replyContent : "+replyContent);
											console.log("rpCheck : "+rpCheck);
											console.log("ref : "+ref);
											console.log("ref_step : "+ref_step);
											
											if(k<3)
												{
													if(ref_level == 0)
														{
														if(rpCheck == 'y')
															{
															listHtml += "<img src='resources/pic/anonymous.png' alt='anonymous' width='30' height='30' class='rounded-circle'><span class='text-muted'> 익명 </span>";
															}
														else{
															listHtml += "<a href='userProfile.do?nick="+nick+"' style='text-decoration: none;'>";
															listHtml += "<img src='resources/profiles/"+photo+"' alt='user' width='30' height='30' class='rounded-circle'>";
															listHtml +="<span class='text-muted'>"+ nick +"</span> </a>";
														}
														listHtml +="<div>"+replyContent+"</div><br>";
														k++
														}
												}		
										}
										}
									listHtml += "</div></div>";
									 $("#reply-li"+no).html(listHtml);
									//document.getElementById("reply-li"+anNum).innerHTML = listHtml;

								
								},
								error : function() {
									alert('서버 에러');
								}
							});
				});
$(function() {
	var userNick = $('#userNick').val();
	let index= 1;
	$(window).scroll(function(){
		let $window = $(this);
		let scrollTop = $window.scrollTop();
		let windowHeight = $window.height();
		let documentHeight = $(document).height();
		
		if(scrollTop + windowHeight + 1 >= documentHeight - 500){
			index = index + 10;
			$.ajax({
				url : 'appendmyFeed.do',
				type : 'post',
				data : {
					startNum : index,						
				},
				success : function(list) {
					console.log(list);
					let listHtml = "";
					if(list == null){
						listHtml += "<div>해당 조건의 피드가 없습니다</div>";
					} else {
					for ( const i in list) {
						let anTitle = list[i].anTitle; // 글제목
						let anNum = list[i].anNum; // 글번호
						let anCheck = list[i].anCheck; // 익명체크
						let nick=list[i].nick;
						let proNick = list[i].profile.nick; //글쓴사람
						let photo = list[i].profile.photo1; //  ${anoFeed.profile.photo1 }
						let likeChk = list[i].likeChk;	//${anoFeed.likeChk eq 'y' } 좋아요 체크 
						let likeCount = list[i].likeCount; //${anoFeed.likeCount } 
						let hashTagList = list[i].hashTag; //${empty anoFeed.hashTag } // for문으로 찢기 #${hashTag.tag}
						let anoPhoto = list[i].photo;  //${anoFeed.photo}" 글 사진
						let anContent = list[i].anContent; //${ anoFeed.anContent}
						let replyCount = list[i].replyCount; //${anoFeed.replyCount}
						let replyList = list[i].reply; // ${anoFeed.reply }
						if(list[i].anDel == 'n'){
						listHtml += "<div class='card mb-3'>";
						listHtml += "<h3 class='card-header'>"+anTitle+"</h3>";
						listHtml += "<div class='card-footer'>";
						if(anCheck == 'y'){
							listHtml += "<img src='resources/pic/anonymous.png' alt='anonymous'	width='50' height='50' class='rounded-circle'>";
							listHtml += "<span class='badge rounded-pill bg-secondary'>익명</span>"; 
						} else {
							listHtml += "<a href='userProfile.do?nick="+ proNick+"' style='text-decoration: none;'>";
							if(photo == null){
								listHtml += "<img src='resources/pic/sample.png' alt='user' width='50' height='50' class='rounded-circle'>";
							} else {
								listHtml += "<img src='resources/profiles/"+photo+"' alt='user' width='50' height='50' class='rounded-circle'>"
							}
							listHtml += "</a><span class='btn btn-primary btn-sm mt-1'>"
									+ nick
									+ "</span>";
						}
						if(likeChk == 'y'){
							listHtml += "<a idx='"+anNum+"' href='javascript:' class='heart-click heart_icon"+anNum+"'>";
							listHtml +=	"<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16'	fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'>";
							listHtml += "<path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg></a>";
						} else {
							listHtml += "<a idx='"+anNum+"' href='javascript:' class='heart-click heart_icon"+anNum+"'><svg	xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>";
							listHtml += "<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z'/></svg></a>";
						}
						listHtml += "<span id='like"+anNum+"'>"+likeCount+"</span> <span class='col-5'>";
						if(proNick == userNick) {
							listHtml += "<a class='btndel btn btn-primary btn-sm mt-1' style='float: right;' idx='"+anNum+"'>삭제</a>";
							listHtml += "<a href='anoFeedUpdateForm.do?anNum="+anNum+"' class='btn btn-primary btn-sm mt-1'	style='text-decoration: none; float: right; margin-right: 5px;'>수정</a>";
						}
						listHtml += "	</span></div><div class='card-footer'>";
						if(hashTagList != null) {
							for(const j in hashTagList){ // 
								let tag = hashTagList[j].tag;
								listHtml += "<span class='btn btn-primary btn-sm mt-1'>#"+tag+"</span>&nbsp;";
							}
						}else {
							listHtml += "<span class='badge rounded-pill bg-secondary'>설정된 해시태그가	없습니다</span>";
						}
						listHtml += "</div>";
						if(anoPhoto != null){
							listHtml += "<img height='auto' id='photo' src='resources/feed/"+anoPhoto+"' alt='이미지'>";
						}
						listHtml += "<div class='card-body'> <pre>"+anContent+"</pre></div>";
						listHtml += "<div id='reply-li"+anNum+"'><div class='card-footer'><div id='reply-list"+anNum+"'><div id='replyCount"+anNum+"'>";
						listHtml +=	"<a href='feedDetail.do?anNum="+anNum+"' class='text-muted' style='text-decoration: none;'>댓글"+replyCount+"개 전체보기</a></div><br>";
						if(replyList != null){
							let k = 1;
							for(const j in replyList){
								if(k < 3){
									if(replyList[j].ref_level == 0){
										if(replyList[j].rpCheck == 'y'){
											 listHtml +="<img src='resources/pic/anonymous.png' alt='anonymous'	width='30' height='30' class='rounded-circle'>";
											 listHtml +="<span class='text-muted'>익명 </span>";
										}else {
											listHtml += "<a href='userProfile.do?nick="+replyList[j].nick+"' style='text-decoration: none;'>";
											listHtml += "<img src='resources/profiles/"+replyList[j].profile.photo1+"' alt='user' width='30' height='30' class='rounded-circle'>";
											listHtml += "<span class='text-muted'>"+replyList[j].nick+"</span></a>";
										}
										listHtml += "<div>"+replyList[j].replyContent+"</div><br>";
									}
									k = k +1;
								}
							}
						} else {
							listHtml += "<span class='text-muted'>댓글이 없습니다.</span>";
						}
						listHtml += "</div></div></div>";
						listHtml += "<form id='replyForm"+anNum+"' name='replyForm"+anNum+"' method='post'>&nbsp;&nbsp;";
						listHtml += "<input type='hidden' name='nick' value='"+userNick+"'><input class='form-check-input mb-1' type='checkbox' name='rpCheck' value='y' id='rpCheck"+anNum+"'>";
						listHtml += "<label class='text-muted mb-1' for='rpCheck"+anNum+"'>익명🎭</label>";
						listHtml +=	"<div class='input-group' style='margin-left: 2.5%; width: 90%;'>";
						listHtml +=	"<input type='text' class='form-control form-control-sm ml-1' name='replyContent' id='replyContent"+anNum+"' aria-describedby='rpBtn"+anNum+"'>";
						listHtml +=	"<a	idx='"+anNum+"' class='rpbtn btn btn-primary btn-sm mr-1' href='javascript:' id='rpBtn"+anNum+"'>게시</a>";
						listHtml +=	"</div></form></div>";
						}
					}
					}
					$('#appendPoint').append(listHtml);
				},					
				error : function() {
					alert("서버 에러");
				}
		});
			
	}
});
});
</script>
</html>