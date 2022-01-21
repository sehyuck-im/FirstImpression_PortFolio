<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initialscale=1">
<style>

/* 	caption { font-size: 30px; }
	.err { color: red; font-weight: bold; }
    th { background: pink; font-weight: bold; } */
</style>
<!-- pageContext.request.contextPath : 프로젝트 명 -->
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<%-- ${path }를 사용하면 패키지의 경로가 절대경로로 변경 --%>
<link rel="icon" type="image/x-icon"
	href="${path}/resources/design/favicon.ico" />	
<link href="${path}/resources/master/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="${path}/resources/master/css/sb-admin-2.min.css" rel="stylesheet">


<%-- <script type="text/javascript" src="${path}/resources/layout/js/scripts.js"></script> --%>
