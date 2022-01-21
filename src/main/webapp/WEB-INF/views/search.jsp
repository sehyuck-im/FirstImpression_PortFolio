<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page 
import="java.io.BufferedReader" 
import= "java.io.InputStreamReader" 
import= "java.net.HttpURLConnection" 
import= "java.net.URL" 
import= "java.net.URLEncoder" 
%>

<%! 
StringBuffer sb; 
String clientId = "krzSNp7JMQQTanZtRTNO";
String clientSecret = "kedSXVvLYM";
%>
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
</head>
<body>
<% 
int display = 3; 
try { 
	String text = URLEncoder.encode("신촌 카페", "UTF-8"); 
	String apiURL = "https://openapi.naver.com/v1/search/local.json?query=" + text+"&display="+display; 
	URL url = new URL(apiURL); 
	HttpURLConnection con = (HttpURLConnection) url.openConnection();

	con.setRequestMethod("GET"); 
	con.setRequestProperty("X-Naver-Client-Id", clientId); 
	con.setRequestProperty("X-Naver-Client-Secret", clientSecret); 
	int responseCode = con.getResponseCode(); 
	BufferedReader br; 
	if (responseCode == 200) { 
		br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8")); 
		} else { 
			br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8")); 
			} 
	sb = new StringBuffer(); 
	String line; 
	while ((line = br.readLine()) != null) { 
	%><%=line%><br><% 
			sb.append(line + "\n");; 
			} 
	br.close(); 
	con.disconnect();
} catch (Exception e) { 
	System.out.println(e);
} 
%> 

<input type="text" id="searchvalue"><a href="#" class="searchbutton">검색</a>
<div id="searchcafe">
123
</div>
</body> 
</html>