<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>마이 페이지</h1>
	<hr>
	<div class="myinfo_area">
       <span>이름 : ${member.memberName}</span> 
       <br>
   	   <span>아이디 : ${member.memberId}</span>
   	   <br> 
       <span>비밀번호 : ${member.memberPw}</span>
       <br> 
      <span>전화번호 : ${member.memberTel}</span>   
    </div>
	<hr>
	<h3><a href="main">HOME</a></h3>
</body>
</html>