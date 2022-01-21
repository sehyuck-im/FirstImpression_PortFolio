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
		var now = new Date();
		var year = now.getFullYear();
		var age = year - frm.birth.value.substr(0, 4) + 1;
		if (age < 20) {
			alert("미성년자는 회원가입할 수 없습니다.")
			return false;
		}
		if (frm.id.value.length > 4 && frm.id.value.length < 13) {
			for (var i = 0; i < frm.id.value.length; i++) {
				ch = frm.id.value.charAt(i)
				if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')
						&& !(ch >= 'A' && ch <= 'Z')) {
					alert("아이디는 영문 대소문자, 숫자만 입력가능합니다.")
					frm.id.focus();
					frm.id.value = "";
					return false;
				}
			}
		} else {
			alert("아이디는 5자 이상, 12자 이하로 입력해주세요")
			frm.id.focus();
			return false;
		}
		if (frm.id.value.indexOf(" ") >= 0) {
			alert("아이디에 공백을 사용할 수 없습니다.")
			frm.id.focus();
			frm.id.value = "";
			return false;
		}
		if (frm.nick.value.length > 1 && frm.id.value.length < 13) {
			var pattern = /[^(가-힣a-zA-Z)]/;
			if (pattern.test(frm.nick.value)) {
				alert("닉네임은 영문 대소문자, 한글만 입력 가능합니다.")
				frm.nick.focus();
				return false;
			}

		} else {
			alert("닉네임는 2자 이상, 12자 이하의 영문 대소문자, 한글만 입력가능합니다.");
			frm.nick.focus();
			return false;
		}
		if (frm.nick.value.indexOf(" ") >= 0) {
			alert("닉네임에 공백을 사용할 수 없습니다.")
			frm.nick.focus();
			frm.nick.value = "";
			return false;
		}
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
		if(!$('.email_re1').css("display", "inline")){
			alert("사용할 수 없는 이메일 입니다 다른 이메일로 다시 가입해주세요");
			return false;
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
	margin-top: 25px;
	padding: 50px;
}

.id_re1 {
	color: green;
	display: none;
}
/* 중복아이디 존재하는 경우 */
.id_re2 {
	color: red;
	display: none;
}

.id_re3 {
	color: red;
	display: none;
}

.nick_re1 {
	color: green;
	display: none;
}
/* 중복닉네임 존재하는 경우 */
.nick_re2 {
	color: red;
	display: none;
}

.nick_re3 {
	color: red;
	display: none;
}

.pass_re1 {
	color: green;
	display: none;
	font-weight: bold;
}
/* 중복닉네임 존재하는 경우 */
.pass_re2 {
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
</style>
</head>
<body>
	<div class="container">
		<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
			<div class="container-fluid">
				<a class="navbar-brand" href="main.do">First Impression</a>
			</div>
		</nav>
		<section class="mainContainer">
			<form action="naverSignUp.do" method="post" id="frm"
				onsubmit="return chk()">
				<input type="hidden" name="name" value="${member.name }"> <input
					type="hidden" name="phone" value="${member.phone }"> <input
					type="hidden" name="birth" value="${member.birth }"> <input
					type="hidden" name="email" value="${member.email }">
				<fieldset>
					<legend>네이버로 회원가입</legend>
					<div class="form-group">
						<label for="name" class="form-label mt-4">이름 / Full Name</label> <input
							type="text" class="form-control" id="name" name="name"
							placeholder="이름" value="${member.name }" required="required"
							disabled="disabled">
					</div>

					<div class="form-group">
						<label for="phone" class="form-label mt-2">휴대폰 / Phone
							Number</label> <input type="tel" class="form-control" id="phone"
							pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}" name="phone"
							placeholder="010-1111-1111" value="${member.phone }"
							disabled="disabled" required="required">
					</div>

					<div class="form-group">
						<label class="form-label mt-2">아이디 / ID</label>
						<div class="form-group">
							<div class="input-group mb-2">
								<input type="text" class="form-control" id="id" name="id"
									placeholder="4자이상 12자 이하의 영문 대/소문자, 또는 숫자 조합을 입력하세요">
							</div>
							<div class="id_re1">사용 가능한 아이디 입니다.</div>
							<div class="id_re2">이미 있는 아이디 입니다.</div>
							<div class="id_re3">사용할 수 없는 아이디 입니다.</div>
						</div>
					</div>

					<div class="form-group">
						<label class="form-label mt-2">별명 / Nick Name</label>
						<div class="form-group">
							<div class="input-group mb-2">
								<input type="text" class="form-control" id="nick" name="nick"
									placeholder="2자 이상 12자 이하의 영문 또는 한글을 입력하세요">
							</div>
							<div class="nick_re1">사용 가능한 닉네임 입니다.</div>
							<div class="nick_re2">이미 존재하는 닉네임 입니다.</div>
							<div class="nick_re3">사용할 수 없는 닉네임 입니다.</div>
						</div>
					</div>

					<div class="form-group">
						<label for="password" class="form-label mt-2">암호 /
							Password</label> <input type="password" class="form-control"
							id="password" name="password" placeholder="Password"
							aria-describedby="passHelp" required="required"> <small
							id="passHelp" class="form-text text-muted">암호는 영문 대/소문자,
							숫자를 모두 포함한 8자리 이상 20자리 이하만 사용 가능합니다.</small>
					</div>
					<div class="pass_re1">암호와 암호확인이 일치합니다</div>
					<div class="pass_re2">암호와 암호확인이 서로 다릅니다.</div>
					<div class="passValid"></div>
					<div class="form-group">
						<label for="password2" class="form-label mt-2">암호확인 /
							Check Password</label> <input type="password" class="form-control"
							id="password2" name="password2" placeholder="Password"
							required="required">
					</div>
					<div class="form-group">
						<label for="birth" class="form-label mt-2">생일 / Date of
							Birth</label> <input type="date" class="form-control" id="birth"
							name="birth" required="required" value="${member.birth }"
							disabled="disabled">
					</div>

					<div class="form-group">
						<label for="email" class="form-label mt-2">Email address</label> <input
							type="email" class="form-control" id="email" name="email"
							aria-describedby="emailHelp" value="${member.email }"
							disabled="disabled" placeholder="example@email.com">
					</div>
					<div class="email_re1">사용 가능한 이메일 입니다.</div>
					<div class="email_re2">이미 사용중인 이메일 입니다.</div>
					<div class="email_re3">사용 할 수 없는 이메일 입니다.</div>
					<div class="form-group">
						<label class="form-label mt-2">주소 / Address</label>
						<div class="input-group">
							<input class="form-control" style="width: 40%; display: inline;"
								placeholder="우편번호" name="postCode" id="postCode" type="text"
								readonly="readonly">
							<button type="button" class="btn btn-primary"
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
							name="detailAddress" id="detailAddress" type="text"
							required="required" />
					</div>

					<div align="center" style="margin-top: 20px;">
						<button type="submit" class="btn btn-primary">계속</button>
					</div>
				</fieldset>
			</form>
			<a href="signInForm.do">이미 회원이신가요?</a>
		</section>
	</div>


