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
function goResignation(){
	const frm = document.memberResignation_frm;
    frm.action = "<%= ctxPath%>/member/memberResignation.bz";
    frm.method = "POST";
    frm.submit();   	
}
     
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
   			 <td colspan="2"><button type="button" class="btn btn-sm btn-danger text-right" onclick="goResignation()">회원 탈퇴 시키기</button></td>
		   	 </tr>	         
		</table>
	</c:if>


<c:if test="${requestScope.method == 'POST'}">
   
   <div style="margin-top:5%; text-align: center; font-size: 14pt; color: red;">
	   <c:if test="${requestScope.n == 1}">
	      사용자 ID ${requestScope.mvo.user_id}님이 탈퇴되었습니다.
	      
	   </c:if>
	   
	   <c:if test="${requestScope.n == 0}">
	      SQL구문 오류가 발생되어 회원을 탈퇴 시킬 수 없습니다.
	   </c:if>
   </div>
</c:if>
    <div class="text-center my-5">
       <button type="button" class="btn btn-secondary" onclick="javascript:location.href='memberList.bz'">회원목록[처음으로]</button> 
    </div>
		    
</div>



<form name="memberResignation_frm">
	<input type="hidden" name="user_id" value="${requestScope.mvo.user_id}" />
</form>


<jsp:include page="../../footer_suc.jsp" />    