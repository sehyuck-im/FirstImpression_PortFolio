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
<style type="text/css">
.mainContainer {
	margin-top: 75px;
	padding: 50px;
}
</style>
<script type="text/javascript">
	function chk() {
		if (frm.file1.value == '' || frm.file2.value == ''
				|| frm.file3.value == '') {
			if (frm.prePhoto1.value == '' || frm.prePhoto2.value == ''
					|| frm.prePhoto3.value == '') {
				alert("λνμ¬μ§μ ν¬ν¨ν μ¬μ§ 3μ₯μ μλ‘λνμμΌ μμ  μλ£ λ©λλ€.");
				return false;
			}
		}
	}

	$(function() {
		var interest = 5;
		var count;
		$("input[type='checkbox']").on("click", function() {
			count = $("input:checked[type='checkbox']").length;
			if (count > 5) {
				$(this).prop("checked", false);
				//λλ this.checked=false;
				alert("κ΄μ¬μ¬λ μ΅λ 5κ°κΉμ§ μ ν κ°λ₯ ν©λλ€.");
				count = count - 1;
			}

		});
	});
	$(function() {
		$('#filterText').keyup(function(event) {
		        var val = $(this).val().toUpperCase();			        
	        if (val == "") {
	            $('.search').show();
	        } else {
	            $('.search').hide();
	            $(".search:contains('"+val+"')").show();
		        }
	    });
});
	
