<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project Mall</title>
<link rel="stylesheet" href="resources/css/main.css">
</head>
<body>

<div class="wrapper">
	<div class="wrap">
		<div class="top_gnb_area">
			<h1></h1>
		</div>
		<div class="top_area">
			<div class="logo_area" style="background-color: #c0c0c0; ">
				<h1></h1>
			</div>
			<div class="search_area" style="background-color: #c0c0c0; ">
				<h1></h1>
			</div>
			<div class="login_area">
			
				<!-- 로그인 하지 않은 상태 -->
                <c:if test = "${member == null }">
                    <div class="login_button"><a href="/member/login">로그인</a></div>
                    <div class="login_button"><a href="/member/snslogin">소셜 계정 로그인</a></div>
                    <div class="login_button"><a href="member/join">회원가입</a></div>                
                </c:if>    
                
                <!-- 로그인한 상태 -->
                <c:if test="${ member != null }">
                    <div class="login_success_area">
                        <h3><a href="/member/mypage">마이페이지</a></h3>
                        <br>
                        <h3><a href="/member/logout.do">로그아웃</a></h3>
                    </div>
                </c:if>
                
			</div>
			<div class="clearfix"></div>			
		</div>
		<div class="navi_bar_area">
			<h1><a href="/board/boardList">게시글</a></h1>
		</div>
		<div class="content_area">
			<h1></h1>
		</div>
	</div>
</div>

</body>
</html>