<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  <style>
<style type="text/css">
.input_wrap{
	padding: 5px 20px;
}
label{
    display: block;
    margin: 10px 0;
    font-size: 20px;	
}
input{
	padding: 5px;
    font-size: 17px;
}
textarea{
	width: 800px;
    height: 200px;
    font-size: 15px;
    padding: 10px;
}
.oriImf { width : 150px; height: auto;}
.btn{
  	display: inline-block;
    font-size: 22px;
    padding: 6px 12px;
    background-color: #fff;
    border: 1px solid #ddd;
    font-weight: 600;
    width: 140px;
    height: 41px;
    line-height: 39px;
    text-align : center;
    margin-left : 30px;
    cursor : pointer;
}
.btn_wrap{
	padding-left : 80px;
	margin-top : 50px;
}
</style>
</head>
<body>


	<h1>상세 페이지</h1>
		<div class="input_wrap">
			<label>글번호</label>
			<input name="bno"   readonly="readonly" value='<c:out value="${view.bno}"/>' >
		</div>
		<div class="input_wrap">
			<label>제목</label>
			<input name="title"   readonly="readonly" value='<c:out value="${view.title}"/>' >
		</div>
		<div class="input_wrap">
			<label>이름</label>
			<input name="writer" readonly="readonly" value='<c:out value="${view.writer}"/>' >
		</div>
		<div class="input_wrap">
			<label>내용</label>
			<textarea rows="3" name="content"  readonly="readonly" ><c:out value="${view.content}"/></textarea>
		</div>
		<c:if test = "${ view.fileName  != null }">
			<div class="input_wrap">
				<label>이미지 <a href="fileDownload.do?fileName=${view.fileName}">[다운로드]</a></label>
				<img  src="${view.origiFile}" class="oriImg">
			</div>
		</c:if>
		
		<div class="btn_wrap">
	        <!--작성자와 일치 하지 않은 상태 and 로그인 하지 않았을 때 -->
	        <c:if test = "${member.memberId != view.memberId }">
	        	<a class="btn" id="list_btn">목록 페이지</a>
	        </c:if>
	        
	        <!-- 작성자와 일치한 상태 -->
	        <c:if test = "${member.memberId == view.memberId }">
	        	<a class="btn" id="list_btn">목록 페이지</a>
				<a class="btn" id="modify_btn"  href='/board/modifyBoard?bno=${view.bno}'>게시글 수정</a>
				<a class="btn" id="list_btn" href="/board/boardDelete.do?bno=${view.bno}">게시글 삭제</a>
	        </c:if>   
		</div>


		<form id="infoForm" method="get">
			<input type="hidden" id="bno" name="bno" value="${view.bno }">
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }">	
			<input type="hidden" name="keyword" value="${cri.keyword }">	
		</form>

		<script type="text/javascript">
			
			let form = $("#infoForm")
			
			$("#list_btn").on("click", function(e){
				form.find("#bno").remove();
				form.attr("action", "/board/boardList");
				form.submit();
			});
		
		</script>

</body>
</html>