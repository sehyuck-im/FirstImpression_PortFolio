<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>πμ²«μΈμ - First Impression</title>

<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	function chk() {
		var now = new Date();
		var year = now.getFullYear();
		var age = year - frm.birth.value.substr(0,4) + 1;
		if (age < 20 ){
			alert("λ―Έμ±λμλ νμκ°μν  μ μμ΅λλ€.")
			return false;
		}
		if (frm.id.value.length > 4 && frm.id.value.length < 13){
			for (var i = 0; i < frm.id.value.length; i++) {
	            ch = frm.id.value.charAt(i)
	            if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
	                alert("μμ΄λλ μλ¬Έ λμλ¬Έμ, μ«μλ§ μλ ₯κ°λ₯ν©λλ€.")
	                frm.id.focus();
	                frm.id.value="";
	                return false;
	            }
	        }
		} else {
			alert("μμ΄λλ 5μ μ΄μ, 12μ μ΄νλ‘ μλ ₯ν΄μ£ΌμΈμ")
			frm.id.focus();
			return false;
		}
		if (frm.id.value.indexOf(" ") >= 0) {
            alert("μμ΄λμ κ³΅λ°±μ μ¬μ©ν  μ μμ΅λλ€.")
            frm.id.focus();
            frm.id.value="";
            return false;
        }
		if (frm.nick.value.length > 1 && frm.id.value.length < 13){
	    	var pattern =  /[^(κ°-ν£a-zA-Z)]/;
	        if(pattern.test(frm.nick.value)) {
	    		alert("λλ€μμ μλ¬Έ λμλ¬Έμ, νκΈλ§ μλ ₯ κ°λ₯ν©λλ€.")
	    		frm.nick.focus();
	            return false;
	        }
	    	        
	    }else {
        	alert("λλ€μλ 2μ μ΄μ, 12μ μ΄νμ μλ¬Έ λμλ¬Έμ, νκΈλ§ μλ ₯κ°λ₯ν©λλ€.");
            frm.nick.focus();
            return false;
		}
		if (frm.nick.value.indexOf(" ") >= 0) {
            alert("λλ€μμ κ³΅λ°±μ μ¬μ©ν  μ μμ΅λλ€.")
            frm.nick.focus();
            frm.nick.value="";
            return false;
        }
		if (frm.password.value != frm.password2.value) {
			alert("μνΈμ μνΈ νμΈ λ€λ¦λλ€");
			frm.password.focus(); // μ»€μ
			frm.password.value = ""; // μνΈ λ°μ΄ν° μ§μ°κΈ° 
			return false; // actionνμ§ λ§λΌ
		}
		var pass = frm.password.value;
		var passwdReg = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,20}$/);
		if (!passwdReg.test(pass)) {
			alert("λΉλ°λ²νΈλ κ³΅λ°±μ μ μΈν μλ¬Έ λ/μλ¬Έμ μ«μλ₯Ό λͺ¨λ ν¬ν¨ν 8μλ¦¬ μ΄μ 20μλ¦¬ μ΄νλ‘ μλ ₯ν΄μ£ΌμΈμ");
			frm.password.focus();
			return false;
		}
		if(pass.search(/\s/)!= -1) {
			alert("λΉλ°λ²νΈλ κ³΅λ°± μμ΄ μλ ₯ν΄μ£ΌμΈμ");
			frm.password.focus();
			return false;
		}
	}
	
	function execPostCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// νμμμ κ²μκ²°κ³Ό ν­λͺ©μ ν΄λ¦­νμλ μ€νν  μ½λλ₯Ό μμ±νλ λΆλΆ.

				// λλ‘λͺ μ£Όμμ λΈμΆ κ·μΉμ λ°λΌ μ£Όμλ₯Ό νμνλ€.
				// λ΄λ €μ€λ λ³μκ° κ°μ΄ μλ κ²½μ°μ κ³΅λ°±('')κ°μ κ°μ§λ―λ‘, μ΄λ₯Ό μ°Έκ³ νμ¬ λΆκΈ° νλ€.
				var roadAddr = data.roadAddress; // λλ‘λͺ μ£Όμ λ³μ
				var extraRoadAddr = ''; // μ°Έκ³  ν­λͺ© λ³μ

				// λ²μ λλͺμ΄ μμ κ²½μ° μΆκ°νλ€. (λ²μ λ¦¬λ μ μΈ)
				// λ²μ λμ κ²½μ° λ§μ§λ§ λ¬Έμκ° "λ/λ‘/κ°"λ‘ λλλ€.
				if (data.bname !== '' && /[λ|λ‘|κ°]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// κ±΄λ¬Όλͺμ΄ μκ³ , κ³΅λμ£ΌνμΌ κ²½μ° μΆκ°νλ€.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// νμν  μ°Έκ³ ν­λͺ©μ΄ μμ κ²½μ°, κ΄νΈκΉμ§ μΆκ°ν μ΅μ’ λ¬Έμμ΄μ λ§λ λ€.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}

				// μ°νΈλ²νΈμ μ£Όμ μ λ³΄λ₯Ό ν΄λΉ νλμ λ£λλ€.
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
/* μ€λ³΅μμ΄λ μ‘΄μ¬νλ κ²½μ° */
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
/* μ€λ³΅λλ€μ μ‘΄μ¬νλ κ²½μ° */
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
/* μ€λ³΅λλ€μ μ‘΄μ¬νλ κ²½μ° */
.pass_re2 {
	color: red;
	display: none;
	font-weight: bold;
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
				<input type="hidden" name="name" value="${member.name }">
				<input type="hidden" name="phone" value="${member.phone }">
				<input type="hidden" name="birth" value="${member.birth }">
				<input type="hidden" name="email" value="${member.email }">
				<fieldset>
					<legend>λ€μ΄λ²λ‘ νμκ°μ</legend>
					<div class="form-group">
						<label for="name" class="form-label mt-4">μ΄λ¦ / Full Name</label> <input
							type="text" class="form-control" id="name" name="name"
							placeholder="μ΄λ¦" value="${member.name }" required="required" disabled="disabled">
					</div>

					<div class="form-group">
						<label for="phone" class="form-label mt-2">ν΄λν° / Phone
							Number</label> <input type="tel" class="form-control" id="phone"
							pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}" name="phone"
							placeholder="010-1111-1111" value="${member.phone }" disabled="disabled"
							required="required">
					</div>

					<div class="form-group">
						<label class="form-label mt-2">μμ΄λ / ID</label>
						<div class="form-group">
							<div class="input-group mb-2">
								<input type="text" class="form-control" id="id" name="id"
									placeholder="4μμ΄μ 12μ μ΄νμ μλ¬Έ λ/μλ¬Έμ, λλ μ«μ μ‘°ν©μ μλ ₯νμΈμ">
							</div>
							<div class="id_re1">μ¬μ© κ°λ₯ν μμ΄λ μλλ€.</div>
							<div class="id_re2">μ΄λ―Έ μλ μμ΄λ μλλ€.</div>
							<div class="id_re3">μ¬μ©ν  μ μλ μμ΄λ μλλ€.</div>
						</div> 
					</div>

					<div class="form-group">
						<label class="form-label mt-2">λ³λͺ / Nick Name</label>
						<div class="form-group">
							<div class="input-group mb-2">
								<input type="text" class="form-control" id="nick" name="nick"
									placeholder="2μ μ΄μ 12μ μ΄νμ μλ¬Έ λλ νκΈμ μλ ₯νμΈμ">
							</div>
							<div class="nick_re1">μ¬μ© κ°λ₯ν λλ€μ μλλ€.</div>
							<div class="nick_re2">μ΄λ―Έ μ‘΄μ¬νλ λλ€μ μλλ€.</div>
							<div class="nick_re3">μ¬μ©ν  μ μλ λλ€μ μλλ€.</div>
						</div>
					</div>

					<div class="form-group">
						<label for="password" class="form-label mt-2">μνΈ /
							Password</label> <input type="password" class="form-control"
							id="password" name="password" placeholder="Password"
							aria-describedby="passHelp" required="required"> <small
							id="passHelp" class="form-text text-muted">μνΈλ μλ¬Έ λ/μλ¬Έμ,
							μ«μλ₯Ό λͺ¨λ ν¬ν¨ν 8μλ¦¬ μ΄μ 20μλ¦¬ μ΄νλ§ μ¬μ© κ°λ₯ν©λλ€.</small>
					</div>
					<div class="pass_re1">μνΈμ μνΈνμΈμ΄ μΌμΉν©λλ€</div>
					<div class="pass_re2">μνΈμ μνΈνμΈμ΄ μλ‘ λ€λ¦λλ€.</div>
					<div class="passValid"></div>
					<div class="form-group">
						<label for="password2" class="form-label mt-2">μνΈνμΈ /
							Check Password</label> <input type="password" class="form-control"
							id="password2" name="password2" placeholder="Password"
							required="required">
					</div>
					<div class="form-group">
						<label for="birth" class="form-label mt-2">μμΌ / Date of
							Birth</label> <input type="date" class="form-control" id="birth"
							name="birth" required="required" value="${member.birth }" disabled="disabled">
					</div>

					<div class="form-group">
						<label for="email" class="form-label mt-2">Email address</label> <input
							type="email" class="form-control" id="email" name="email"
							aria-describedby="emailHelp" value="${member.email }" disabled="disabled"
							placeholder="example@email.com">
					</div>

					<div class="form-group">
						<label class="form-label mt-2">μ£Όμ / Address</label>
						<div class="input-group">
							<input class="form-control" style="width: 40%; display: inline;"
								placeholder="μ°νΈλ²νΈ" name="postCode" id="postCode" type="text"
								readonly="readonly">
							<button type="button" class="btn btn-primary"
								onclick="execPostCode();">μ°νΈλ²νΈ μ°ΎκΈ°</button>
						</div>
					</div>
					<div class="form-group">
						<input class="form-control" placeholder="λλ‘λͺ μ£Όμ"
							name="roadAddress" id="roadAddress" type="text"
							readonly="readonly" />
					</div>
					<div class="form-group">
						<input class="form-control" placeholder="μμΈμ£Όμ"
							name="detailAddress" id="detailAddress" type="text"
							required="required" />
					</div>

					<div align="center" style="margin-top: 20px;">
						<button type="submit" class="btn btn-primary">κ³μ</button>
					</div>
				</fieldset>
			</form>
			<a href="signInForm.do">μ΄λ―Έ νμμ΄μ κ°μ?</a>
		</section>
	</div>


</body>
<script type="text/javascript">
	//μμ΄λ μ€λ³΅κ²μ¬
	$('#id').on("propertychange change keyup paste input", function() {
		var id = $('#id').val(); // idμ μλ ₯λλ κ°
		var data = {
			id : id
		} // 'μ»¨νΈλ‘€μ λκΈΈ λ°μ΄ν° μ΄λ¦' : 'λ°μ΄ν°(.id_inputμ μλ ₯λλ κ°)'

		$.ajax({
			type : "post",
			url : "idChk.do",
			data : data,
			success : function(result) {
				 if(result == 'success'){
						$('.id_re1').css("display","inline");
						$('.id_re2').css("display", "none");
						$('.id_re3').css("display", "none");
					} else if(result == 'fail1'){
						$('.id_re1').css("display", "none");
						$('.id_re2').css("display","inline");
						$('.id_re3').css("display", "none");
					} else {
						$('.id_re1').css("display", "none");
						$('.id_re2').css("display", "none");
						$('.id_re3').css("display", "inline");
					}
			}// success μ’λ£
		}); // ajax μ’λ£	
	});
	$('#nick').on("propertychange change keyup paste input", function() {

		var nick = $('#nick').val(); // idμ μλ ₯λλ κ°
		var data = {
			nick : nick
		} // 'μ»¨νΈλ‘€μ λκΈΈ λ°μ΄ν° μ΄λ¦' : 'λ°μ΄ν°(.id_inputμ μλ ₯λλ κ°)'

		$.ajax({
			type : "post",
			url : "nChk.do",
			data : data,
			success : function(result) {
				if(result == 'success'){
					$('.nick_re1').css("display","inline");
					$('.nick_re2').css("display", "none");
					$('.nick_re3').css("display", "none");
				} else if(result == 'fail1'){
					$('.nick_re1').css("display", "none");
					$('.nick_re2').css("display","inline");
					$('.nick_re3').css("display", "none");
				} else {
					$('.nick_re1').css("display", "none");
					$('.nick_re2').css("display", "none");
					$('.nick_re3').css("display", "inline");
				}
			}// success μ’λ£
		}); // ajax μ’λ£	
	});
	$('#password2').on("propertychange change keyup paste input", function() {
		var password2 = $('#password2').val(); // passwordμ μλ ₯λλ κ°
		var password = $('#password').val();
		var data = {
			password : password,
			password2 : password2
		} // 'μ»¨νΈλ‘€μ λκΈΈ λ°μ΄ν° μ΄λ¦' : 'λ°μ΄ν°(.inputμ μλ ₯λλ κ°)'

		$.ajax({
			type : "post",
			url : "passChk.do",
			data : data,
			success : function(result) {
				
				if(result != 'fail'){
					$('.pass_re1').css("display","inline");
					$('.pass_re2').css("display", "none");				
				} else {
					$('.pass_re2').css("display","inline");
					$('.pass_re1').css("display", "none");				
				}
			}// success μ’λ£
		}); // ajax μ’λ£	
	});
</script>

</html>