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
				alert("대표사진을 포함한 사진 3장을 업로드하셔야 수정 완료 됩니다.");
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
				//또는 this.checked=false;
				alert("관심사는 최대 5개까지 선택 가능 합니다.");
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
	<header><jsp:include page="../layout/header.jsp"></jsp:include></header>
	<div class="container">
		<section class="mainContainer">
			<form action="updateProfile.do" method="post" name="frm"
				enctype="multipart/form-data" onsubmit="return chk()">
				<input type="hidden" name="nick" value="${profile.nick }"> <input
					type="hidden" name="prePhoto1" value="${profile.photo1 }">
				<input type="hidden" name="prePhoto2" value="${profile.photo2 }">
				<input type="hidden" name="prePhoto3" value="${profile.photo3 }">

				<fieldset>
					<legend>${profile.id }님의 Profile</legend>
					<div class="form-group">
						<label for="file1" class="form-label mt-4"> 대표사진 </label> <input
							class="form-control" type="file" id="file1" name="file1"
							style="width: 60%;" onchange="checkFile(this)"
							aria-describedby="photoHelp1"> <small id="photoHelp1"
							class="form-text text-muted">5MB 이하의 jpg,gif,jpeg,png 파일만
							업로드 할수 있습니다.</small>
					</div>

					<div class="card text-white bg-secondary mb-2 mt-2"
						style="max-width: 20rem;" id="photo1">
						<div class="card-header">현재 대표 사진</div>
						<div class="card-body">
							<c:if test="${profile.photo1 ne null }">
								<img width="100%" height="auto"
									src="resources/profiles/${profile.photo1}" alt="이미지">
							</c:if>
							<c:if test="${profile.photo1 eq null }">
							이미지가 없습니다.
							</c:if>
						</div>
					</div>

					<div class="form-group">
						<label for="file2" class="form-label mt-2"> 나를 표현하는 사진 </label> <input
							class="form-control" type="file" id="file2" name="file2"
							style="width: 60%;" onchange="checkFile(this)"
							aria-describedby="photoHelp2"> <small id="photoHelp2"
							class="form-text text-muted">대표 사진을 포함하여 3장 모두 업로드해야 프로필
							수정이 완료됩니다.</small>
					</div>
					<div class="card text-white bg-secondary mb-2 mt-2"
						style="max-width: 20rem;">
						<div class="card-header">현재 사진</div>
						<div class="card-body" id="photo2">
							<c:if test="${profile.photo2 ne null }">
								<img width="100%" height="auto"
									src="resources/profiles/${profile.photo2}" alt="이미지">
							</c:if>
							<c:if test="${profile.photo2 eq null }">
							이미지가 없습니다.
							</c:if>
						</div>
					</div>
					<div class="form-group">
						<label for="file3" class="form-label mt-2"> 나를 표현하는 사진</label> <input
							class="form-control" type="file" id="file3" name="file3"
							aria-describedby="photoHelp3" style="width: 60%;"
							onchange="checkFile(this)"> <small id="photoHelp3"
							class="form-text text-muted"></small>
					</div>
					<div class="card text-white bg-secondary mb-2 mt-2"
						style="max-width: 20rem;">
						<div class="card-header">현재 사진</div>
						<div class="card-body" id="photo3">
							<c:if test="${profile.photo3 ne null }">
								<img width="100%" height="auto"
									src="resources/profiles/${profile.photo3}" alt="이미지">
							</c:if>
							<c:if test="${profile.photo3 eq null }">
							이미지가 없습니다.
							</c:if>
						</div>
					</div>
					<div class="form-group row">
						<label for="nick" class="col-sm-2 col-form-label mt-4">닉네임</label>
						<div class="col-sm-10 mt-4">
							<input type="text" readonly="" class="form-control-plaintext"
								id="nick" value="${profile.nick }">
						</div>
					</div>
				</fieldset>
				<fieldset>
					<div class="form-group row">
						<label for="nick" class="col-sm-2 col-form-label mt-2">나이</label>
						<div class="col-sm-10 mt-2">
							<input type="text" readonly="" class="form-control-plaintext"
								id="age" value="${profile.age}">
						</div>
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label for="" class="col-sm-2 col-form-label mt-2">성별</label>
					<div class="form-check">
						<c:if test="${genderK eq '남성' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios1"
								checked="checked" value="male"> 남성
							</label>
						</c:if>
						<c:if test="${genderK ne '남성' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios1"
								value="male"> 남성
							</label>
						</c:if>
					</div>
					<div class="form-check">
						<c:if test="${genderK eq '여성' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios2"
								checked="checked" value="female"> 여성
							</label>
						</c:if>
						<c:if test="${genderK ne '여성' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios2"
								value="female"> 여성
							</label>
						</c:if>
					</div>
					<div class="form-check">
						<c:if test="${genderK eq '공개안함' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios3"
								value="none" checked="checked"> 공개안함
							</label>
						</c:if>
						<c:if test="${genderK ne '공개안함' }">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="gender" id="optionsRadios3"
								value="none"> 공개안함
							</label>
						</c:if>
					</div>
				</fieldset>

				<div class="form-group">
					<label for="exampleTextarea" class="form-label mt-4">${profile.nick }님
						소개</label>
					<textarea class="form-control" id="exampleTextarea" rows="3"
						name="intro">${profile.intro }</textarea>
				</div>

				<fieldset class="form-group">
					<legend class="mt-4">관심사 (최대 5개까지 선택 가능 합니다.)</legend>
					<p><input class="form-control" style="width:35%" type="text" id="filterText" placeholder="원하는 태그 검색"></p>
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
						type="submit" class="btn btn-primary" value="수정 완료">
				</div>
			</form>
		</section>

	</div>
	<footer><jsp:include page="../layout/footer.jsp"></jsp:include></footer>
</body>
<script type="text/javascript">
	function checkFile(input) {
		if (input.files && input.files[0].size > (5 * 1024 * 1024)) {
			alert("파일 사이즈가 5mb 를 넘습니다.");
			input.value = null;
		}
		var fileVal = input.value;
		console.log(fileVal)
		if (fileVal != "") {
			var ext = fileVal.split('.').pop().toLowerCase(); //확장자분리
			//아래 확장자가 있는지 체크
			if ($.inArray(ext, [ 'jpg', 'jpeg', 'gif', 'png' ]) == -1) {
				alert('jpg,gif,jpeg,png 파일만 업로드 할수 있습니다.');
				input.value = null;
				return;
			}
		}
	}
	
</script>
</html>