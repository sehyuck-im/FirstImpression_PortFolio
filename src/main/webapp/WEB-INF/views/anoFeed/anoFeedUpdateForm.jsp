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
	margin-top: 150px;
}

option {
	color: black;
}

.anCheck {
	margin-left: 5px;
}
</style>
<script type="text/javascript">
	$(function() {
		var interest = 5;
		var count;
		$("input[type='checkbox']").on("click", function() {
			count = $("input:checked[name='tags']").length;
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
				$(".search:contains('" + val + "')").show();
			}
		});
	});
</script>
</head>
<body>
	<header><jsp:include page="../layout/header.jsp"></jsp:include></header>
	<div class="mainContainer">
		<div class="page-header">
			<div class="row">
				<div class="col-lg-4"></div>
				<div class="col-lg-4">
					<div class="alert alert-dismissible alert-primary">
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
						자극적인 내용 혹은 어그로성 게시물은 관리자에 의해 삭제, 제재 될 수 있습니다.
					</div>
				</div>
				<div class="col-lg-4"></div>
			</div>
			<div class="row">
				<div class="col-lg-3"></div>
				<div class="col-lg-6">
					<form action="feedUpdate.do" method="post" name="frm"
						enctype="multipart/form-data">
						<input type="hidden" name="prePhoto" value="${anoFeed.photo }">
						<input type="hidden" name="anNum" value="${anoFeed.anNum }">
						<fieldset>
							<div class="row">
								<span class="form-group col-lg-8"> <label
									class="form-label mt-2"></label> <span
									class="form-floating mb-3"> <input type="text"
										class="form-control" id="anTitle" name="anTitle"
										placeholder="제목을 입력하세요" required="required"
										value="${anoFeed.anTitle }"> <label for="anTitle"
										style="color: rgba(255, 255, 255, 0.7);">Title</label>
								</span>
								</span>
							</div>
							<div class="row">
								<span class="form-group col-lg-7"> <label for="formFile"
									class="form-label mt-2"></label> <input class="form-control"
									type="file" id="file" name="file" onchange="checkFile(this)">
									<small id="photoHelp" class="form-text text-muted">5MB
										이하의 jpg,gif,jpeg,png 파일만 업로드 할수 있습니다.</small>
								</span> <span class="form-check col-lg-2 mt-2 ml-2"> <c:if
										test="${anoFeed.anCheck eq 'y' }">
										<label class="form-check-label mt-2" for="anCheck"
											style="color: rgba(255, 255, 255, 0.7);"> 익명글🎭</label>
										<input class="form-check-input mt-2" type="checkbox" value="y"
											id="anCheck" name="anCheck" checked="checked">
									</c:if> <c:if test="${anoFeed.anCheck eq 'n' }">
										<label class="form-check-label mt-2" for="anCheck"
											style="color: rgba(255, 255, 255, 0.7);"> 익명글🎭</label>
										<input class="form-check-input mt-2" type="checkbox" value="y"
											id="anCheck" name="anCheck">
									</c:if>
								</span>
							</div>
							<div class="accordion" id="accordionExample">
								<div class="accordion-item mt-3">
									<h2 class="accordion-header" id="headingOne">
										<button class="accordion-button collapsed" type="button"
											data-bs-toggle="collapse" data-bs-target="#collapseOne"
											aria-expanded="false" aria-controls="collapseOne">
											관심사 (최대 5개 선택 가능합니다)</button>
									</h2>
									<div id="collapseOne" class="accordion-collapse collapse"
										aria-labelledby="headingOne"
										data-bs-parent="#accordionExample" style="">
										<div class="accordion-body">

											<input class="form-control" style="width: 35%" type="text"
												id="filterText" placeholder="원하는 태그 검색">

											<div class="row" id="tagList">
												<c:if test="${not empty hashList }">
													<c:forEach var="hashList" items="${hashList }">
														<div class="search col-lg-2" id="tagg">
															<input class="btn-check" type="checkbox"
																value="${hashList.tag }" id="${hashList.tag }"
																name="tags" checked="checked"> <label
																class="btn btn-outline-secondary btn-sm mt-1"
																for="${hashList.tag }">${hashList.tag }</label>
														</div>
													</c:forEach>
												</c:if>
												<c:forEach var="tags" items="${tags }">
													<div class="search col-lg-2" id="tagg">
														<input class="btn-check" type="checkbox" value="${tags }"
															id="${tags }" name="tags"><label
															class="btn btn-outline-secondary btn-sm mt-1"
															for="${tags }">${tags}</label>
													</div>
												</c:forEach>
											</div>

										</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group col-lg-12">
									<label for="exampleTextarea" class="form-label mt-2"><span
										id="counter" style="color: rgba(255, 255, 255, 0.7);">(0
											/ 최대 200자)</span></label>
									<textarea class="form-control" id="anContent" name="anContent"
										rows="6" cols="10" placeholder="200자 이하로만 작성 가능합니다."
										required="required">${anoFeed.anContent }</textarea>
								</div>
							</div>

							<div class="form-group mt-2" align="center">
								<input type="submit" class="btn btn-primary" value="Submit">
							</div>
						</fieldset>
					</form>
				</div>
				<div class="col-lg-3"></div>
			</div>
		</div>
	</div>

	<footer><jsp:include page="../layout/footer.jsp"></jsp:include></footer>
</body>
<script type="text/javascript">
	$('#anContent').keyup(function(e) {
		var content = $(this).val();
		$('#counter').html("(" + content.length + " / 최대 200자)"); //글자수 실시간 카운팅

		if (content.length > 200) {
			alert("최대 200자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 200));
			$('#counter').html("(200 / 최대 200자)");
		}
	});
	function checkFile(input) {
		if (input.files && input.files[0].size > (5 * 1024 * 1024)) {
			alert("파일 사이즈가 5mb 를 넘습니다.");
			input.value = null;
		}
		var fileVal = input.value;
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

</body>
</html>