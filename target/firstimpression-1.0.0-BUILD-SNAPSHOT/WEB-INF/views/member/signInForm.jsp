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

<style type="text/css">
.mainContainer {
	margin-top: 100px;
	padding: 50px;
}
</style>
</head>
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
					<form action="signIn.do" method="post">
						<fieldset>
							<legend>Sign In !</legend>
							<div class="form-group">
								<label for="id" class="form-label mt-4">아이디</label> <input
									type="text" class="form-control col-2" id="id" name="id"
									required="required" autofocus="autofocus">
							</div>
							<div class="form-group">
								<label for="password" class="form-label mt-2">암호</label> <input
									type="password" class="form-control" id="password"
									name="password" required="required">
							</div>
							<div class="form-group mt-4" align="center">
								<input type="submit" class="btn btn-primary" value="Sign In">
							</div>
						</fieldset>
					</form>
					<label class="mt-4"></label>
				</div>
				<span><a href="finderForm.do" >아이디 찾기 & 비밀번호 찾기</a> </span>
			</div>
		</div>
	</section>
</body>

</html>