<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/resources/css/member/login.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  
<style>
/* 마이페이지에 있는 버튼 */
.login_button_wrap{
	margin-top: 40px;
	text-align: center;
}
.login_page_button{
	float : left;
	width: 48%;
}
</style>

</head>
<body>

	<div class="wrapper">
		
		<div class="wrap">
			<form id="login_form" method="post">
				<div class="logo_wrap">
					<span>로그인</span>
				</div>
				<div class="login_wrap"> 
					<div class="id_wrap">
							<div class="id_input_box">
							<input class="id_input" name="memberId" id="memberId" placeholder="아이디">
						</div>
					</div>
					<div class="pw_wrap">
						<div class="pw_input_box">
							<input class="pw_iput" type="password" name="memberPw" id="memberPws" placeholder="비밀번호">
						</div>
					</div>
					
					<c:if test = "${result == 0 }">
		                <div class = "login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
		            </c:if>

	                
					<div class="login_button_wrap">
						<input type="checkbox" id="idSaveCheck" >아이디 기억하기
						<br>
						<br>
						<input type="submit" class="login_button" value="로그인">
					</div>			
				</div>
			</form>
			
			<div class="login_button_wrap">
				<h3><a href="/member/findpw" class="login_page_button">임시비밀번호 발급</a></h3>
				<h3><a href="main" class="login_page_button" style="float:right;">메인으로</a></h3>
			</div>	

		</div>
	
	</div>

	<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
	<script>
	
	    /* 로그인 버튼 클릭 메서드 */
	    $(".login_button").click(function(){        
	        //alert("로그인 버튼 작동");
	        
	    	// 로그인 메서드 서버 요청 
	        $("#login_form").attr("action", "/member/login");
	        $("#login_form").submit();
	        
	    });
	    
	    $(document).ready(function(){
	    	 
	        // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	        var key = getCookie("key");
	        $("#memberId").val(key); 
	         
	        if($("#memberId").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	            $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	        }
	         
	        $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
	            if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
	                setCookie("key", $("#memberId").val(), 7); // 7일 동안 쿠키 보관
	            }else{ // ID 저장하기 체크 해제 시,
	                deleteCookie("key");
	            }
	        });
	         
	        // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	        $("#memberId").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	            if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	                setCookie("key", $("#memberId").val(), 7); // 7일 동안 쿠키 보관
	            }
	        });
	    });
	     
	    function setCookie(cookieName, value, exdays){
	        var exdate = new Date();
	        exdate.setDate(exdate.getDate() + exdays);
	        var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	        document.cookie = cookieName + "=" + cookieValue;
	    }
	     
	    function deleteCookie(cookieName){
	        var expireDate = new Date();
	        expireDate.setDate(expireDate.getDate() - 1);
	        document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	    }
	     
	    function getCookie(cookieName) {
	        cookieName = cookieName + '=';
	        var cookieData = document.cookie;
	        var start = cookieData.indexOf(cookieName);
	        var cookieValue = '';
	        if(start != -1){
	            start += cookieName.length;
	            var end = cookieData.indexOf(';', start);
	            if(end == -1)end = cookieData.length;
	            cookieValue = cookieData.substring(start, end);
	        }
	        return unescape(cookieValue);
	    }
	 
	    
	 
	</script>

</body>
</html>