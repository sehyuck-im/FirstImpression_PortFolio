<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>๐์ฒซ์ธ์ - First Impression</title>

<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />
<script src="http://code.jquery.com/jquery-1.11.0.js"></script>
<script>
	var latitude;
	var longitude;
	$(function() {
		// Geolocation API์ ์ก์ธ์คํ  ์ ์๋์ง๋ฅผ ํ์ธ
		if (navigator.geolocation) {
			//์์น ์ ๋ณด๋ฅผ ์ป๊ธฐ
			navigator.geolocation.getCurrentPosition(function(pos) {
				latitude = pos.coords.latitude; // ์๋
				longitude = pos.coords.longitude; // ๊ฒฝ๋
			});
		} else {
			alert("์ด ๋ธ๋ผ์ฐ์ ์์๋ Geolocation์ด ์ง์๋์ง ์์ต๋๋ค.")
		}
	});
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
<script type="text/javascript">
	var naverLogin = new naver.LoginWithNaverId({
		clientId : "jhrCGshIm617Y79NkqOy",
		callbackUrl : "http://localhost:8080/firstimpression/signUpForm.do",
		isPopup : false, /* ํ์์ ํตํ ์ฐ๋์ฒ๋ฆฌ ์ฌ๋ถ */
		loginButton : {
			color : "green",
			type : 3,
			height : 60
		}
	/* ๋ก๊ทธ์ธ ๋ฒํผ์ ํ์์ ์ง์  */
	});

	/* ์ค์ ์ ๋ณด๋ฅผ ์ด๊ธฐํํ๊ณ  ์ฐ๋์ ์ค๋น */
	naverLogin.init();
</script>
<style type="text/css">
.btn-naver {
	color: #000;
	background-color: #03C75A;
	border-color: #03C75A;
}

.btn-primary {
	color: #fff;
	background-color: #e83283;
	border-color: #e83283;
}

.btn-naver {
	color: #000;
	background-color: #03C75A;
	border-color: #03C75A;
	font-size: 0.85rem;
	font-weight: 700;
	text-transform: uppercase;
	border: none;
	border-radius: 10rem;
}

.naverText {
	font-family: "Merriweather", -apple-system, BlinkMacSystemFont,
		"Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif,
		"Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol",
		"Noto Color Emoji";
	color: #000;
}

hr.divider {
	height: 0.2rem;
	max-width: 3.25rem;
	margin: 1.5rem auto;
	background-color: #e83283;
	opacity: 1;
}

.btn-primary {
	color: #fff;
	background-color: #e83283;
	border-color: #e83283;
}

.btn-primary:hover {
	color: #fff;
	background-color: #c52b6f;
	border-color: #ba2869;
}

.btn-naver:hover {
	color: #000;
	background-color: #03A014;
	border-color: #03A014;
	font-size: 0.85rem;
	font-weight: 700;
	text-transform: uppercase;
	border: none;
	border-radius: 10rem;
}

.text-muted { -
	-bs-text-opacity: 1;
	color: rgba(255, 255, 255, .7) !important
}

.form-control {
	display: block;
	width: 100%;
	padding: .75rem 1.5rem;
	font-size: 1rem;
	font-weight: 400;
	line-height: 1.5;
	color: #fff;
	background-color: transparent;
	background-clip: padding-box;
	border: 1px solid rgba(255, 255, 255, .4);
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border-radius: .5rem;
	transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out
}

.form-control::-webkit-date-and-time-value {
	height: 1.5em;
}

.form-control::-webkit-input-placeholder {
	color: rgba(255, 255, 255, .7);
	opacity: 1
}

.form-control::-moz-placeholder {
	color: rgba(255, 255, 255, .7);
	opacity: 1
}

.form-control:-ms-input-placeholder {
	color: rgba(255, 255, 255, .7);
	opacity: 1
}

.form-control::-ms-input-placeholder {
	color: rgba(255, 255, 255, .7);
	opacity: 1
}

.form-control::placeholder {
	color: rgba(255, 255, 255, .7);
	opacity: 1
}
</style>

