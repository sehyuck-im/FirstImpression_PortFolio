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
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	function chk() {
		if (frm.name.value.length < 2) {
			alert("이름은 2자 이상 입력해주세요");
			frm.name.focus();
			return false;
		}
		if (frm.password.value != '') {
			if (frm.password.value != frm.password2.value) {
				alert("암호와 암호 확인 다릅니다");
				frm.password.focus(); // 커서
				frm.password.value = ""; // 암호 데이터 지우기 
				return false; // action하지 마라
			}
			var pass = frm.password.value;
			var passwdReg = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,20}$/);
			if (!passwdReg.test(pass)) {
				alert("비밀번호는 공백을 제외한 영문 대/소문자 숫자를 모두 포함한 8자리 이상 20자리 이하로 입력해주세요");
				frm.password.focus();
				return false;
			}
			if (pass.search(/\s/) != -1) {
				alert("비밀번호는 공백 없이 입력해주세요");
				frm.password.focus();
				return false;
			}
		}
		if (frm.roadAddress.value == '' && frm.detailAddress.value == '') {

		}
		if ($("#emailCodeInput").is("disabled", false)) {
			if (frm.emailDoubleChk.value == ''
					|| frm.emailDoubleChk.value == "false") {
				alert("이메일 인증을 완료해주세요");
				frm.emailCodeInput.focus();
				return false;
			}
		}
	}
	function execPostCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postCode').value = data.zonecode;
				document.getElementById("roadAddress").value = roadAddr;
			}
		}).open();
	}
</script>
<style type="text/css">
.mainContainer {
	margin-top: 75px;
	padding: 50px;
}

.pass_re1 {
	color: green;
	display: none;
	font-weight: bold;
}

.pass_re2 {
	color: red;
	display: none;
	font-weight: bold;
}
.lvpass_re1 {
	color: green;
	display: none;
	font-weight: bold;
}

.lvpass_re2 {
	color: red;
	display: none;
	font-weight: bold;
}

.email_re1 {
	color: green;
	display: none;
}

.email_re2 {
	color: red;
	display: none;
}

.email_re3 {
	color: red;
	display: none;
}

.emailChk_re1 {
	color: green;
	display: none;
}

