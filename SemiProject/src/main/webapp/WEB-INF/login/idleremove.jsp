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

<script type="text/javascript">
  $(document).ready(function(){
	  
	  const method = "${requestScope.method}";
	  // console.log("확인용 method : ", method);
	  /*
	      확인용 method :  GET
	      확인용 method :  POST
	  */
				  
	  if(method == "GET") {
	  	  $("div#div_findResult").hide();
	  }
	  
	  else if(method == "POST") {
	  	  $("input:text[name='user_id']").val("${requestScope.user_id}");
	  	  $("input:text[name='user_email']").val("${requestScope.user_email}");
	  }
	  
	  $("button.btn-primary").click(function(){
		  goFind();
	  });// end of $("button.btn-success").click()---------
	  
	  
	  $("input:text[name='user_email']").bind("keyup", function(e){
		  
		  if(e.keyCode == 13) {
			  goFind();  
		  }
		  
	  });	  
	  
	  // === 인증하기 버튼 클릭시 이벤트 처리해주기 === //
	  $("button.btn-info").click(function(){
		  
		  const input_confirmCode = $("input:text[name='input_confirmCode']").val().trim(); 
		  
		  if(input_confirmCode == "") {
			  alert("인증코드를 입력하세요!!");
			  return; // 종료
		  }
		  
		  const frm = document.verifyCertificationFrm;
		  frm.userCertificationCode.value = input_confirmCode;
		  frm.user_id.value = $("input:text[name='user_id']").val();
		  
		  alert("휴면이 해제되었습니다! 암호변경 페이지로 이동합니다!");
		  frm.action = "<%= ctxPath%>/login/pwdUpdateEnd.bz";		  
		  frm.method = "get";
		  frm.submit();
	  });
	  
  });// end of $(document).ready(function(){})-------------
  
  
  // Function Declaration
  function goFind(){
	  
	  const user_id = $("input:text[name='user_id']").val().trim();
	  const user_email  = $("input:text[name='user_email']").val().trim(); 
	  
	  if(user_id=="" || user_email=="") {
		  alert("아이디와 이메일 모두 입력하세요!!");
		  return; // 종료
	  }
	  else {
		  const frm = document.idleremoveFrm;		  
		  frm.action = "<%= ctxPath%>/login/idleremove.bz"; 
		  frm.method = "post";
		  frm.submit();
	  }
	  
  }// end of function goFind()-----------------
  
</script>

<body style="background-image: url('<%= ctxPath%>/img/index_bg.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
<!-- background-repeat: no-repeat;를 적용하면 배경 이미지가 한 번만 표시됩니다: -->  
   <form name="idleremoveFrm" >
      
       <h5 class="text-white mb-3" style=" margin: 13%; font-weight:bold; font-size:18pt; text-align:center;" >계정 인증</h5>
       <p style="color:grey; text-align:center;">접속에 어려움을 겪고 있는 Battle.net 계정</p>
      <ul class="text-center" style="list-style-type: none; text-align:center;">        
         <li>
             <input type="text" id="user_id" name="user_id" size="25" style="width:31%; margin-left:33%" autocomplete="off" class="form-control" placeholder="아이디"/>
         </li>
         <br>
         <li>
              <input type="text" id="user_email" name="user_email" style="width:31%; margin-left:33%" autocomplete="off" class="form-control" placeholder="이메일"/>
         </li>
      </ul> 
   
      <div class="text-center">
         <button type="button" class="btn btn-primary mt-5" style="width:30.1%; margin-right:0.3%;">인증하기</button>
      </div>
      
   </form>


	<div class="my-3 text-center" id="div_findResult">
	    <c:if test="${requestScope.idleremove == false}">
	       <span style="color: red;">사용자 정보가 없습니다</span>
	    </c:if>
	    
	    <c:if test="${requestScope.idleremove == true && requestScope.sendMailSuccess == true}">
	       <span style="font-size: 10pt; color:white;">
	           인증코드가 ${requestScope.user_email}로 발송되었습니다.<br>
	           인증코드를 입력해주세요
	       </span>
	       <br>
	       <input type="text" name="input_confirmCode" />
	       <br><br> 
	       <button type="button" class="btn btn-info">인증하기</button>
	    </c:if>
	    
	    <c:if test="${requestScope.idleremove == true && requestScope.sendMailSuccess == false}">
	       <span style="color: red;">메일발송이 실패했습니다</span>
	    </c:if>
	</div>

	
	<%-- 인증하기 form --%>
	<form name="verifyCertificationFrm">
		<input type="hidden" name="userCertificationCode" />
		<input type="hidden" name="user_id" />
	</form>

</body>	
