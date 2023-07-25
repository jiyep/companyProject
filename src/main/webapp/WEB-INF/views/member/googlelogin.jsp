<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script src="https://accounts.google.com/gsi/client" async defer></script>
	
	<div id="g_id_onload"
     data-client_id="693950693173-md08psfdc7b4tcr7niaol18n3hon6h08.apps.googleusercontent.com"
     data-callback="handleCredentialResponse">
	</div>
	<div class="g_id_signin"
		 data-type="standard" data-size="large" data-theme="outline" data-text="sign_in_with" data-shape="rectangular" data-logo_alignment="left" data-width="250"> </div>
		  
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