</body>
<script type="text/javascript">
	//아이디 중복검사
	$('#id').on("propertychange change keyup paste input", function() {
		var id = $('#id').val(); // id에 입력되는 값
		var data = {
			id : id
		} // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

		$.ajax({
			type : "post",
			url : "idChk.do",
			data : data,
			success : function(result) {
				if (result == 'success') {
					$('.id_re1').css("display", "inline");
					$('.id_re2').css("display", "none");
					$('.id_re3').css("display", "none");
				} else if (result == 'fail1') {
					$('.id_re1').css("display", "none");
					$('.id_re2').css("display", "inline");
					$('.id_re3').css("display", "none");
				} else {
					$('.id_re1').css("display", "none");
					$('.id_re2').css("display", "none");
					$('.id_re3').css("display", "inline");
				}
			}// success 종료
		}); // ajax 종료	
	});
	$('#nick').on("propertychange change keyup paste input", function() {

		var nick = $('#nick').val(); // id에 입력되는 값
		var data = {
			nick : nick
		} // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

		$.ajax({
			type : "post",
			url : "nChk.do",
			data : data,
			success : function(result) {
				if (result == 'success') {
					$('.nick_re1').css("display", "inline");
					$('.nick_re2').css("display", "none");
					$('.nick_re3').css("display", "none");
				} else if (result == 'fail1') {
					$('.nick_re1').css("display", "none");
					$('.nick_re2').css("display", "inline");
					$('.nick_re3').css("display", "none");
				} else {
					$('.nick_re1').css("display", "none");
					$('.nick_re2').css("display", "none");
					$('.nick_re3').css("display", "inline");
				}
			}// success 종료
		}); // ajax 종료	
	});
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
	$('#email').on("propertychange change keyup paste input", function() {
		var email = $('#email').val();
		var data = {
			email : email,
		} // '컨트롤에 넘길 데이터 이름' : '데이터(.input에 입력되는 값)'

		$.ajax({
			type : "post",
			url : "mailChk2.do",
			data : data,
			success : function(result) {
				if (result == 'success') {
					$('.email_re1').css("display", "inline");
					$('.email_re2').css("display", "none");
					$('.email_re3').css("display", "none");
					$('#emailChk').css("display", "block")
				} else if (result == 'fail') {
					$('.email_re2').css("display", "inline");
					$('.email_re1').css("display", "none");
					$('.email_re3').css("display", "none");
					$('#emailChk').css("display", "none");
				} else if (result == 'fail2') {
					$('.email_re2').css("display", "none");
					$('.email_re1').css("display", "none");
					$('.email_re3').css("display", "inline");
					$('#emailChk').css("display", "none");
				}
			}
		});
	});
</script>

</html>