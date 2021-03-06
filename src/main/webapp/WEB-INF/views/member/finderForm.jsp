<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ðì²«ì¸ì - First Impression</title>

<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />
</head>
<style type="text/css">
.mainContainer {
	margin-top: 100px;
	padding: 50px;
}
</style>
<body>
	<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3"
		id="mainNav">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="main.do">First Impression</a>
		</div>
	</nav>
	<section class="mainContainer bgRedLighten4">
		<div class="container px-4 px-lg-5">
			<div class="row gx-4 gx-lg-5 justify-content-center mb-5">
				<div class="col-lg-6">
					<fieldset>
						<legend>ìì´ë ì°¾ê¸°</legend>
						<div class="form-group row">
							<label for="staticEmail" class="col-sm-2 col-form-label  mt-4">ID
								/ ìì´ë</label>
							<div class="col-sm-10  mt-4">
								<input type="text" readonly="readonly"
									class="form-control-plaintext" id="foundId"> <small
									id="idHelp" class="form-text text-muted">ì ë³´ë¥¼ ìë ¥ í Find
									IDë¥¼ ëë¬ì£¼ì¸ì</small>
							</div>
						</div>
						<div class="form-group">
							<label for="email" class="form-label mt-2">Email address</label>
							<input type="email" class="form-control" id="idEmail"
								aria-describedby="emailHelp" title="example@example.com"
								placeholder="example@email.com"> <small id="emailHelp"
								class="form-text text-muted"> ê°ìí ì´ë©ì¼ ì£¼ìë¥¼ ìë ¥ íì¸ì</small>
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1" class="form-label mt-2">ì´ë¦
								/ Full Name</label> <input type="text" class="form-control" id="idName"
								placeholder="ì´ë¦ì ìë ¥íì¸ì">
						</div>
						<div class="form-group mt-4 mb-3" align="center">
							<button class="btn btn-primary" id="findIdBtn">Find
								ID</button>
						</div>
					</fieldset>
					<fieldset>
						<legend>ë¹ë°ë²í¸ ì°¾ê¸°</legend>
						<div class="form-group mt-2" align="center">
							<input type="text" readonly="readonly"
								class="form-control-plaintext" id="passMsg">
						</div>
						<div class="form-group">
							<label for="email" class="form-label mt-4">Email address</label>
							<input type="email" class="form-control" id="email"
								aria-describedby="emailHelp" placeholder="Enter email">
							<small id="emailHelp" class="form-text text-muted"> ê°ìí
								ì´ë©ì¼ ì£¼ìë¥¼ ìë ¥ íì¸ì</small>
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1" class="form-label mt-2">ìì´ë
								/ ID</label> <input type="text" class="form-control" id="id" name="id"
								placeholder="ìì´ëë¥¼ ìë ¥íì¸ì">
						</div>
						<div class="form-group mt-4" align="center">
							<button class="btn btn-primary" id="findPassBtn">Find
								Password</button>
						</div>
					</fieldset>
					<div class="form-group mt-4" align="center">
							<a href="signInForm.do">ìì´ë ëë ë¹ë°ë²í¸ë¥¼ ì°¾ì¼ì¨ëì?</a>
						</div>
					<label class="mt-4"></label>
				</div>
			</div>
		</div>
	</section>
</body>
<script type="text/javascript">
	$('#findIdBtn').click(function() {
		let name = $('#idName').val();
		let email = $('#idEmail').val();
		if (name == null || email == null || name == "" || email == ""){
			$('#foundId').val('ìë ¥íì  ì ë³´ë¥¼ íì¸í´ ì£¼ì¸ì');
		}
		$.ajax({
			url : 'idFinder.do',
			type : 'post',
			data : {
				name : name,
				email : email,
			},
			success : function(msg) {
				$('#foundId').val(msg);
			},
			error : function() {
				alert('ìë²ìë¬, ì ì í ì´ì© í´ì£¼ì¸ì');
			}
		});
	});
	$('#findPassBtn').click(function() {
		let id = $('#id').val();
		let email = $('#email').val();
		$.ajax({
			url : 'passFinder.do',
			type : 'post',
			data : {
				id : id,
				email : email,
			},
			success : function(msg) {
				if (msg == '1') {
					msg = "ìë ¥íì  ì´ë©ì¼ë¡ ìë¡ì´ ë¹ë°ë²í¸ë¥¼ ë³´ë´ëë ¸ì¼ë íì¸ í´ì£¼ìê¸° ë°ëëë¤.";
				} else if (msg == '2'){
				msg = "ìë ¥íì  ì ë³´ì ì¼ì¹íë íìì ë³´ê° ììµëë¤.";
				}
				$('#passMsg').val(msg);
			},
			error : function() {
				alert('ìë²ìë¬, ì ì í ì´ì© í´ì£¼ì¸ì');
			}
		});
	});
</script>
</html>