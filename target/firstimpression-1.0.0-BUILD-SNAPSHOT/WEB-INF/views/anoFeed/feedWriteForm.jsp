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
	<header><jsp:include page="../layout/header.jsp"></jsp:include></header>
	<div class="mainContainer">
		<div class="page-header">
			<div class="row">
				<div class="col-lg-4"></div>
				<div class="col-lg-4">
					<div class="alert alert-dismissible alert-primary">
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
						μκ·Ήμ μΈ λ΄μ© νΉμ μ΄κ·Έλ‘μ± κ²μλ¬Όμ κ΄λ¦¬μμ μν΄ μ­μ , μ μ¬ λ  μ μμ΅λλ€.
					</div>
				</div>
				<div class="col-lg-4"></div>
			</div>
			<div class="row">
				<div class="col-lg-3"></div>
				<div class="col-lg-6">
					<form action="feedWrite.do" method="post" name="frm"
						enctype="multipart/form-data">
						<fieldset>
							<div class="row">
								<span class="form-group col-lg-8"> <label
									class="form-label mt-2"></label> <span
									class="form-floating mb-3"> <input type="text"
										class="form-control" id="anTitle" name="anTitle"
										placeholder="μ λͺ©μ μλ ₯νμΈμ" required="required"> <label
										for="anTitle" style="color: rgba(255, 255, 255, 0.7);">Title</label>
								</span>
								</span>
							</div>
							<div class="row">
								<span class="form-group col-lg-7"> <label for="formFile"
									class="form-label mt-2"></label> <input class="form-control"
									type="file" id="file" name="file" onchange="checkFile(this)">
									<small id="photoHelp" class="form-text text-muted">5MB
										μ΄νμ jpg,gif,jpeg,png νμΌλ§ μλ‘λ ν μ μμ΅λλ€.</small>
								</span> <span class="form-check col-lg-2 mt-2 ml-2"> <label
									class="form-check-label mt-2" for="anCheck"
									style="color: rgba(255, 255, 255, 0.7);"> μ΅λͺκΈπ­</label><input
									class="form-check-input mt-2" type="checkbox" value="y"
									id="anCheck" name="anCheck">
								</span>
							</div>
							<div class="accordion" id="accordionExample">
								<div class="accordion-item mt-3">
									<h2 class="accordion-header" id="headingOne">
										<button class="accordion-button collapsed" type="button"
											data-bs-toggle="collapse" data-bs-target="#collapseOne"
											aria-expanded="false" aria-controls="collapseOne">
											κ΄μ¬μ¬ (μ΅λ 5κ° μ ν κ°λ₯ν©λλ€)</button>
									</h2>
									<div id="collapseOne" class="accordion-collapse collapse"
										aria-labelledby="headingOne"
										data-bs-parent="#accordionExample" style="">
										<div class="accordion-body">										
										
										<input class="form-control" style="width:35%" type="text" id="filterText" placeholder="μνλ νκ·Έ κ²μ">										
											
											<div class="row" id="tagList">
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
											/ μ΅λ 200μ)</span></label>
									<textarea class="form-control" id="anContent" name="anContent"
										rows="6" cols="10" placeholder="200μ μ΄νλ‘λ§ μμ± κ°λ₯ν©λλ€."
										required="required"></textarea>
								</div>
							</div>

							<div class="form-group mt-2" align="center">
								<input type="submit" class="btn btn-primary" value="Write!">
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
		$('#counter').html("(" + content.length + " / μ΅λ 200μ)"); //κΈμμ μ€μκ° μΉ΄μ΄ν

		if (content.length > 200) {
			alert("μ΅λ 200μκΉμ§ μλ ₯ κ°λ₯ν©λλ€.");
			$(this).val(content.substring(0, 200));
			$('#counter').html("(200 / μ΅λ 200μ)");
		}
	});
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