<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>NAVER LOGIN TEST</title>
</head>
<body>
<h1>로그인</h1>
<hr>	
<br>
 
<center>
	<c:choose>
		<c:when test="${name != null}">
			<h2> 네이버 아이디 로그인 성공하셨습니다!! </h2>
			<h3>'${name}' 님 환영합니다! </h3>
            	<h3><a href="logout">로그아웃</a></h3>
            	<h3><a href="main">HOME</a></h3>
		</c:when>
		
		<c:otherwise>			
			<!-- 네이버 로그인 창으로 이동 -->
			<div id="naver_id_login" style="text-align:center"><a href="${url}">
			<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a></div>
			<br>
		
		</c:otherwise>
	</c:choose>
	
</center>
</body>
</html>