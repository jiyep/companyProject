<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<link rel="stylesheet" href="/resources/css/member/join.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous">
</script>
<style type="text/css">
/* 수정하기 페이지에 있는 버튼 */
.modify_button_wrap{
	margin-top: 40px;
	text-align: center;
}
.modify_button{
	float : left;
	width: 48%;
    height: 80px;
    background-color: #6AAFE6;
    font-size: 40px;
    font-weight: 900;
    color: white;
}
</style>


</head>
<body>

	<div class="wrapper">
		<form id="modify_form"  method="post">
			<div class="wrap">
				<div class="subjecet">
					<span>회원정보 수정</span>
				</div>
				<br>

				<div class="id">
					<div class="id_name">아이디 (수정불가)</div>
					<div class="id_input_box">
						<input class="id_input" name="memberId" value="${member.memberId}" readonly="true">
					</div>
				</div>		
				
				<div class="pw_wrap">
					<div class="pw_name">비밀번호</div>
					<div class="pw_input_box">
						<input class="pw_input" type="password" name="memberPw">
					</div>
					<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
				</div>
				<div class="pwck_wrap">
					<div class="pwck_name">비밀번호 확인</div>
					<div class="pwck_input_box">
						<input  type="password" class="pwck_input">
					</div>
					<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
					<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
                	<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
				</div>
				
				<div class="user_wrap">
					<div class="user_name">이름 (수정불가)</div>
					<div class="user_input_box">
						<input class="user_input" name="memberName" value="${member.memberName}" readonly="true">
					</div>
				</div>

				<div class="tel_wrap">
					<div class="tel_name">전화번호</div>
					<div class="tel_input_box">
						<input class="tel_input" name="memberTel"  oninput="autoHyphen(this)" maxlength="13"  value="${member.memberTel}">
					</div>
					<span class="final_tel_ck" style="display:none">전화번호를 입력해주세요.</span>
					<span class="final_tel_lan_ck" style="display:none; color : red;">올바른 형식으로 입력해주세요.(ex. 010-0000-0000)</span>
				</div>
				
				<br>

				<div class="email_wrap">
					<div class="email_name">이메일</div> 
					<div class="email_input_view_box">
						<input class="email_input" name="memberEmail" value="${member.memberEmail}">
						<input type="hidden"  class="oriMemberEmail" value="${member.memberEmail}">
					</div>
					<span class="final_email_ck" style="display:none">이메일을 입력해주세요.</span>	
					<span class="email_input_re_2" style="display:none">사용중인 이메일 입니다.</span>	
					<span class="email_input_warn" style="display:none; color:red;">올바른 형식으로 입력해주세요.(ex. ex01@naver.com)</span>	
				</div>
				
				<div class="select_wrap">
					<div class="select_name">약관동의</div>
					<div>
						<input type="checkbox" id="cboxAll" name="cboxAll" onclick="checkAll();"><label>전체선택</label>
						<br>
						<input type="checkbox"  class="c2" id="cbox" >
						<input type="hidden" id="hiddenC2" name="memberAgreeSNS" value="${member.memberAgreeSNS}" ><label>SNS수신 동의 &nbsp</label>
						<input type="checkbox"  class="c3" id="cbox" >
						<input type="hidden" id="hiddenC3" name="memberAgreeOther"  value="${member.memberAgreeOther}" ><label>기타 이용약관 동의 &nbsp</label>
					</div>
				</div>
				
				<div class="modify_button_wrap">
					<input type="submit" class="modify_button" value="수정하기">

					<input type="submit" formaction="/member/delete.do" class="modify_button" style="float:right;" value="탈퇴하기">
				</div>					
			</div>
		</form>
	</div>
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script>
	
	
	/* 유효성 검사 통과유무 변수 */
	var pwCheck = false;			
	var pwckCheck = false;			// 비번 확인
	var pwckcorCheck = false;		// 비번 확인 일치 확인
	var telCheck = false; 			// 전화번호
	var telLanCheck = false; 		// 전화번호 길이 확인
	var emailCheck = false; 		// 이메일
	var emailckCheck = false;		// 이메일  중복
	var emailWarnCheck = false;		// 이메일 형식 확인
	
	
	
	//이용약관 미리 체크 
	var c2 = $("#hiddenC2").val();
	var c3 = $("#hiddenC3").val();
	
	if(c2=="Y")
		$(".c2").prop("checked", true);
	if(c3=="Y")
		$(".c3").prop("checked", true);



	$(document).ready(function(){
		//회원가입 버튼(회원가입 기능 작동)
		$(".modify_button").click(function(){
			
			/* 입력값 변수 */
			var pw = $('.pw_input').val();				// 비밀번호 입력란
			var pwck = $('.pwck_input').val();			// 비밀번호 확인 입력란
			var mail = $('.email_input').val();			// 이메일 입력란
			var orimail = $('.oriMemberEmail').val();	// 이메일 입력란
			var tel = $('.tel_input').val();			// 전화번호 입력란

			
			
			
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

			
			/* 전화번호 유효성 검사 */
			if(tel == ""){
				$('.final_tel_ck').css('display','block');
				telCheck = false;
			}else{
				$('.final_tel_ck').css('display', 'none');
				telCheck = true;
			}		
			
			/*전화번호 길이 검사*/
			if(tel.length < 13){
				$('.final_tel_lan_ck').css('display','block');
				telLanCheck = false;
			}else{
				$('.final_tel_lan_ck').css('display', 'none');
				telLanCheck = true;
			}
			
			/* 이메일 유효성 검사 */
			if(mail == ""){
				$('.final_email_ck').css('display','block');
				emailCheck = false;
			}else{
				$('.final_email_ck').css('display', 'none');
				emailCheck = true;
			}			
			
			//이메일 중복 검사
			var data = {memberEmail : mail};				// '컨트롤에 넘길 데이터 이름' : '데이터(.mail_input에 입력되는 값)'
			var ckval = false;
			
			if(mail != orimail){     //입력값이 변경되었으면
				
				//이매일 형식 검사
				var email_rule =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;  //이메일 형식 
				
				if(!email_rule.test(mail)){
					$('.email_input_warn').css('display','block');
					$('.email_input_re_2').css("display", "none");	
					$('.final_email_ck').css('display', 'none');
					emailWarnCheck=false;
				}else{
					$('.email_input_warn').css('display','none');
					emailWarnCheck=true;
					
					$.ajax({
						type : "post",
						url : "/member/memberEmailChk",
						data : data,
						success : function(result){
							
							if( mail == ""){
								$('.final_email_ck').css('display','block');
								$('.email_input_re_2').css("display", "none");
								$('.email_input_warn').css('display','none');
							}else if(result == 'fail' ){
								$('.email_input_re_2').css("display","inline-block");
								$('.final_email_ck').css('display', 'none');
								$('.email_input_warn').css('display','none');
								emailckCheck = false;
							} else {
								$('.email_input_re_2').css("display", "none");	
								$('.final_email_ck').css('display', 'none');
								emailckCheck = true;
							}	
						}// success 종료
					}); // ajax 종료	
				}		
			}else{     //변경된 값이 없으면
				emailckCheck = true;
				emailWarnCheck=true;
			}
			
			/* 최종 유효성 검사 */
			if(pwCheck&&pwckCheck&&pwckcorCheck&&telCheck&&telLanCheck&&emailCheck&&emailckCheck&&emailWarnCheck){

				$("#modify_form").attr("action", "/member/modify");
				$("#modify_form").submit();			
				
			}		
			
			return false;

		});
	});	
	
	
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
	
	//휴대폰 번호 하이픈 함수
	const autoHyphen = (target) => {
		 target.value = target.value
		  .replace(/[^0-9]/g, '')
		  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
		}
	
	
	
	//전체선택
	function checkAll() {
		if($("#cboxAll").is(':checked')) {
			$("input:checkbox").prop("checked", true);
			$("#hiddenC2").val("Y");
			$("#hiddenC3").val("Y");
		} else {
			$("input:checkbox").prop("checked", false);
			$("#hiddenC2").val("N");
			$("#hiddenC3").val("N");
		}
	}
	
	
	//하나가 체크 해지되면 '전체선택' 체크 해지
	$(document).on("click", "input:checkbox[id=cbox]", function(e) {
		
		var chks = document.getElementById("cbox");
		var chksChecked = 0;
		
		
		for(var i=0; i<chks.length; i++) {
			var cbox = chks[i];
			
			if(cbox.checked) {
				chksChecked++;
			}
		}
		
		if(chks.length == chksChecked){
			$("#cboxAll").prop("checked", true);
		}else{
			$("#cboxAll").prop("checked",false);
		}
		
	});	
	
	//체크박스 vlaue값 변경
	$(document).on("click", "input[class='c2']", function(e) {
		if($(".c2").is(':checked')){
			$("#hiddenC2").val("Y");
		}else{
			$("#hiddenC2").val("N");
		}
	});	
	$(document).on("click", "input[class='c3']", function(e) {
		if($(".c3").is(':checked')){
			$("#hiddenC3").val("Y");
		}else{
			$("#hiddenC3").val("N");
		}
	});	

	</script>
	
</body>
</html>