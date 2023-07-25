<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="/resources/css/member/join.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous">
</script>
</head>
<body>

	<div class="wrapper">
		<form id="join_form" method="post">
			<div class="wrap">
				<div class="subjecet">
					<span>회원가입</span>
				</div>
				<br>
				<div class="id">
					<div class="id_name">아이디</div>
					<div class="id_input_box">
						<input class="id_input" name="memberId">
					</div>
					<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
					<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
					<span class="final_id_ck">아이디를 입력해주세요.</span>
				</div>
				<div class="pw_wrap">
					<div class="pw_name">비밀번호</div>
					<div class="pw_input_box">
						<input class="pw_input" name="memberPw">
					</div>
					<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
				</div>
				<div class="pwck_wrap">
					<div class="pwck_name">비밀번호 확인</div>
					<div class="pwck_input_box">
						<input class="pwck_input">
					</div>
					<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
					<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
                	<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
				</div>
				<div class="user_wrap">
					<div class="user_name">이름</div>
					<div class="user_input_box">
						<input class="user_input" name="memberName">
					</div>
					<span class="final_name_ck">이름을 입력해주세요></span>
				</div>
				<div class="tel_wrap">
					<div class="tel_name">전화번호</div>
					<div class="tel_input_box">
						<input class="tel_input" name="memberTel">
					</div>
					<span class="final_tel_ck">전화번호를 입력해주세요</span>
				</div>
				
				<div class="route_wrap">
					<div class="route_name">유입경로</div>
					<div class="route_input_box">
						<input class="route_input" name="memberRoute">
					</div>			
					<span class="final_route_ck">유입경로를 입력해주세요</span>
				</div>	
				
				<div class="select_wrap">
					<div class="select_name">이용약관</div>
					<div>
						<input type='checkbox' name='all' value='selectall' onclick='selectAll(this)'/> 
						<b>전체 선택하기</b>
					</div>
					<div>
						<input type="checkbox" id="agree" name="agree" style="margin: 0.4rem;" onclick='is_checked()'>
						<label for="agree">필수 이용약관 동의(필수)</label>						
					</div>
					<div>
						<input type="checkbox" id="emailck" name="emailck" style="margin: 0.4rem;">
						<label for="emailck">이메일 수신 동의(선택)</label>				
					</div>
					<div>
						<input type="checkbox" id="snsck" name="snsck" style="margin: 0.4rem;">
						<label for="snsck">SNS 수신 동의(선택)</label>						
					</div>
				</div>
		
				<div class="join_button_wrap">
					<input type="submit" class="join_button" value="가입하기">
				</div>						
			</div>
		</form>

	</div>

	<script>
	
		 /* 유효성 검사 통과유무 변수 */
		 var idCheck = false;            // 아이디
		 var idckCheck = false;            // 아이디 중복 검사
		 var pwCheck = false;            // 비번
		 var pwckCheck = false;            // 비번 확인
		 var pwckcorCheck = false;        // 비번 확인 일치 확인
		 var nameCheck = false;            // 이름
		 var telCheck = false;            // 전화번호
		 var routeCheck = false;        // 유입경로

		 $(selectCheck).is(":checked");
		
		$(document).ready(function(){
			
			//회원가입 버튼(회원가입 기능 작동)
			$(".join_button").click(function(){
				/* 입력값 변수 */
		        var id = $('.id_input').val();                 // id 입력란
		        var pw = $('.pw_input').val();                // 비밀번호 입력란
		        var pwck = $('.pwck_input').val();            // 비밀번호 확인 입력란
		        var name = $('.user_input').val();            // 이름 입력란
		        var tel = $('.tel_input').val();            // 전화번호 입력란
		        var route = $('.route_input').val();         // 유입경로 입력란
		        
		        /* 아이디 유효성검사 */
			     if(id == ""){
			         $('.final_id_ck').css('display','block');
			         idCheck = false;
			     }else{
			         $('.final_id_ck').css('display', 'none');
			         idCheck = true;
			     }
			 
		     /* 비밀번호 유효성 검사 */
		        if(pw == ""){
		            $('.final_pw_ck').css('display','block');
		            pwCheck = false;
		        }else{
		            $('.final_pw_ck').css('display', 'none');
		            pwCheck = true;
		        }
		     /* 비밀번호 확인 유효성 검사 */
		        if(pwck == ""){
		            $('.final_pwck_ck').css('display','block');
		            pwckCheck = false;
		        }else{
		            $('.final_pwck_ck').css('display', 'none');
		            pwckCheck = true;
		        }
		     
		     /* 이름 유효성 검사 */
		        if(name == ""){
		            $('.final_name_ck').css('display','block');
		            nameCheck = false;
		        }else{
		            $('.final_name_ck').css('display', 'none');
		            nameCheck = true;
		        }
		     

		     /* 전화번호 유효성 검사 */
		        if(tel == ""){
		            $('.final_tel_ck').css('display','block');
		            telCheck = false;
		        }else{
		            $('.final_tel_ck').css('display', 'none');
		            telCheck = true;
		        }
		     

			  /* 유입경로 유효성 검사 */
			     if(route == ""){
			         $('.final_route_ck').css('display','block');
			         routeCheck = false;
			     }else{
			         $('.final_route_ck').css('display', 'none');
			         routeCheck = true;
			     }
				
		     
		     /* 최종 유효성 검사 */
		        if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&nameCheck&&telCheck&&routeCheck){
		        	
		        	$("#join_form").attr("action", "/member/join");
		            $("#join_form").submit(); 	
		        }   
		         
		        return false;

			});
		});
		
		//아이디 중복검사
		$('.id_input').on("propertychange change keyup paste input", function(){
			
			//console.log("keyup 테스트");
	
			
			var memberId = $('.id_input').val();			// .id_input에 입력되는 값
			var data = {memberId : memberId}				// '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'
			
			$.ajax({
				type : "post",
				url : "/member/memberIdChk",
				data : data,
				success : function(result){
					
					// console.log("성공 여부" + result);
					if(result != 'fail'){
						$('.id_input_re_1').css("display","inline-block");
						$('.id_input_re_2').css("display", "none");	
						idckCheck = true;
					} else {
						$('.id_input_re_2').css("display","inline-block");
						$('.id_input_re_1').css("display", "none");		
						idckCheck = false;
					}
					
				}// success 종료
				
			}); // ajax 종료

		});// function 종료
		
		 
		/* 비밀번호 확인 일치 유효성 검사 */	 
		$('.pwck_input').on("propertychange change keyup paste input", function(){
		    var pw = $('.pw_input').val();
		    var pwck = $('.pwck_input').val();
		    $('.final_pwck_ck').css('display', 'none');  	
		    
		    if(pw == pwck){
		        $('.pwck_input_re_1').css('display','block');
		        $('.pwck_input_re_2').css('display','none');
		        pwckcorCheck = true;
		    }else{
		        $('.pwck_input_re_1').css('display','none');
		        $('.pwck_input_re_2').css('display','block');
		        pwckcorCheck = false;
		    }        
		});    
		
		/*이용약관 전체선택*/
		function selectAll(selectAll)  {
			  const checkboxes 
			     = document.querySelectorAll('input[type="checkbox"]');
			  
			  checkboxes.forEach((checkbox) => {
			    checkbox.checked = selectAll.checked
			  })
			}
	
	</script>
	
</body>
</html>