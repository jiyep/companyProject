<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/member/join.css">
<style type="text/css">
/* 마이페이지에 있는 버튼 */
.page_button_wrap{
	margin-top: 40px;
	text-align: center;
}
.page_button{
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
			<div class="wrap">
				<div class="subjecet">
					<span>회원정보</span>
				</div>
			<form id="info_form"  method="post">	
				<div class="user_wrap">
					<div class="user_name">이름</div>
					<div class="user_input_box">
						<input class="user_input" name="memberName" value="${member.memberName}" readonly="true">
					</div>
				</div>
				
				<div class="id_wrap">
					<div class="id_name">아이디</div>
					<div class="id_input_box">
						<input class="id_input" name="memberId" value="${member.memberId}" readonly="true">
					</div>
				</div>
				
				<div class="tel_wrap">
					<div class="tel_name">전화번호</div>
					<div class="tel_input_box">
						<input class="tel_input" name="memberTel" value="${member.memberTel}" readonly="true">
					</div>
				</div>
				<br>

				<div class="email_wrap">
					<div class="email_name">이메일</div>
					<div class="email_input_view_box">
						<input class="email_input" name="memberEmail" value="${member.memberEmail}" readonly="true">
					</div>
				</div>
				
				<div class="route_wrap">
					<div class="route_name">유입경로</div>
					<div class="route_input_box">
						<input class="route_input" name="memberRoute" value="${member.memberRoute}" readonly="true">
					</div>
				</div>
				
				<div class="select_wrap">
					<div class="select_name">약관동의</div>
					<div>
						<input type="checkbox" id="c1" name="memberAgreeES"  value="${member.memberAgreeES}" onclick="return false;" ><label>필수 이용약관동의* &nbsp</label>
						<input type="checkbox" id="c2" name="memberAgreeSNS" value="${member.memberAgreeSNS}" onclick="return false;"><label>sns 수신동의 (선택) &nbsp</label>
						<input type="checkbox" id="c3" name="memberAgreeOther" value="${member.memberAgreeOther}" onclick="return false;"><label>기타 이용약관동의(선택) &nbsp</label>
					</div>
				</div>
			
				<div class="page_button_wrap">
					<input type="submit" formaction="/board/myWrite" class="page_button" value="나의 게시글">

					<input type="button"  onclick="location.href='/member/modify'" class="page_button" style="float:right;" value="수정하기">
					<br>
				</div>			
			</form>		
				<br>
				<br>
				<br>
				<div class="join_button_wrap">
					<h3><a href="main">메인으로</a></h3>
				</div>	
			</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script>
	
		var c1 = $("#c1").val();
		var c2 = $("#c2").val();
		var c3 = $("#c3").val();
		
		if(c1=="Y")
			$("#c1").prop("checked", true);
		if(c2=="Y")
			$("#c2").prop("checked", true);
		if(c3=="Y")
			$("#c3").prop("checked", true);
	</script>

</body>
</html>