</script>
</head>
<body>	
	<div class="container">
		<section class="mainContainer">
			<form action="masterUpdateProfile.do" method="post" name="frm"
				enctype="multipart/form-data" onsubmit="return chk()">
				<input type="hidden" name="nick" value="${profile.nick }"> <input
					type="hidden" name="prePhoto1" value="${profile.photo1 }">
				<input type="hidden" name="prePhoto2" value="${profile.photo2 }">
				<input type="hidden" name="prePhoto3" value="${profile.photo3 }">

				<fieldset>
					<legend>${profile.id }λμ Profile</legend>
					<div class="form-group">
						<label for="file1" class="form-label mt-4"> λνμ¬μ§ </label> <input
							class="form-control" type="file" id="file1" name="file1"
							style="width: 60%;" onchange="checkFile(this)"
							aria-describedby="photoHelp1"> <small id="photoHelp1"
							class="form-text text-muted">5MB μ΄νμ jpg,gif,jpeg,png νμΌλ§
							μλ‘λ ν μ μμ΅λλ€.</small>
					</div>

					<div class="card text-white bg-secondary mb-2 mt-2"
						style="max-width: 20rem;">
						<div class="card-header">νμ¬ λν μ¬μ§</div>
						<div class="card-body">
							<img width="100%" height="auto"
								src="resources/profiles/${profile.photo1}" alt="μ΄λ―Έμ§">
						</div>
					</div>

					<div class="form-group">
						<label for="file2" class="form-label mt-2"> λλ₯Ό νννλ μ¬μ§ </label> <input
							class="form-control" type="file" id="file2" name="file2"
							style="width: 60%;" onchange="checkFile(this)"
							aria-describedby="photoHelp2"> <small id="photoHelp2"
							class="form-text text-muted">λν μ¬μ§μ ν¬ν¨νμ¬ 3μ₯ λͺ¨λ μλ‘λν΄μΌ νλ‘ν
							μμ μ΄ μλ£λ©λλ€.</small>
					</div>
					<div class="card text-white bg-secondary mb-2 mt-2"
						style="max-width: 20rem;">
						<div class="card-header">νμ¬ μ¬μ§</div>
						<div class="card-body">
							<img width="100%" height="200"
								src="resources/profiles/${profile.photo2}" alt="μ΄λ―Έμ§">
						</div>
					</div>
					<div class="form-group">
						<label for="file3" class="form-label mt-2"> λλ₯Ό νννλ μ¬μ§</label> <input
							class="form-control" type="file" id="file3" name="file3"
							aria-describedby="photoHelp3" style="width: 60%;"
							onchange="checkFile(this)"> <small id="photoHelp3"
							class="form-text text-muted"></small>
					</div>
					<div class="card text-white bg-secondary mb-2 mt-2"
						style="max-width: 20rem;">
						<div class="card-header">νμ¬ μ¬μ§</div>
						<div class="card-body">
							<img width="100%" height="200"
								src="resources/profiles/${profile.photo3}" alt="μ΄λ―Έμ§">
						</div>
					</div>
					<div class="form-group row">
						<label for="nick" class="col-sm-2 col-form-label mt-4">λλ€μ</label>
						<div class="col-sm-10 mt-4">
							<input type="text" readonly="" class="form-control-plaintext"
								id="nick" value="${profile.nick }">
						</div>
					</div>
				</fieldset>
				<fieldset>
					<div class="form-group row">
						<label for="nick" class="col-sm-2 col-form-label mt-2">λμ΄</label>
						<div class="col-sm-10 mt-2">
							<input type="text" readonly="" class="form-control-plaintext"
								id="age" value="${profile.age}">
						</div>
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label for="" class="col-sm-2 col-form-label mt-2">μ±λ³</label>
					<div class="form-check">
						<c:if test="${genderK eq 'λ¨μ±' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios1"
								checked="checked" value="male"> λ¨μ±
							</label>
						</c:if>
						<c:if test="${genderK ne 'λ¨μ±' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios1"
								value="male"> λ¨μ±
							</label>
						</c:if>
					</div>
					<div class="form-check">
						<c:if test="${genderK eq 'μ¬μ±' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios2"
								checked="checked" value="female"> μ¬μ±
							</label>
						</c:if>
						<c:if test="${genderK ne 'μ¬μ±' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios2"
								value="female"> μ¬μ±
							</label>
						</c:if>
					</div>
					<div class="form-check">
						<c:if test="${genderK eq 'κ³΅κ°μν¨' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios3"
								value="none" checked="checked"> κ³΅κ°μν¨
							</label>
						</c:if>
						<c:if test="${genderK ne 'κ³΅κ°μν¨' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios3"
								value="none"> κ³΅κ°μν¨
							</label>
						</c:if>
					</div>
				</fieldset>

				<div class="form-group">
					<label for="exampleTextarea" class="form-label mt-4">${profile.nick }λ
						μκ°</label>
					<textarea class="form-control" id="exampleTextarea" rows="3"
						name="intro">${profile.intro }</textarea>
				</div>

				<fieldset class="form-group">
					<legend class="mt-4">κ΄μ¬μ¬ (μ΅λ 5κ°κΉμ§ μ ν κ°λ₯ ν©λλ€.)</legend>
					<p><input class="form-control" style="width:35%" type="text" id="filterText" placeholder="μνλ νκ·Έ κ²μ"></p>
					<p>&nbsp;</p>	
					<div class="row" id="tagList">
						<c:forEach var="itList" items="${itList }">
							<div class="search col-lg-2">
								<input class="btn-check" type="checkbox" value="${itList.tag }"
									id="${itList.tag }" name="tags" checked="checked"><label
									class="btn btn-outline-secondary btn-sm mt-1"
									for="${itList.tag }">${itList.tag }</label>
							</div>
						</c:forEach>
						<c:forEach var="tags" items="${tags2 }">
							<div class="search col-lg-2">
								<input class="btn-check" type="checkbox" value="${tags }"
									id="${tags }" name="tags"><label
									class="btn btn-outline-secondary btn-sm mt-1" for="${tags }">${tags}</label>
							</div>
						</c:forEach>
					</div>
				</fieldset>

				<div class="form-group" align="center">
					<label for="" class="form-label mt-4"> </label> <input
						type="submit" class="btn btn-primary" value="μμ  μλ£">
				</div>
			</form>
		</section>

	</div>	
</body>
<script type="text/javascript">
	function checkFile(input) {
		if (input.files && input.files[0].size > (5 * 1024 * 1024)) {
			alert("νμΌ μ¬μ΄μ¦κ° 5mb λ₯Ό λμ΅λλ€.");
			input.value = null;
		}
		var fileVal = input.value;
		console.log(fileVal)
		if (fileVal != "") {
			var ext = fileVal.split('.').pop().toLowerCase(); //νμ₯μλΆλ¦¬
			//μλ νμ₯μκ° μλμ§ μ²΄ν¬
			if ($.inArray(ext, [ 'jpg', 'jpeg', 'gif', 'png' ]) == -1) {
				alert('jpg,gif,jpeg,png νμΌλ§ μλ‘λ ν μ μμ΅λλ€.');
				input.value = null;
				return;
			}
		}
	}
</script>
</html>