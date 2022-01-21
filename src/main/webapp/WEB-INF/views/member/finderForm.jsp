<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>💘첫인상 - First Impression</title>

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
						<legend>아이디 찾기</legend>
						<div class="form-group row">
							<label for="staticEmail" class="col-sm-2 col-form-label  mt-4">ID
								/ 아이디</label>
							<div class="col-sm-10  mt-4">
								<input type="text" readonly="readonly"
									class="form-control-plaintext" id="foundId"> <small
									id="idHelp" class="form-text text-muted">정보를 입력 후 Find
									ID를 눌러주세요</small>
							</div>
						</div>
						<div class="form-group">
							<label for="email" class="form-label mt-2">Email address</label>
							<input type="email" class="form-control" id="idEmail"
								aria-describedby="emailHelp" title="example@example.com"
								placeholder="example@email.com"> <small id="emailHelp"
								class="form-text text-muted"> 가입한 이메일 주소를 입력 하세요</small>
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1" class="form-label mt-2">이름
								/ Full Name</label> <input type="text" class="form-control" id="idName"
								placeholder="이름을 입력하세요">
						</div>
						<div class="form-group mt-4 mb-3" align="center">
							<button class="btn btn-primary" id="findIdBtn">Find
								ID</button>
						</div>
					</fieldset>
					<fieldset>
						<legend>비밀번호 찾기</legend>
						<div class="form-group mt-2" align="center">
							<input type="text" readonly="readonly"
								class="form-control-plaintext" id="passMsg">
						</div>
						<div class="form-group">
							<label for="email" class="form-label mt-4">Email address</label>
							<input type="email" class="form-control" id="email"
								aria-describedby="emailHelp" placeholder="Enter email">
							<small id="emailHelp" class="form-text text-muted"> 가입한
								이메일 주소를 입력 하세요</small>
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1" class="form-label mt-2">아이디
								/ ID</label> <input type="text" class="form-control" id="id" name="id"
								placeholder="아이디를 입력하세요">
						</div>
						<div class="form-group mt-4" align="center">
							<button class="btn btn-primary" id="findPassBtn">Find
								Password</button>
						</div>
					</fieldset>
					<div class="form-group mt-4" align="center">
							<a href="signInForm.do">아이디 또는 비밀번호를 찾으셨나요?</a>
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
			$('#foundId').val('입력하신 정보를 확인해 주세요');
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
				alert('서버에러, 잠시 후 이용 해주세요');
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
					msg = "입력하신 이메일로 새로운 비밀번호를 보내드렸으니 확인 해주시기 바랍니다.";
				} else if (msg == '2'){
				msg = "입력하신 정보와 일치하는 회원정보가 없습니다.";
				}
				$('#passMsg').val(msg);
			},
			error : function() {
				alert('서버에러, 잠시 후 이용 해주세요');
			}
		});
	});
</script>
</html>