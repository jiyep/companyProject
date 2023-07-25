<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
.select_img img{ width: 300px; margin: 20px 0;}
#btn{
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
	<h1>게시글 수정</h1>
	<form id="modify_form" method="post" enctype="multipart/form-data">
		<div class="input_wrap">
			<label>글번호</label>
			<input type="hidden" name="bno" value='<c:out value="${view.bno}"/>' >
		</div>
		<div class="input_wrap">
			<label>제목*</label>
			<input type="text" class="form-control" id="title_input" name="title" value="${view.title }">
		</div>
		<div class="form-group">
            <label for="exampleFormControlInput1">이름(수정불가)</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="writer" value="${member.memberName}" readonly="true">
        </div>
		<div class="input_wrap">
			<label>내용</label>
			<textarea rows="3" name="content" ><c:out value="${view.content}"/></textarea>
		</div>
		
		<!-- 등록된 이미지가 없을 때 -->
		<c:if test = "${ view.fileName  == null }">
			<div class="form-group">
            	<label >이미지</label>
             	<input type="file"  id="fileName" name="uploadFile">
             	<div class="select_img"><img  src="" ></div>
          	</div>
		</c:if>
		
		<!-- 등록된 이미지가 있을 때 -->
		<c:if test = "${ view.fileName  != null }">
			<div class="input_wrap">
				<label>이미지</label>
				<input type="file" class="form-control" id="fileName" name="uploadFile" >
				<div class="select_img">
					<img src="${view.origiFile}" >
					<input type="hidden" name="fileName" value="${view.fileName }">
					<input type="hidden" name="orifile" value="${view.origiFile }">
					<a href='#this' name='file-delete'>삭제</a>
				</div>
			</div>
		</c:if>
		
        <input type="button" class="modify_button" id="btn" value="수정하기">
    </form>


    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
    <script type="text/javascript">
    
    var titleCheck = false;
	
 	$(document).ready(function(){
 		
 		$("a[name='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });

		$(".modify_button").click(function(){
			
			/* 입력값 변수 */
			var title = $('#title_input').val(); 	

			if(title == ""){
				alert('제목을 입력해주세요.');
				titleCheck = false;
			}else{
				titleCheck = true;
			}

			/* 최종 유효성 검사 */
			if(titleCheck == true){

				$("#modify_form").attr("action", "/board/modifyBoard");
				$("#modify_form").submit();			
				
			}		
			
			return false;

		});
	});	
    
    function deleteFile(obj) {
        obj.parent(".hidden").remove();
    }
    	//선택한 파일 보여주기
    	$("#fileName").change(function(){
    	   if(this.files && this.files[0]) {
    	    var reader = new FileReader;
    	    reader.onload = function(data) {
    	     $(".select_img img").attr("src", data.target.result).width(500);        
    	    }
    	    reader.readAsDataURL(this.files[0]);
    	   }
    	 });
	</script>

</body>
</html>