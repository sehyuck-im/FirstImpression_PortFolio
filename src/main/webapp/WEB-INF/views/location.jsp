<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k8221vnqwi&submodules=geocoder"></script>

<script>

$(function() {        
    // Geolocation API에 액세스할 수 있는지를 확인
    if (navigator.geolocation) {
        //위치 정보를 얻기
        navigator.geolocation.getCurrentPosition (function(pos) {
          $('#latitude').val(pos.coords.latitude);     // 위도
          $('#longitude').val(pos.coords.longitude); // 경도
        });
    } else {
        alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.")
    }
});

</script>
</head>
<body>
<form action="locationResult.do" method="post" name="frm">  
     <ul>
        <li>현재 위도:<input type="text" id="latitude" name="latitude"></li>  
        <li>현재 경도:<input type="text" id="longitude" name="longitude"></li>       
                  
    </ul>
    
    <button class="button">로그인 버튼</button>    
</form>  

</body>
</html>