.emailChk_re2 {
	color: red;
	display: none;
}
</style>
</head>
<body>
	<header><jsp:include page="../layout/header.jsp"></jsp:include></header>
	<div class="container">
		<section class="mainContainer">
			<form action="memberUpdate.do" method="post" id="frm"
				onsubmit="return chk()">
				<fieldset class="mb-3 mt-3">
					<legend>회원 정보 수정</legend>
					<div class="form-group row mt-3">
						<label class="col-sm-2 col-form-label">아이디 / ID</label>
						<div class="col-sm-10">
							<input type="text" class="form-control-plaintext" id="id"
								name="id" disabled="disabled" aria-describedby="button-addon2"
								value="${member.id }">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">별명 / Nick Name</label>
						<div class="col-sm-10">
							<input type="text" class="form-control-plaintext" id="nick"
								name="nick" disabled="disabled" aria-describedby="button-addon2"
								value="${member.nick }">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">생일 / Date of Birth</label>
						<div class="col-sm-10">
							<input type="text" class="form-control-plaintext" id="birth"
								name="birth" disabled="disabled"
								aria-describedby="button-addon2" value="${member.birth }">
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="form-label mt-2">이름 / Full Name</label> <input
							type="text" class="form-control" id="name" name="name"
							aria-describedby="nameHelp" placeholder="이름"
							value="${member.name }" required="required"> <small
							id="emailHelp" class="form-text text-muted"></small>
					</div>

					<div class="form-group">
						<label for="phone" class="form-label mt-2">휴대폰 / Phone
							Number</label> <input type="tel" class="form-control" id="phone"
							name="phone" placeholder="010-1111-1111" value="${member.phone }"
							required="required">
					</div>

					<div class="form-group">
						<label for="password" class="form-label mt-2">암호 변경 /
							Password</label> <input type="password" class="form-control"
							id="password" name="password" placeholder="Password"
							aria-describedby="passHelp"> <small id="passHelp"
							class="form-text text-muted">암호는 영문 대/소문자, 숫자를 모두 포함한 8자리
							이상 20자리 이하만 사용 가능합니다.</small>
					</div>
					<div class="pass_re1">암호와 암호확인이 일치합니다</div>
					<div class="pass_re2">암호와 암호확인이 서로 다릅니다.</div>
					<div class="passValid"></div>
					<div class="form-group">
						<label for="password2" class="form-label mt-2">암호 확인 /
							Check Password</label> <input type="password" class="form-control mb-2"
							id="password2" name="password2" placeholder="Password">
					</div>

					<div class="form-group row mt-2">
						<label for="staticEmail" class="col-sm-2 col-form-label">Email</label>
						<div class="col-sm-10">
							<input type="text" disabled="disabled"
								class="form-control-plaintext" id="staticEmail"
								value="${member.email }">
						</div>
					</div>

					<div class="form-group">
						<label for="email" class="form-label mt-2">Email 변경</label> <input
							type="email" class="form-control" id="email" name="email"
							aria-describedby="emailHelp" placeholder="example@email.com"
							aria-describedby="emailHelp"> <small id="emailHelp"
							class="form-text text-muted">이메일은 비밀번호 찾기 및 인증에 사용되오니 유효한
							이메일을 입력해주세요.</small>
					</div>
					<div class="email_re1">사용 가능한 이메일 입니다.</div>
					<div class="email_re2">이미 사용중인 이메일 입니다.</div>
					<div class="email_re3">사용 할 수 없는 이메일 입니다.</div>

					<div class="form-group">
						<label class="form-label mt-1"></label>
						<div class="input-group">
							<input class="form-control" id="emailCodeInput" type="text"
								name="emailCodeInput" placeholder="인증번호를 입력해주세요"
								disabled="disabled"> <span class="btn btn-primary"
								id="emailChk">인증하기</span>
						</div>
						<div class="point successEmailChk"></div>
						<input type="hidden" id="emailDoubleChk" name="emailDoubleChk"
							value="" />
					</div>
					<div class="form-group row mt-3">
						<label class="col-sm-2 col-form-label">현재 주소 </label>
						<div class="col-sm-10">
							<input type="text" class="form-control-plaintext" id="birth"
								name="birth" readonly="readonly"
								aria-describedby="button-addon2" value="${member.address }">
						</div>
					</div>

					<div class="form-group">
						<label class="form-label mt-2">새로운 주소 / Address</label>
						<div class="input-group">
							<input class="form-control" style="width: 40%; display: inline;"
								placeholder="우편번호" name="postCode" id="postCode" type="text"
								readonly="readonly">
							<button type="button" class="btn btn-primary" id="addressFinder"
								onclick="execPostCode();">우편번호 찾기</button>
						</div>
					</div>
					<div class="form-group">
						<input class="form-control" placeholder="도로명 주소"
							name="roadAddress" id="roadAddress" type="text"
							readonly="readonly" />
					</div>
					<div class="form-group">
						<input class="form-control" placeholder="상세주소"
							name="detailAddress" id="detailAddress" type="text" />
					</div>

					<div align="center" style="margin-top: 20px;">
						<button type="submit" class="btn btn-primary">계속</button>
					</div>
				</fieldset>
			</form>
			<div>
				<a id="leaveBtn" class="btn btn-link">회원 탈퇴</a>
				<div class="leaveCheck" style="display: none;">
					<form action="deleteMember.do" method="post">
						<div class="form-group">
							<label for="password" class="form-label mt-2">암호 /
								Password</label> <input type="password" class="form-control" id="lvPass"
								name="lvPass" placeholder="Password" aria-describedby="passHelp">
						</div>
						<div class="form-group">
							<label for="password2" class="form-label mt-2">암호 확인 /
								Check Password</label> <input type="password" class="form-control mb-2"
								id="lvPass2" name="lvPass2" placeholder="Password">
						</div>
						<small id="" class="form-text text-muted"></small>
						<div class="form-group" align="center">
							<input type="submit" class="btn btn-dark" value="Leave!">
						</div>
					</form>
				</div>
			</div>
		</section>
	</div>
	<footer><jsp:include page="../layout/footer.jsp"></jsp:include></footer>
