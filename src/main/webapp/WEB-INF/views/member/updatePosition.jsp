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
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k8221vnqwi"></script>
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
					<div class="card mb-3">
						<h3 class="card-header">${profile.nick }님의 위치입니다</h3>
					<div class="card-footer">
							<p class="card-text">현재위치가 아니십니까?</p>
							<div id="map" style="width:100%;height:200px;"></div>
							
							<a href="positionUpdate.do" class="btn btn-primary btn-sm mt-1">현재위치 업데이트</a>
						</div>
				</div>
			
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
var longitude = document.getElementById('longi').value;
var position = new naver.maps.LatLng(latitude, longitude);

var mapOptions = {
    center: position,
    zoom: 13
};

var map = new naver.maps.Map('map', mapOptions);
var marker = new naver.maps.Marker({
    position: position,
    map: map
});

</script>

</body>
</html>