</head>
<body id="page-top">
	<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3"
		id="mainNav">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="#page-top">First Impression</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ms-auto my-2 my-lg-0">
					<li class="nav-item"><a class="nav-link" href="#portfolio">About</a></li>
					<li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
					<li class="nav-item"><a class="" href=""
						style="margin-left: 5px;"></a></li>
				</ul>
				<span><a class="btn btn-primary btn-sm" href="signInForm.do">Sign
						In</a></span>
			</div>
		</div>
	</nav>
	<!-- Masthead-->
	<header class="masthead">
		<div class="container px-4 px-lg-5 h-100">
			<div
				class="row gx-4 gx-lg-5 h-100 align-items-center justify-content-center text-center">
				<div class="col-lg-8 align-self-end">
					<img class="img-fluid" alt=""
						src="${path}/resources/design/maingif.gif">
					<hr class="divider" />
				</div>
				<div class="col-lg-8 align-self-baseline">
					<p class="text-white-75 mb-5" align="left">
						์ฒซ์ธ์์ด๋ <br> # ์ฒซ์ธ์์ ์ํต์ ์์์ด๋ค. <br> # ์ผ๊ด์ฑ์ ์ ์งํ๋ ค๋ ์ฌ๋ฆฌ ๋๋ฌธ์ <br>
						&nbsp;&nbsp; ์ผ๋จ ํ์ฑ๋ ์ฒซ์ธ์์ ์ฝ๊ฒ ๋ฐ๋์ง ์๋๋ค.
					</p>
					<a class="btn btn-primary btn-xl" href="#join">ํ์๊ฐ์</a>
				</div>
			</div>
		</div>
	</header>
	<!-- Portfolio-->
	<div id="portfolio">
		<div class="container-fluid p-0">
			<div class="row g-0">
				<div class="col-lg-3 col-sm-6">
					<img class="img-fluid"
						src="${path}/resources/design/1.png"
						alt="..." />
				</div>
				<div class="col-lg-3 col-sm-6">
					<img class="img-fluid"
						src="${path}/resources/design/2.png"
						alt="" />
				</div>
				<div class="col-lg-3 col-sm-6">
					<img class="img-fluid"
						src="${path}/resources/design/3.png"
						alt="" />
				</div>
				<div class="col-lg-3 col-sm-6">
					<img class="img-fluid"
						src="${path}/resources/design/4.png"
						alt="" />
				</div>
			</div>
		</div>
	</div>
	<!-- Contact-->
	<section class="page-section" id="join">
		<div class="container px-4 px-lg-5">
			<div class="row gx-4 gx-lg-5 justify-content-center">
				<div class="col-lg-8 col-xl-6 text-center">
					<h2 class="mt-0">Let's Join Us!</h2>
					<hr class="divider" />
					<p class="text-muted mb-5">์ฒซ์ธ์์ ๋จ๊ธฐ์ค ์ค๋น๊ฐ ๋์จ๋์?</p>
				</div>
			</div>
			<div class="row gx-4 gx-lg-5 justify-content-center mb-5">
				<div class="col-lg-6">
					<form id="signfrm" action="signUpForm.do" method="post">
						<!-- Name input-->
						<div class="form-group">
							<label for="name" class="form-label mt-4">์ด๋ฆ / Full Name</label>
							<input type="text" class="form-control" id="name" name="name"
								aria-describedby="nameHelp" placeholder="์ด๋ฆ" required="required">
							<small id="emailHelp" class="form-text text-muted"></small>
						</div>
						<!-- Email address input-->
						<div class="form-group">
							<label for="email" class="form-label mt-2">์ด๋ฉ์ผ / Email
								address</label> <input type="email" class="form-control" id="email"
								name="email" required="required" title="example@example.com"
								placeholder="example@email.com">
						</div>
						<!-- Phone number input-->
						<div class="form-group">
							<label for="phone" class="form-label mt-2">ํด๋ํฐ / Phone
								Number</label> <input type="tel" class="form-control" id="phone"
								name="phone" placeholder="010-1234-5678"
								pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}"
								title="(010)-4566-7890 or (010)-456-7890" required="required">
						</div>
						<div class="d-grid mt-3">
							<button class="btn btn-primary btn-xl" id="submitButton"
								type="submit" value="์ด๋ฉ์ผ๋ก ์์ํ๊ธฐ">์ด๋ฉ์ผ๋ก ์์ํ๊ธฐ</button>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</section>
	<section class="page-section" id="contact">
		<div class="container px-4 px-lg-5">
			<div class="row gx-4 gx-lg-5 justify-content-center">
				<div class="col-lg-8 col-xl-6 text-center">
					<h2 class="mt-0">Let's Get In Touch!</h2>
					<hr class="divider" />
					<p class="text-muted mb-5">
						๋ฌธ์ ์ฌํญ์ด ์์ผ์๊ฑฐ๋ First Impression์ ๋ํ์ฌ ์๊ฒฌ ์์ผ์๋ฉด <br>FirstImpressionMain@gmail.com
						ํน์ ์๋์ ํ์์ ์ด์ฉํด์ฃผ์ธ์.
					</p>
				</div>
			</div>
			<div class="row gx-4 gx-lg-5 justify-content-center mb-5">
				<div class="col-lg-6">
					<form id="contactForm" method="post" name="contactForm"
						action="contactEmail.do">
						<div class="form-group">
							<label for="cntName" class="form-label mt-4">์ด๋ฆ / Full
								Name * ํ์ ์ฌํญ</label> <input type="text" class="form-control" id="cntName"
								name="cntName" aria-describedby="nameHelp" placeholder="์ด๋ฆ"
								required="required"> <small id="emailHelp"
								class="form-text text-muted"></small>
						</div>
						<!-- Email address input-->
						<div class="form-group">
							<label for="cntEmail" class="form-label mt-2">์ด๋ฉ์ผ / Email
								address * </label> <input type="email" class="form-control" id="cntEmail"
								name="cntEmail" required="required" title="example@example.com"
								placeholder="example@email.com">
						</div>
						<!-- Phone number input-->
						<div class="form-group">
							<label for="phone" class="form-label mt-2">ํด๋ํฐ / Phone
								Number</label> <input type="tel" class="form-control" id="cntPhone"
								name="cntPhone" placeholder="010-1234-5678"
								
								title="(010)-4566-7890 or (010)-456-7890">
						</div>
						<div class="form-group">
							<label for="message" class="form-label mt-2">Message *</label>
							<textarea class="form-control" id="cntMsg" name="cntMsg"
								placeholder="Enter your message here..." style="height: 10rem"
								required="required"></textarea>
						</div>
						<div class="d-grid mt-3">
							<button class="btn btn-primary btn-xl" id="submitButton"
								type="submit">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer-->
	<footer class="bg-light py-5">
		<div class="container px-4 px-lg-5">
			<div class="small text-center text-muted">Copyright &copy; 2021
				- Company Name</div>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- SimpleLightbox plugin JS-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
	<script src="${path}/resources/layout/js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>