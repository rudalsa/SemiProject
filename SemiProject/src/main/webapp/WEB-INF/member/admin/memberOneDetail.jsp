<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>

<jsp:include page="../../header_suc.jsp" /> 

<style type="text/css">

  table.table-bordered > tbody > tr > td:nth-child(1) {
  	 width: 25%;
  	 font-weight: bold;
  	 text-align: right;
  }

</style>

<script type="text/javascript">
  $(document).ready(function(){ 
     
     $("div#smsResult").hide();
     
     $("button#btnSend").click(()=>{
        
        console.log($("input#reservedate").val()+"  "+$("input#reservetime").val());
        // 2023-10-10  10:32
        
        let reservedate = $("input#reservedate").val();
        reservedate = reservedate.split("-").join("");
        
        let reservetime = $("input#reservetime").val();
        reservetime = reservetime.split(":").join("");
        
        const datetime = reservedate+reservetime;
        //console.log(datetime);
        //202310101137
        
        let dataObj = {};
        
        if(reservedate == "" || reservetime=="" ){
           // 문자를 바로 보내기인 경우
           dataObj = {"mobile":"${requestScope.mvo.user_phone}",
                 "smsContent":$("textarea#smsContent").val()};
           
        }
        else{
           dataObj = {"mobile":"${requestScope.mvo.user_phone}",
                 "smsContent":$("textarea#smsContent").val(),
                 "datetime":datetime};
        }
        
        $.ajax({
           url: "<%= ctxPath%>/member/smsSend.up",
           type:"post",
           data:dataObj,
           dataType:"json",
           success:function(json){
           // json은 {"group_id":"R2GWPBT7UoW308sI","success_count":1,"error_count":0} 처럼 된다.
           
              if(json.success_count == 1){
                 
                 $("div#smsResult").html("<sapn style='color:red; font-weight:bold;'>문자전송이 성공 되었습니다.</span>")
                 
              }
              else if(json.error_count != 0) {
                 $("div#smsResult").html("<sapn style='color:red; font-weight:bold;'>문자전송이 실패되었습니다.</span>")
                 }
              
              $("div#smsResult").show();
              $("textarea#smsContent").val("");
           
           },error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
             }
                         
        });
        
        
     });
     
     
     
     
  });// end of $(document).ready(function(){})-----------
</script>

<div class="container pt-5">
	<c:if test="${empty requestScope.mvo}">
		존재하지 않는 회원입니다.<br>
	</c:if>
	
	<c:if test="${not empty requestScope.mvo}">
		
		<c:set var="user_phone" value="${requestScope.mvo.user_phone}" />
		
		<p class="h3 text-center text-white mt-5 mb-4">::: ${requestScope.mvo.user_name} 님의 회원 상세정보 :::</p>
		
		<table class="table table-bordered text-white" style="width: 85%; margin: 0 auto;">
		   <tr>
		      <td>아이디&nbsp;:&nbsp;</td>
		      <td>${requestScope.mvo.user_id}</td>
		   </tr>
		   <tr>
		      <td>회원명&nbsp;:&nbsp;</td>
		      <td>${requestScope.mvo.user_name}</td>
		   </tr>
		   <tr>
		      <td>이메일&nbsp;:&nbsp;</td>
		      <td>${requestScope.mvo.user_email}</td>
		   </tr>
		   <tr>
		      <td>휴대폰&nbsp;:&nbsp;</td>
		      <td>${fn:substring(user_phone, 0, 3)}-${fn:substring(user_phone, 3, 7)}-${fn:substring(user_phone, 7, 11)}</td>
		   </tr>
		   <tr>
		      <td>우편번호&nbsp;:&nbsp;</td>
		      <td>${requestScope.mvo.user_zipcode}</td>
		   </tr>
		   <tr>
		      <td>주소&nbsp;:&nbsp;</td>
		      <td>${requestScope.mvo.user_address}&nbsp;
		          ${requestScope.mvo.user_detail_address}&nbsp;
		          ${requestScope.mvo.user_extraaddress}
		      </td>
		   </tr>
		   <tr>
		      <td>성별&nbsp;:&nbsp;</td>
		      <td>
		         <c:choose>
		            <c:when test="${requestScope.mvo.user_gender == '1'}">
		               남
		            </c:when>
		            <c:otherwise>
		               여
		            </c:otherwise>
		         </c:choose>
		      </td>
		   </tr>
		   <tr>
		      <td>생년월일&nbsp;:&nbsp;</td>
		      <td>${requestScope.mvo.user_birthday}</td>
		   </tr>
		   <tr>
		      <td>만나이&nbsp;:&nbsp;</td>
		      <td>${requestScope.mvo.user_age}&nbsp;세</td>
		   </tr>
		   <tr>
		      <td>마일리지&nbsp;:&nbsp;</td>
		      <td>
		         <fmt:formatNumber value="${requestScope.mvo.user_coin}" pattern="###,###" />&nbsp;POINT
		      </td>
		   </tr>
		   <tr>
		      <td>가입일자&nbsp;:&nbsp;</td>
		      <td>${requestScope.mvo.user_registerday}</td>
		   </tr>
		   	<tr>
		      <td colspan="2" class="deborder"><a class="btn btn-sm btn-danger" href="#">회원 탈퇴 시키기</a></td>
		   </tr>
		   
		</table>
		
		
		
	</c:if>

    <div class="text-center my-5">
       <button type="button" class="btn btn-secondary" onclick="javascript:location.href='memberList.up'">회원목록[처음으로]</button> 
       <button type="button" class="btn btn-success mx-5" onclick="javascript:history.back()">회원목록[history.back()]</button>
       <button type="button" class="btn btn-primary" onclick="javascript:location.href='<%= ctxPath%>${requestScope.goBackURL}'">회원목록[검색된결과]</button>
    </div>
    
</div>

<jsp:include page="../../footer_suc.jsp" />    