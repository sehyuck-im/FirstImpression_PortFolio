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

.swiper {
  width: 100%;
  height: auto;
}
.swiper-button-prev, .swiper-button-next{
	color : white;
}
div.aspect_4_3 { width: 400px; height: 300px; }
</style>
<script type="text/javascript">
window.onload = function() {
	  var divs = document.querySelectorAll('li > div');
	  for (var i = 0; i < divs.length; ++i) {
	    var div = divs[i];
	    var divAspect = div.offsetHeight / div.offsetWidth;
	    div.style.overflow = 'hidden';
	    
	    var img = div.querySelector('img');
	    var imgAspect = img.height / img.width;

	    if (imgAspect <= divAspect) {
	      // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
	      var imgWidthActual = div.offsetHeight / imgAspect;
	      var imgWidthToBe = div.offsetHeight / divAspect;
	      var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2)
	      img.style.cssText = 'width: auto; height: 100%; margin-left: '
	                      + marginLeft + 'px;'
	    } else {
	      // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
	      img.style.cssText = 'width: 100%; height: auto; margin-left: 0;';
	    }
	  }
};  
</script>
</head>
<body>
	<header><jsp:include page="../layout/header.jsp"></jsp:include></header>
	<!-- Masthead-->
	<div class="bs-docs-section">
		<div class="row">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="page-section">
					<c:if test="${profile eq null}">
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">회원님 반경 2km에 매칭된 사람이 없습니다</h4>
								<h6 class="card-subtitle mb-2 text-muted">문제원인</h6>
								<p class="card-text">매칭정보를 수정해보세요</p>
								<div></div>
								<a href="updatePosition.do" class="card-link">근처에 회원이 없을 수 있습니다</a><br><br> <a
									href="updatePreferenceForm.do" class="card-link">매칭조건을 수정해야 될 수 있습니다</a> <br><br>
								<a href="updateProfileForm.do" class="card-link">프로필 사진이 존재해야 매칭을 할 수 있습니다.</a>	
							</div>
						</div>
					</c:if>
					<c:if test="${profile != null }">
						<div class="card mb-3">
							<h3 class="card-header">${profile.nick }님과매칭되었습니다.</h3>
							<span><a href="reportuser.do?nick=${profile.nick }" class="btn btn-primary btn-sm mt-1" style="float: right;">신고🚨</a></span>
							<c:if test="${profile.photo1 ne null }">
								<!-- Slider main container -->
								<div class="swiper">
									<!-- Additional required wrapper -->
									<div class="swiper-wrapper aspect_4_3">
										<!-- Slides -->
										<div class="swiper-slide aspect_4_3">
											<img width="100%" height="auto" id="photo"
												src="resources/profiles/${profile.photo1}" alt="이미지">
										</div>
										<div class="swiper-slide aspect_4_3">
											<img width="100%" height="auto" id="photo"
												src="resources/profiles/${profile.photo2}" alt="이미지">
										</div>
										<div class="swiper-slide aspect_4_3">
											<img width="100%" height="auto" id="photo"
												src="resources/profiles/${profile.photo3}" alt="이미지">
										</div>
									</div>
									<div class="swiper-button-prev"></div>
									<div class="swiper-button-next"></div>
								</div>
							</c:if>


							<c:if test="${profile.photo1 eq null }">
								<div class="card-body">
									<p>등록된 사진이 없습니다.</p>
								</div>
							</c:if>
							<div class="card-body">
								<h6 class="card-subtitle text-muted">${profile.age }
									<c:if test="${profile.gender ne 'none' }">
										<span>${gender }</span>
									</c:if>
								</h6>
								<br>
								<pre>${profile.intro }</pre>
							</div>
							<div class="card-footer">
								<c:if test="${empty itList }">
									<span class="badge rounded-pill bg-secondary">관심사가 없습니다</span>
								</c:if>
								<c:if test="${not empty itList }">
									<c:forEach var="itList" items="${itList }">
										<span class="btn btn-primary btn-sm mt-1">#${itList.tag
											}</span>
									</c:forEach>
								</c:if>
							</div>
							<div class="card-footer">
									<p class="card-text">위치 당신으로부터 ${profile.distance} km</p>
							</div>
							<div class="card-footer text-muted">${profile.signInTime }전</div>
						</div>
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">매칭 결정</h4>
								<p class="card-text">매칭되신 회원님이 마음에 드십니까?</p>
								<a href="matching.do" class="card-link">다시 매칭</a> <a
									href="addMatching.do?nick=${profile.nick}" class="card-link">좋아요</a>
							</div>
						</div>
					</c:if>
				</div>
			</div>
			<div class="col-lg-4"></div>
		</div>
	</div>
	<footer><jsp:include page="../layout/footer.jsp"></jsp:include></footer>
</body>
<script type="text/javascript">
const swiper = new Swiper('.swiper', {
	  // Optional parameters
	  direction: 'horizontal',
	  loop: true,

	  // If we need pagination
	  pagination: {
	    el: '.swiper-pagination',
	  },

	  // Navigation arrows
	  navigation: {
	    nextEl: '.swiper-button-next',
	    prevEl: '.swiper-button-prev',
	  },

	  // And if we need scrollbar
	  scrollbar: {
	    el: '.swiper-scrollbar',
	  },
	});

</script>
</html>