</body>
<script type="text/javascript">
	$('#password2').on("propertychange change keyup paste input", function() {
		var password2 = $('#password2').val(); // password에 입력되는 값
		var password = $('#password').val();
		var data = {
			password : password,
			password2 : password2
		} // '컨트롤에 넘길 데이터 이름' : '데이터(.input에 입력되는 값)'

		$.ajax({
			type : "post",
			url : "passChk.do",
			data : data,
			success : function(result) {

				if (result != 'fail') {
					$('.pass_re1').css("display", "inline");
					$('.pass_re2').css("display", "none");
				} else {
					$('.pass_re2').css("display", "inline");
					$('.pass_re1').css("display", "none");
				}
			}// success 종료
		}); // ajax 종료	
	});
	var code = "";
	$("#emailChk").click(function() {
		var email = $("#email").val();
		$.ajax({
			type : "GET",
			url : "mailChk.do?email=" + email,
			cache : false,
			success : function(data) {
				if (data == "error") {
					alert("이메일 주소가 올바르지 않습니다. 유효한 이메일 주소를 입력해주세요.");
					$("#emailCodeInput").attr("autofocus", true);
					$(".successEmailChk").text("유효한 이메일 주소를 입력해주세요.");
					$(".successEmailChk").css("color", "red");
				} else {
					alert("인증번호 발송이 완료되었습니다.\n입력한 이메일에서 인증번호 확인을 해주십시오.");
					$("#emailCodeInput").attr("disabled", false);
					$(".successEmailChk").text("인증번호를 입력한 뒤 이메일 인증을 눌러주십시오.");
					$(".successEmailChk").css("color", "green");
					code = data;
				}
			}
		});
	});
	$("#emailCodeInput")
			.on(
					"propertychange chagne keyup paste input",
					function() {
						if ($("#emailCodeInput").val() == code) {
							$(".successEmailChk").text("인증번호가 일치합니다.");
							$(".successEmailChk").css("color", "green");
							$("#emailDoubleChk").val("true");
							$("#sm_email2").attr("disabled", true);
							//$("#sm_email").attr("disabled",true);
						} else {
							$(".successEmailChk").text(
									"인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
							$(".successEmailChk").css("color", "red");
							$("#emailDoubleChk").val("false");
							$("#sm_email2").attr("autofocus", true);
						}
					});
	$("#leaveBtn").click(function() {
		let con = confirm("정말 탈퇴하시겠습니까?");
		if(con){
			$(".leaveCheck").css("display", "block");
		}
	});
	$('#lvPass2').on("propertychange change keyup paste input", function() {
		var password2 = $('#lvPass2').val(); // password에 입력되는 값
		var password = $('#lvPass').val();
		var data = {
			password : password,
			password2 : password2
		} // '컨트롤에 넘길 데이터 이름' : '데이터(.input에 입력되는 값)'

		$.ajax({
			type : "post",
			url : "passChk.do",
			data : data,
			success : function(result) {

				if (result != 'fail') {
					$('.lvpass_re1').css("display", "inline");
					$('.lvpass_re2').css("display", "none");
				} else {
					$('.lvpass_re2').css("display", "inline");
					$('.lvpass_re1').css("display", "none");
				}
			}// success 종료
		}); // ajax 종료	
	});
	
</script>
</html>