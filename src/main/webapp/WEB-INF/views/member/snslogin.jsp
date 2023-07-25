<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>SNS LOGIN </title>
<meta name="google-signin-client_id" content="575770741448-rveoc606844jhupearvuutnu12bif6fl.apps.googleusercontent.com">
</head>
<body>


<h1>소셜 로그인</h1>
<hr>	
<br>
 
<center>
				
			<!-- 네이버 로그인 창으로 이동 -->
			<div id="naver_id_login" style="text-align:center"><a href="${url}">
			<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a></div>
			<br>
			
			<!-- google 로그인 -->
			<script src="https://accounts.google.com/gsi/client" async defer></script>
	
			<div id="g_id_onload"
		     data-client_id="693950693173-md08psfdc7b4tcr7niaol18n3hon6h08.apps.googleusercontent.com"
		     data-callback="handleCredentialResponse">
			</div>
			<div class="g_id_signin"
				 data-type="standard" data-size="large" data-theme="outline" data-text="sign_in_with" data-shape="rectangular" data-logo_alignment="left" data-width="250"> </div>

</center>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>	
<script type="text/javascript">
		function handleCredentialResponse(response) {
		    // decodeJwtResponse() is a custom function defined by you
		    // to decode the credential response.
		    const responsePayload = parseJwt(response.credential);
		
		    console.log("ID: " + responsePayload.sub);
		    console.log('Full Name: ' + responsePayload.name);
		    console.log('Given Name: ' + responsePayload.given_name);
		    console.log("Email: " + responsePayload.email); 
		    
			$.ajax({
				url: '/member/loginGoogle',
				type: 'post',
				data: {
				    "memberName": responsePayload.name,
					"memberEmail": responsePayload.email
					},
				success: function (data) {
					if(data == "mainPage"){
						location.href = "main";	
					}else{
						location.href = "/member/snsJoin";	
					}
		
				   }
				});
		}
		
		function parseJwt (token) {
		    var base64Url = token.split('.')[1];
		    var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
		    var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
		        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
		    }).join(''));
		
		    return JSON.parse(jsonPayload);
		};
				
	</script>
	
</body>
</html>