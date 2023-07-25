<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/member/join.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>

<div class="wrapper">
	<form id="join_form" method="post">
	<div class="wrap">
			<div class="subjecet">
				<span>회원가입</span>
			</div>
			
			<div class="id_wrap">
				<div class="id_name">아이디*</div>
				<div class="id_input_box">
					<input class="id_input" id="memberId">
					<input type="hidden" id="hiddenMemberId" name="memberId">
				</div>
				<div class="id_check_box">
					<input type="button" class="id_check_button" value="중복확인">
				</div>
				<span class="final_id_ck">아이디를 입력해주세요.</span>
				<span class="final_idck_ck">아이디 중복체크를 해주세요</span>		
				<span class="id_input_re_1" >사용 가능한 아이디입니다.</span>
				<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
			</div>
			
			<div class="pw_wrap">
				<div class="pw_name">비밀번호*</div>
				<div class="pw_input_box">
					<input class="pw_input" type="password"  name="memberPw">
				</div>
				<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
			</div>
			
			<div class="pwck_wrap">
				<div class="pwck_name">비밀번호 확인</div>
				<div class="pwck_input_box">
					<input class="pwck_input" type="password">
				</div>
				<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
				<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
				<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
			</div>
			
			<div class="user_wrap">
				<div class="user_name">이름*</div>
				<div class="user_input_box">
					<input class="user_input" name="memberName" value="${memberName}" readonly="true">
				</div>
				<span class="final_name_ck">이름을 입력해주세요.</span>
			</div>
			
			<div class="tel_wrap">
				<div class="tel_name">전화번호*</div>
				<div class="tel_input_box">
					<input class="tel_input" name="memberTel" oninput="autoHyphen(this)" maxlength="13" value="${memberTel}" >
				</div>
				<span class="final_tel_ck" style="display:none">전화번호를 입력해주세요.</span>
			</div>
			
			<br>
			
			<div class="email_wrap">
				<div class="email_name">이메일*</div> 
				<div class="email_input_view_box">
					<input class="email_input" name="memberEmail" value="${memberEmail}" readonly="true"> 
				</div>	
			</div>
			
			<div class="route_wrap">
				<div class="route_name">유입경로*</div>
				<div>
					<input type="checkbox" class="check_button" name="memberRoute" value="네이버"><label>네이버 &nbsp</label>
					<input type="checkbox" class="check_button" name="memberRoute" value="인스타그램"><label>인스타그램 &nbsp</label>
					<input type="checkbox" class="check_button" name="memberRoute" value="페이스북"><label>페이스북 &nbsp</label>
					<input type="checkbox" class="check_button" name="memberRoute" value="유튜브"><label>유튜브 &nbsp</label>
					<input type="checkbox" class="check_button" name="memberRoute" value="기타"><label>기타 &nbsp</label>
				</div>
				<span class="final_route_ck" style="display:none">유입경로를 선택해 주세요.</span>
			</div>
			
			<div class="select_wrap">
				<div class="select_name">약관동의</div>
				<div>
					<input type="checkbox" id="cboxAll" name="cboxAll" onclick="checkAll();"><label>전체선택</label>
					<br>
					<input type="checkbox" name="memberAgreeES" id="cbox" value="Y"><input type="hidden" name="memberAgreeES" id="ES_hidden" value="N"><label>필수 이용약관동의* &nbsp</label>
					<input type="checkbox" name="memberAgreeSNS" id="cbox" value="Y"><input type="hidden" name="memberAgreeSNS" id="SNS_hidden" value="N"><label>SNS수신 동의 &nbsp</label>
					<input type="checkbox" name="memberAgreeOther" id="cbox" value="Y"><input type="hidden" name="memberAgreeOther" id="Other_hidden" value="N"><label>기타 이용약관 동의 &nbsp</label>
				</div>
				<span class="final_agree_ck" style="display:none">필수이용약관에 동의 해주세요.</span>
			</div>

			
			<div class="join_button_wrap">
				<input type="button" class="join_button" value="가입하기">
			</div>
		</div>
	</form>
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	
	/* 유효성 검사 통과유무 변수 */
	var idCheck = false;			// 아이디
	var idckCheck = false;			// 아이디 중복 검사
	var pwCheck = false;			// 비번
	var pwckCheck = false;			// 비번 확인
	var pwckcorCheck = false;		// 비번 확인 일치 확인
	var routeCheck = false;         // 이용약관동의
	var telCheck = false 			// 전화번호
	var telLanCheck = false 		// 전화번호 길이 확인


	

	$(document).ready(function(){
		//회원가입 버튼(회원가입 기능 작동)
		$(".join_button").click(function(){
			
			/* 입력값 변수 */
			var id = $('.id_input').val(); 				// id 입력란
			var pw = $('.pw_input').val();				// 비밀번호 입력란
			var pwck = $('.pwck_input').val();			// 비밀번호 확인 입력란
			var tel = $('.tel_input').val();			// 전화번호 입력란
			var checkES;                                //필수약관동의 체크확인
			
			/* 아이디 유효성검사 */
			if(id == "" && idckCheck==false){
				$('.final_id_ck').css('display','block');
				idCheck = false;
			}else if(idckCheck==false){
				$('.final_idck_ck').css('display','block');
				$('.final_id_ck').css('display', 'none');
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
				$('.final_tel_ck').css('display','block');
				telLanCheck = false;
			}else{
				$('.final_tel_ck').css('display', 'none');
				telLanCheck = true;
			}


			/*유입경로 유효성 검사*/
			if($('input[name="memberAgreeES"]').is(":checked")==false){
				$('.final_agree_ck').css('display','block');
				routeCheck = false;
			}else{
				$('.final_agree_ck').css('display', 'none');
				routeCheck = true;
			}
			
			
			//필수체크사항 확인
			if($('input[name="memberRoute"]').is(":checked")==false){
				$('.final_route_ck').css('display','block');
				checkES = false;
			}else{
				$('.final_route_ck').css('display', 'none');
				checkES = true;
			}
			
			/* 최종 유효성 검사 */
			if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&telCheck&&telLanCheck&&routeCheck&&checkES){

				$("#join_form").attr("action", "/member/snsJoin");
				$("#join_form").submit();			
				
			}		
			
			return false;

		});
	});	
	
	
	//아이디 중복검사
	$(".id_check_button").click(function(){
		
		var memberId = $('.id_input').val();			// .id_input에 입력되는 값
		var data = {memberId : memberId}				// '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'
		
		$.ajax({
			type : "post",
			url : "/member/memberIdChk",
			data : data,
			success : function(result){
				if(memberId == ""){
					$('.final_id_ck').css('display', 'inline-block');
					$('.id_input_re_1').css("display","none");
					$('.id_input_re_2').css("display", "none");	
				}else if(result != 'fail'){
					$('.id_input_re_1').css("display","inline-block");
					$('.id_input_re_2').css("display", "none");	
					$('.final_id_ck').css('display', 'none');
					$('.final_idck_ck').css('display','none');
					idckCheck = true;
					$("#hiddenMemberId").val(memberId);
				} else {
					$('.id_input_re_2').css("display","inline-block");
					$('.id_input_re_1').css("display", "none");
					$('.final_id_ck').css('display', 'none');
					$('.final_idck_ck').css('display','none');
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
	
	//휴대폰 번호 하이픈 함수
	const autoHyphen = (target) => {
		 target.value = target.value
		   .replace(/[^0-9]/g, '')
		  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
		}
	
	
	
	//전체선택
	function checkAll() {
		if($("#cboxAll").is(':checked')) {
			$("input[id=cbox]").prop("checked", true);
			document.getElementById("ES_hidden").disabled = true;
			document.getElementById("SNS_hidden").disabled = true;
			document.getElementById("Other_hidden").disabled = true;
		} else {
			$("input[id=cbox]").prop("checked", false);
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

	//약관동의 value값
	$(document).on("click", "input[name='memberAgreeES']", function(e) {
		document.getElementById("ES_hidden").disabled = true;
	});	
	$(document).on("click", "input[name='memberAgreeSNS']", function(e) {
		document.getElementById("SNS_hidden").disabled = true;
	});	
	$(document).on("click", "input[name='memberAgreeOther']", function(e) {
		document.getElementById("Other_hidden").disabled = true;
	});	
	
</script>

</body>
</html>