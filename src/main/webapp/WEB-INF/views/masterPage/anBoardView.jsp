<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="">
<meta name="author" content="">

<script type="text/javascript">
function delAnBoard() {
	var con = confirm("게시글을 삭제하시겠습니까?");
	if(con) {
		location.href="anBoardDelete.do?anNum=${anNum}";
	}
}

function resAnBoard() {
	var con = confirm("게시글을 복구하시겠습니까?");
	if(con) {
		location.href="anBoardRestore.do?anNum=${anNum}";
	}
}
</script>


<title>💘첫인상 - First Impression</title>

<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />


</head>
<body id="page-top">
	
	<!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="masterSiMain.do">
                <div class="sidebar-brand-icon ">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-display" viewBox="0 0 16 16">
  <path d="M0 4s0-2 2-2h12s2 0 2 2v6s0 2-2 2h-4c0 .667.083 1.167.25 1.5H11a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1h.75c.167-.333.25-.833.25-1.5H2s-2 0-2-2V4zm1.398-.855a.758.758 0 0 0-.254.302A1.46 1.46 0 0 0 1 4.01V10c0 .325.078.502.145.602.07.105.17.188.302.254a1.464 1.464 0 0 0 .538.143L2.01 11H14c.325 0 .502-.078.602-.145a.758.758 0 0 0 .254-.302 1.464 1.464 0 0 0 .143-.538L15 9.99V4c0-.325-.078-.502-.145-.602a.757.757 0 0 0-.302-.254A1.46 1.46 0 0 0 13.99 3H2c-.325 0-.502.078-.602.145z"/>
</svg>
                </div>
                <div class="sidebar-brand-text mx-3">마스터<br>관리 페이지</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="masterSiMain.do">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">            

            <!-- Heading -->
            <div class="sidebar-heading">
                	Data
            </div>            

            <!-- Nav Item - Charts -->
            <li class="nav-item">
                <a class="nav-link" href="anBoardTable.do">
                    <i class="far fa-comments" style="color:white;"></i>
                    <span>게시글목록</span></a>
            </li>

            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link" href="matchingTable.do">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-half" viewBox="0 0 16 16">
  <path d="M8 2.748v11.047c3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
</svg>
                    <span>매칭데이터</span></a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="peopleTable.do">
                   <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-person" viewBox="0 0 16 16">
  <path d="M12 1a1 1 0 0 1 1 1v10.755S12 11 8 11s-5 1.755-5 1.755V2a1 1 0 0 1 1-1h8zM4 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H4z"/>
  <path d="M8 10a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
</svg>
                    <span>회원관리</span></a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="reportTable.do">                    
                    <i class="fas fa-shield-alt" style="color:white;"></i>
                    <span>신고 목록</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>
        </ul>
        <!-- End of Sidebar -->



        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>  
                    
                    <span class="text-xs font-weight-bold text-primary mb-1" style="font-size:230%">&nbsp;&nbsp;&nbsp;First Impression</span>
                   
                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">관리자</span>
                                <img class="img-profile rounded-circle"
                                    src="${path}/resources/master/img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="masterUpdateProfileForm.do">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <div class="dropdown-divider"></div>                                
                                <a class="dropdown-item" href="signOut.do" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Sign Out
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>
                <!-- End of Topbar -->
                <div class="row">
                <div class="card shadow mb-4" style="width:600px; margin: 0 auto">
					<div class="card-header py-3">
						<h5 class="m-0 font-weight-bold text-primary">${title }</h5>
						<c:if test="${anDel eq 'n' }">
						<button class="btn btn-primary" onclick="delAnBoard()" style="margin-top:-30px; float: right;">삭제</button>
						</c:if>
						<c:if test="${anDel eq 'y' }">
						<button class="btn btn-primary" onclick="resAnBoard()" style="margin-top:-30px; float: right;">복구</button>
						</c:if>
					</div>
					<div class="card-body">
						<c:if test="${anCheck eq 'y' }">
							<span>익명 피드입니다(${nick})</span>
						</c:if>
						<c:if test="${anCheck ne 'y'}">
								<span>${nick}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						</c:if>						
						<a  href="#" class="btn btn-primary btn-sm">❤</a>&nbsp;&nbsp;${likeCount}
					</div>
					<div class="card-body">					
							<c:if test="${empty temphash }">
								<span>설정된 해시태그가 없습니다</span>
							</c:if>
							<c:if test="${not empty temphash  }">
								<c:forEach var="hashTag" items="${temphash }">
									<span>#${hashTag.tag}</span>
								</c:forEach>
							</c:if>
					</div>
					<div class="card-body">	
					<c:if test="${photo ne null }">
							<img height="auto" width="100%" id="photo"
											src="resources/feed/${photo}" alt="이미지">
					</c:if>
					</div>
					<div class="card-body">
						<pre>${anContent}</pre>
					</div>										
				</div>    
                </div>    
                <!-- /.container-fluid -->
            
            </div>
            </div>
            <!-- End of Main Content -->

            <!-- Footer -->            
            <!-- End of Footer -->
        </div>
        <!-- End of Content Wrapper -->
    <!-- End of Page Wrapper -->
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
    
    
    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Sign Out 하시겠습니까?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">관리자 페이지에서 Sign Out 하시면 메인 페이지로 돌아가게 됩니다.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="main.do">Sign Out</a>
                </div>
            </div>
        </div>
    </div>

	<!-- Bootstrap core JavaScript-->
    <script src="${path}/resources/master/vendor/jquery/jquery.min.js"></script>
    <script src="${path}/resources/master/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${path}/resources/master/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${path}/resources/master/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="${path}/resources/master/vendor/chart.js/Chart.min.js"></script>
    <script src="${path}/resources/master/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="${path}/resources/master/vendor/datatables/dataTables.bootstrap4.min.js"></script>
    
    <!-- Page level custom scripts -->
    <script src="${path}/resources/master/js/demo/chart-area-demo.js"></script>
    <script src="${path}/resources/master/js/demo/chart-pie-demo.js"></script>
    <script src="${path}/resources/master/js/demo/datatables-demo.js"></script>
	
</body>
</html>