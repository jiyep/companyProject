<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  <style>
<style type="text/css">
body{
	margin: 0 auto;
}
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
.select_img img{ margin : 20px 0; }

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

	<form id="write_form" method="post" enctype="multipart/form-data">
         <div class="form-group">
            <label for="exampleFormControlInput1">제목*</label>
            <input type="text" class="form-control" id="title_input" name="title" >
          </div>
         <div class="form-group">
            <label for="exampleFormControlInput1">이름</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="writer" value="${member.memberName}" readonly="true">
          </div>
          <div class="form-group">
            <label for="exampleFormControlInput1">아이디</label>
            <input type="hidden" class="form-control" id="exampleFormControlInput1" name="memberId" value="${member.memberId}" >
          </div>
          <div class="form-group">
            <label for="exampleFormControlTextarea1">내용</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" name="content" rows="10"></textarea>
          </div>
          <div class="form-group">
            <label for="exampleFormControlInput1">이미지</label>
             <input type="file"  id="fileName" name="uploadFile">
             <div class="select_img"><img  src="" ></div>
          </div>
        <input type="button" class="write_button" value="등록하기">
        <a class="btn" id="list_btn" class="btn btn-secondary" href="/board/boardList">게시글 목록</a>
    </form>

	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script type="text/javascript">
	
	var titleCheck = false;
	
	 	$(document).ready(function(){

			$(".write_button").click(function(){
				
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

					$("#write_form").attr("action", "/board/boardWrite");
					$("#write_form").submit();			
					
				}		
				
				return false;

			});
		});	
		
	 	 //이미지 보여주기
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