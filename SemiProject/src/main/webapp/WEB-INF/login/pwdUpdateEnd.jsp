<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/template/template.css" />

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<style type="text/css">
  div.div_pwd {
  	width: 70%;
	height: 15%;
	margin-bottom: 5%;
	margin-left: 10%;
  }

</style>

<script type="text/javascript">
  $(document).ready(function(){
	  
	  $("button.btn-success").click(function(){
		  
		  const pwd  = $("input:password[name='pwd']").val();
		  const pwd2 = $("input:password[id='pwd2']").val();
		  
		  if(pwd != pwd2) {
			  alert("암호가 일치하지 않습니다.");
			  $("input:password[name='pwd']").val("");
			  $("input:password[id='pwd2']").val("");
			  return; // 종료
		  }
		  else {
			  
			  const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			    // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성 
			    
			  const bool = regExp_pwd.test(pwd);	
				
			  if(!bool) {
					// 암호가 정규표현식에 위배된 경우
					alert("암호는 8글자 이상 15글자 이하에 영문자,숫자,특수기호가 혼합되어야만 합니다.");
					$("input:password[name='pwd']").val("");
					$("input:password[id='pwd2']").val("");
					return; // 종료
			  }
			  else {
				   // 암호가 정규표현식에 맞는 경우
				   const frm = document.pwdUpdateEndFrm;
				   frm.action = "<%= ctxPath%>/login/pwdUpdateEnd.bz";
				   frm.method = "post";
				   frm.submit();
			  }
			  
		  }
		  
	  });// end of $("button.btn-success").click()--------
	  
  });// end of $(document).ready(function(){})-------------
 
 
</script>

<body style="background-image: url('<%= ctxPath%>/img/index_bg.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
<!-- background-repeat: no-repeat;를 적용하면 배경 이미지가 한 번만 표시됩니다: -->


<c:if test="${requestScope.method == 'GET'}">

	<h2 class="text-center text-white mt-5">암호를 변경해주세요</h2>
	     
	<form name="pwdUpdateEndFrm" class="text-center">
	
	   <div class="div_pwd mt-5 mx-auto" style="text-align: center;">
	      <span style="color: blue; font-size: 14pt;">새암호</span><br/> 
	      <input type="password" name="pwd" size="25" /><br/> 
	      <span style="color: blue; font-size: 14pt;">새암호확인</span><br/>
	      <input type="password" id="pwd2" size="25" />
	      <button type="button" class="btn btn-success mt-5 mx-auto">암호 변경하기</button> &nbsp; &nbsp;
	      
	   </div>
	   
	   <input type="hidden" name="user_id" value="${requestScope.user_id}">
	   
	   <div>
<%--      <button type="button" class="btn btn-danger" onclick="javascript:location.href='<%= ctxPath%>/index.bz'">다음에 변경하기</button>--%>
	      
	   </div>
	</form>
</c:if>



<c:if test="${requestScope.method == 'POST'}">
   
   <div style="text-align: center; font-size: 20pt; color: white;" class="mt-5">
	   <c:if test="${requestScope.n == 1}">
	      사용자 ID ${requestScope.user_id}님의<br> 비밀번호가 변경되었습니다. 
	      
	   </c:if>
	   
	   <c:if test="${requestScope.n == 0}">
	      SQL구문 오류가 발생되어 비밀번호 변경을 할 수 없습니다.
	   </c:if>
   </div>
</c:if>
