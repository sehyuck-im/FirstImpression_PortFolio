<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.11.0.js"></script>

</head>
<body>

<br>
<span id="address">${address}</span>


<form action="locationResult2.do" method="post" name="frm"> 
    <input type="hidden" id="address" name="address" value="${address}">
    <button class="button">약속장소 추천</button>     
</form> 

</body>
</html>